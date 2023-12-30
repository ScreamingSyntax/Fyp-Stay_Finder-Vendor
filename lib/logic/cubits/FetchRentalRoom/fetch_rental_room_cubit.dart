import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stayfinder_vendor/data/model/model_exports.dart';
import 'package:stayfinder_vendor/data/model/room_image_model.dart';
import 'package:stayfinder_vendor/data/repository/repository_exports.dart';

part 'fetch_rental_room_state.dart';

class FetchRentalRoomCubit extends Cubit<FetchRentalRoomState> {
  FetchRentalRoomCubit() : super(FetchRentalRoomInitial());
  void fetchRentalRoom(
      {required String token, required int accommodationId}) async {
    emit(FetchRentalRoomLoading());
    print("Right here is the accommodation id ${accommodationId}");
    RentalRoomRepository repo = RentalRoomRepository();
    Success success = await repo.fetchRentalRoom(
        token: token, accommodationId: accommodationId);
    if (success.success == 0) {
      return emit(FetchRentalRoomError(message: success.message!));
    } else {
      var data = success.data!['data'];
      Map<String, dynamic> accommodation = data!['accommodation'];
      Map<String, dynamic> room = data!['room'];
      List<dynamic> roomImages = data!['room_images'];
      Accommodation accommodationData = Accommodation.fromMap(accommodation);
      Room roomData = Room.fromMap(room);
      List<RoomImage> roomImagesData =
          List.from(roomImages).map((e) => RoomImage.fromMap(e)).toList();
      return emit(FetchRentalRoomSuccess(
          accommodation: accommodationData,
          room: roomData,
          roomImages: roomImagesData));
    }
  }

  @override
  void onChange(Change<FetchRentalRoomState> change) {
    print(
        "The current state is ${change.currentState} and the next state is ${change.nextState}");
    super.onChange(change);
  }
}
