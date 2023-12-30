import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stayfinder_vendor/data/model/model_exports.dart';
import 'package:stayfinder_vendor/data/repository/repository_exports.dart';

part 'update_accommodation_image_state.dart';

class UpdateRentalAccommodationCubit extends Cubit<UpdateRentalState> {
  RentalRoomRepository rentalRoomRepository = new RentalRoomRepository();

  UpdateRentalAccommodationCubit() : super(UpdateRentalInitial());
  void updateAccommodationImage(
      {required File image,
      required String token,
      required int accommodationId}) async {
    emit(UpdateRentalLoading());
    Success success = await rentalRoomRepository.updateAccommodationImage(
        image: image, token: token, accommodationId: accommodationId);
    if (success.success == 1) {
      return emit(UpdateRentalSuccess(message: success.message.toString()));
    }
    return emit(UpdateRentalError(message: success.message.toString()));
  }

  void updateAccommodationDetail(
      {required String token,
      required Map<String, dynamic> accommodations}) async {
    emit(UpdateRentalLoading());
    Success success = await rentalRoomRepository.updateAccommodationDetail(
        token: token, accommodations: accommodations);
    if (success.success == 1) {
      return emit(UpdateRentalSuccess(message: success.message.toString()));
    }
    return emit(UpdateRentalError(message: success.message.toString()));
  }

  void updateRoomImage(
      {required String room_id,
      required String room_image_id,
      required String token,
      required File image}) async {
    emit(UpdateRentalLoading());
    Success success = await rentalRoomRepository.updateRoomImage(
        room_id: room_id,
        room_image_id: room_image_id,
        token: token,
        image: image);
    if (success.success == 1) {
      return emit(UpdateRentalSuccess(message: success.message.toString()));
    }
    return emit(UpdateRentalError(message: success.message.toString()));
  }

  // updateAccommodationDetail
  void updateRoomDetails({required String token, required Map data}) async {
    emit(UpdateRentalLoading());
    Success success =
        await rentalRoomRepository.updateRoomDetails(token: token, data: data);
    if (success.success == 1) {
      return emit(UpdateRentalSuccess(message: success.message.toString()));
    }
    return emit(UpdateRentalError(message: success.message.toString()));
  }

  @override
  void onChange(Change<UpdateRentalState> change) {
    // TODO: implement onChange
    print("The current State is ${change.currentState}");
    super.onChange(change);
  }
}
