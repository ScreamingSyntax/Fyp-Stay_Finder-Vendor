import 'dart:io';

import 'package:stayfinder_vendor/data/api/api_exports.dart';

import '../model/model_exports.dart';

class AccommodationAdditionRepository {
  AccommodationAdditionApi accommodationAdditionApi =
      AccommodationAdditionApi();
  Future<List<Accommodation>> getAccommodation({required String token}) async {
    return accommodationAdditionApi.fetchAccommodation(token: token);
  }

  Future<Success> reSubmitForVerification(
      {required int accommodationId, required String token}) async {
    return await accommodationAdditionApi.reSubmitForVerification(
        accommodationId: accommodationId, token: token);
  }

  Future<Success> hotelWithTierAddition(
      {required Accommodation accommodation,
      required Map<int, Tier>? tier,
      required Map<int, List<Room>>? rooms,
      required File? accommodationImage,
      required Map<int, File>? tierImages,
      required String token}) async {
    Success success = await accommodationAdditionApi.hotelWithTierAdditionApi(
        tierImages: tierImages!,
        token: token,
        accommodation: accommodation,
        accommodationImage: accommodationImage,
        rooms: rooms,
        tier: tier);
    return success;
  }

  Future<Success> hotelWithoutTierAddition(
      {required Accommodation accommodation,
      required List<Room?>? rooms,
      required File accommodationImage,
      required Map<int, List> roomImages,
      required String token}) {
    return accommodationAdditionApi.hostelWithoutTierAdditionApi(
        accommodation: accommodation,
        rooms: rooms,
        token: token,
        accommodationImage: accommodationImage,
        roomImages: roomImages);
  }

  Future<Success> hostelRoomAddition(
      {required Accommodation accommodation,
      required List<Room?> room,
      required Map<int, List> roomImages,
      required File accommodationImage,
      required String token}) async {
    return accommodationAdditionApi.addHostelRoomAddition(
        accommodation: accommodation,
        room: room,
        roomImages: roomImages,
        accommodationImage: accommodationImage,
        token: token);
  }

  Future<Success> addRentalRoom(
      {required Accommodation accommodation,
      required String token,
      required Room room,
      required File accommodationImage,
      required File roomImage1,
      required File roomImage2,
      required File roomImage3}) async {
    return accommodationAdditionApi.rentalHostelAddition(
        accommodation: accommodation,
        token: token,
        room: room,
        accommodationImage: accommodationImage,
        roomImage1: roomImage1,
        roomImage2: roomImage2,
        roomImage3: roomImage3);
  }
}
