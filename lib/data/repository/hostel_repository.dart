import 'package:stayfinder_vendor/data/api/api_exports.dart';

import '../model/model_exports.dart';

class HostelRepository {
  HostelApiProvider _hostelApiProvider = HostelApiProvider();
  Future<Success> fetchHostelAccommodation(
      {required String token, required String accommodationId}) async {
    return await _hostelApiProvider.fetchHostelAccommodation(
        token: token, accommodationId: accommodationId);
  }

  Future<Success> updateRoomImage(
      {required String token,
      required int room_id,
      required int room_image_id,
      required File image}) async {
    return await _hostelApiProvider.updateRoomImage(
        token: token,
        room_id: room_id,
        room_image_id: room_image_id,
        image: image);
  }

  Future<Success> fetchHostelRoom(
      {required String token, required String accommodationId}) async {
    return await _hostelApiProvider.fetchHostelRoom(
        token: token, accommodationId: accommodationId);
  }

  Future<Success> deleteRoom({required String token, required int room}) async {
    return await _hostelApiProvider.deleteRoom(token: token, room: room);
  }

  Future<Success> deleteHostelRoom(
      {required String token, required String roomID}) async {
    return await _hostelApiProvider.deleteHostelRoom(
        token: token, roomID: roomID);
  }

  Future<Success> updateHostelRooms(
      {required String token, required Map<String, dynamic> data}) async {
    return _hostelApiProvider.updateHostelRooms(token: token, data: data);
  }

  Future<Success> updateAccommodation(
      {required String token,
      required Map<String, dynamic> accommodation}) async {
    print(accommodation);
    return _hostelApiProvider.updateAccommodation(
        token: token, accommodation: accommodation);
  }

  Future<Success> updateAccommodationImage(
      {required File image,
      required String token,
      required int accommodationId}) {
    return _hostelApiProvider.updateAccommodationImageApi(
        image: image, token: token, accommodationId: accommodationId);
  }

  Future<Success> addHostelRoom({
    required String token,
    required accommodationId,
    required File image1,
    required File image2,
    required int seaterBeds,
    required String washroom_status,
    required bool fan_availability,
    required int monthly_rate,
  }) async {
    return await _hostelApiProvider.addHostelRoom(
        token: token,
        accommodationId: accommodationId,
        image1: image1,
        image2: image2,
        seaterBeds: seaterBeds,
        washroom_status: washroom_status,
        fan_availability: fan_availability,
        monthly_rate: monthly_rate);
  }
}
