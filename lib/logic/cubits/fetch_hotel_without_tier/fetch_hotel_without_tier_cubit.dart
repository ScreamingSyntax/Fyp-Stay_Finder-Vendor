import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stayfinder_vendor/data/model/model_exports.dart';
import 'package:stayfinder_vendor/data/model/room_image_model.dart';
import 'package:stayfinder_vendor/data/repository/hotel_without_tier_repository.dart';
import 'package:stayfinder_vendor/presentation/widgets/widgets_exports.dart';

part 'fetch_hotel_without_tier_state.dart';

class FetchHotelWithoutTierCubit extends Cubit<FetchHotelWithoutTierState> {
  FetchHotelWithoutTierCubit() : super(FetchHotelWithoutTierInitial());
  HotelWithoutTierRepository _hotelWithoutTierRepository =
      HotelWithoutTierRepository();
  Future<void> FetchHotel(
      {required int accommodationId, required String token}) async {
    emit(FetchHotelWithoutTierLoading());
    // print(accommodationId);
    // print(token);
    Success success = await _hotelWithoutTierRepository.fetchHotelWithoutTier(
        accommodationId: accommodationId, token: token);
    print("The data is ${success.data}");

    if (success.success == 0) {
      return emit(FetchHotelWithoutTierError(message: success.message!));
    }
    List<RoomImage> images = List.from(success.data!['images'])
        .map((e) => RoomImage.fromMap(e))
        .toList();

    return emit(FetchHotelWithoutTierSuccess(
        accommodation: Accommodation.fromMap(success.data!['accommodation']),
        room: List.from(success.data!['room'])
            .map((e) => Room.fromMap(e))
            .toList(),
        image: images));
  }

  @override
  void onChange(Change<FetchHotelWithoutTierState> change) {
    print(
        "The current state is ${change.currentState} and the next state is ${change.nextState}");
    // TODO: implement onChange
    super.onChange(change);
  }
}
