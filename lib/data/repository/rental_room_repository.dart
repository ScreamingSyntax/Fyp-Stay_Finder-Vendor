import 'package:stayfinder_vendor/data/api/api_exports.dart';
import 'package:stayfinder_vendor/data/model/model_exports.dart';

class RentalRoomRepository {
  RentalRoomApiProvider apiProvider = RentalRoomApiProvider();
  Future<Success> fetchRentalRoom(
      {required String token, required int accommodationId}) async {
    Success success = await apiProvider.fetchRentalRooms(
        accommodationId: accommodationId, token: token);
    return success;
  }

  Future<Success> updateAccommodationImage(
      {required File image,
      required String token,
      required int accommodationId}) async {
    return apiProvider.updateAccommodationImageApi(
        image: image, token: token, accommodationId: accommodationId);
  }

  Future<Success> updateAccommodationDetail(
      {required String token,
      required Map<String, dynamic> accommodations}) async {
    return apiProvider.updateAccommodationDetail(
        token: token, accommodations: accommodations);
  }

  Future<Success> updateRoomImage(
      {required String room_id,
      required String room_image_id,
      required String token,
      required File image}) {
    return apiProvider.updateRoomImageUpdate(
        room_id: room_id,
        room_image_id: room_image_id,
        token: token,
        image: image);
  }

  Future<Success> updateRoomDetails(
      {required String token, required Map data}) async {
    return apiProvider.updateRoomDetails(token: token, data: data);
  }
}
