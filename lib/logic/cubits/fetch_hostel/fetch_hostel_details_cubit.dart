import 'package:stayfinder_vendor/data/model/model_exports.dart';
import 'package:stayfinder_vendor/data/model/room_image_model.dart';
import 'package:stayfinder_vendor/data/repository/hostel_repository.dart';
import 'package:stayfinder_vendor/logic/blocs/bloc_exports.dart';

part 'fetch_hostel_details_state.dart';

class FetchHostelDetailsCubit extends Cubit<FetchHostelDetailsState> {
  FetchHostelDetailsCubit() : super(FetchHostelDetailsInitial());
  HostelRepository _hostelRepository = HostelRepository();
  void fetchHostelAccommodation(
      {required String token, required int accommodationId}) async {
    emit(FetchHostelDetailLoading());
    Success success = await _hostelRepository.fetchHostelAccommodation(
        token: token, accommodationId: accommodationId.toString());
    if (success.success == 0) {
      return emit(FetchHostelDetailError(message: success.message!));
    }
    Map data = success.data!;
    Accommodation accommodation = Accommodation.fromMap(data['accommodation']);
    print(accommodation);
    accommodation.id = accommodationId;
    List<Room> rooms =
        List.from(data['room']).map((e) => Room.fromMap(e)).toList();
    List<RoomImage> roomImages =
        List.from(data['images']).map((e) => RoomImage.fromMap(e)).toList();
    // print("This is the data ${data}");
    print(accommodation);
    return emit(FetchHostelDetailSuccess(
        accommodation: accommodation, rooms: rooms, images: roomImages));
  }

  @override
  void onChange(Change<FetchHostelDetailsState> change) {
    print(
        "The current state is ${change.currentState} and the next state is ${change.nextState}");

    super.onChange(change);
  }
}
