import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stayfinder_vendor/data/model/model_exports.dart';
import 'package:stayfinder_vendor/data/repository/repository_exports.dart';

part 'update_hotel_with_tier_state.dart';

class UpdateHotelWithTierCubit extends Cubit<UpdateHotelWithTierState> {
  HotelWithTierRepository _hotelWithTierRepository = HotelWithTierRepository();
  UpdateHotelWithTierCubit() : super(UpdateHotelWithTierInitial());
  void updateAccommodationImage(
      {required String token,
      required File image,
      required int accommodation_id}) async {
    emit(UpdateHotelWithTierLoading());
    Success success = await _hotelWithTierRepository.updateHotelImage(
        accommodation_id: accommodation_id, token: token, image: image);
    if (success.success == 0) {
      return emit(UpdateHotelWithTierError(message: success.message!));
    }
    return emit(UpdateHotelWithTierSuccess(message: success.message!));
  }

  void updateHotelTierImage(
      {required String token,
      required File image,
      required int tier_id}) async {
    emit(UpdateHotelWithTierLoading());
    Success success = await _hotelWithTierRepository.updateTierImage(
        hotelTierId: tier_id.toString(), token: token, image: image);
    if (success.success == 0) {
      return emit(UpdateHotelWithTierError(message: success.message!));
    }
    return emit(UpdateHotelWithTierSuccess(message: success.message!));
  }

  void updateAccommodationDetail(
      {required String token, required Map data}) async {
    emit(UpdateHotelWithTierLoading());
    Success success = await _hotelWithTierRepository.updateHotelDetails(
        data: data, token: token);
    if (success.success == 0) {
      return emit(UpdateHotelWithTierError(message: success.message!));
    }
    return emit(UpdateHotelWithTierSuccess(message: success.message!));
  }

  void updateHotelWithTierTierDetails(
      {required String token, required Map data}) async {
    emit(UpdateHotelWithTierLoading());
    Success success = await _hotelWithTierRepository.updateTierDetails(
        data: data, token: token);
    if (success.success == 0) {
      return emit(UpdateHotelWithTierError(message: success.message!));
    }
    return emit(UpdateHotelWithTierSuccess(message: success.message!));
  }

  void updateHotelWithTierTierRoom(
      {required String token, required Map data}) async {
    emit(UpdateHotelWithTierLoading());
    Success success =
        await _hotelWithTierRepository.updateTierRoom(data: data, token: token);
    if (success.success == 0) {
      return emit(UpdateHotelWithTierError(message: success.message!));
    }
    return emit(UpdateHotelWithTierSuccess(message: success.message!));
  }

  void deleteRoom({required String token, required roomID}) async {
    emit(UpdateHotelWithTierLoading());
    Success success = await _hotelWithTierRepository.deleteRoom(
        room_id: roomID, token: token);
    if (success.success == 0) {
      return emit(UpdateHotelWithTierError(message: success.message!));
    }
    return emit(UpdateHotelWithTierSuccess(message: success.message!));
  }

  void addTier(
      {required String token,
      required String tierName,
      required String description,
      required File image,
      required int accommodationId}) async {
    emit(UpdateHotelWithTierLoading());
    Success success = await _hotelWithTierRepository.addTier(
        token: token,
        tier_name: tierName,
        description: description,
        image: image,
        accommodationID: accommodationId.toString());
    if (success.success == 0) {
      return emit(UpdateHotelWithTierError(message: success.message!));
    }
    return emit(UpdateHotelWithTierSuccess(message: success.message!));
  }

  void addTierRooms({required Map data, required String token}) async {
    emit(UpdateHotelWithTierLoading());
    Success success =
        await _hotelWithTierRepository.addTierRoom(data: data, token: token);

    if (success.success == 0) {
      return emit(UpdateHotelWithTierError(message: success.message!));
    }
    return emit(UpdateHotelWithTierSuccess(message: success.message!));
  }

  void deleteTier({required String token, required String hotelTierId}) async {
    Success success = await _hotelWithTierRepository.deleteTier(
        hotelTierId: hotelTierId, token: token);

    if (success.success == 0) {
      return emit(UpdateHotelWithTierError(message: success.message!));
    }
    return emit(UpdateHotelWithTierSuccess(message: success.message!));
  }

  @override
  void onChange(Change<UpdateHotelWithTierState> change) {
    print("Current State ${change.currentState} next ${change.nextState}");
    // TODO: implement onChange
    super.onChange(change);
  }
}
