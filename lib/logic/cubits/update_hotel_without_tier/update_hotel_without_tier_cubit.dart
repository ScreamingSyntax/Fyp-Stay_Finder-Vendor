import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stayfinder_vendor/data/model/model_exports.dart';
import 'package:stayfinder_vendor/data/repository/hotel_without_tier_repository.dart';

import '../../../data/api/api_exports.dart';

part 'update_hotel_without_tier_state.dart';

class UpdateHotelWithoutTierCubit extends Cubit<UpdateHotelWithoutTierState> {
  HotelWithoutTierRepository _hotelWithoutTierRepository =
      HotelWithoutTierRepository();
  UpdateHotelWithoutTierCubit() : super(UpdateHotelWithoutTierInitial());
  Future<void> updateAccommodationImage(
      {required String token, required File image, required int id}) async {
    emit(UpdateHotelWithoutTierLoading());
    Success success = await _hotelWithoutTierRepository
        .updateAccommodationImage(token: token, image: image, id: id);
    if (success.success == 0) {
      return emit(
          UpdateHotelWithoutTierError(message: success.message.toString()));
    }
    return emit(
        UpdateHotelWithoutTierSuccess(message: success.message.toString()));
  }

  Future<void> updateAccommodationDetails(
      {required Map data, required int id, required String token}) async {
    emit(UpdateHotelWithoutTierLoading());
    Success success = await _hotelWithoutTierRepository.updateAccommodation(
        token: token, data: data);
    print(success);
    if (success.success == 0) {
      return emit(UpdateHotelWithoutTierError(message: success.message!));
    }
    return emit(UpdateHotelWithoutTierSuccess(message: success.message!));
  }

  Future<void> addRoomDetails(
      {required String token,
      required Room room,
      required File roomImage,
      required String accommodationId}) async {
    emit(UpdateHotelWithoutTierLoading());
    Success success = await _hotelWithoutTierRepository.addRooms(
        token: token,
        room: room,
        roomImage: roomImage,
        accommodationId: accommodationId);
    if (success.success == 0) {
      return emit(UpdateHotelWithoutTierError(message: success.message!));
    }
    return emit(UpdateHotelWithoutTierSuccess(message: success.message!));
  }

  Future<void> updateRoomDetails(
      {required String token, required Map data}) async {
    emit(UpdateHotelWithoutTierLoading());
    Success success = await _hotelWithoutTierRepository.updateHotelRoom(
        token: token, data: data);
    if (success.success == 0) {
      return emit(UpdateHotelWithoutTierError(message: success.message!));
    }
    return emit(UpdateHotelWithoutTierSuccess(message: success.message!));
  }

  Future<void> updateRoomImage(
      {required File image, required String token, required int roomId}) async {
    emit(UpdateHotelWithoutTierLoading());
    Success success = await _hotelWithoutTierRepository.updateRoomImage(
        token: token, image: image, room_id: roomId);
    if (success.success == 0) {
      return emit(UpdateHotelWithoutTierError(message: success.message!));
    }
    return emit(UpdateHotelWithoutTierSuccess(message: success.message!));
  }

  Future<void> deleteRoom({required String token, required int roomId}) async {
    emit(UpdateHotelWithoutTierLoading());
    Success success = await _hotelWithoutTierRepository.deleteRoom(
        token: token, room_id: roomId);
    print("The is deletion succes ${success}");
    if (success.success == 0) {
      return emit(UpdateHotelWithoutTierError(message: success.message!));
    }
    return emit(UpdateHotelWithoutTierSuccess(message: success.message!));
  }

  // Future<void> updateRoo

  @override
  void onChange(Change<UpdateHotelWithoutTierState> change) {
    print(
        "The current state is ${change.currentState} and the next state is ${change.nextState}");
    super.onChange(change);
  }
}
