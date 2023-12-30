import '../api/api_exports.dart';
import '../model/model_exports.dart';

class HotelWithoutTierRepository {
  HotelWithoutTierApiProvider _apiProvider = HotelWithoutTierApiProvider();
  Future<Success> fetchHotelWithoutTier(
      {required int accommodationId, required String token}) async {
    return await _apiProvider.fetchWithoutHotelTier(
        accommodationId: accommodationId, token: token);
  }

  Future<Success> updateHotelRoom(
      {required String token, required Map data}) async {
    return await _apiProvider.patchHotelRoom(token: token, data: data);
  }

  Future<Success> deleteRoom(
      {required String token, required int room_id}) async {
    return await _apiProvider.deleteRoom(token: token, room_id: room_id);
  }

  Future<Success> updateAccommodation(
      {required String token, required Map data}) async {
    return await _apiProvider.accommodationUpdate(token: token, data: data);
  }

  Future<Success> updateAccommodationImage(
      {required String token, required File image, required int id}) async {
    return await _apiProvider.updateAccommodationImage(
        token: token, image: image, id: id);
  }

  Future<Success> addRooms(
      {required String token,
      required Room room,
      required File roomImage,
      required String accommodationId}) async {
    return await _apiProvider.addRoom(
        token: token,
        room: room,
        roomImage: roomImage,
        accommodationId: accommodationId);
  }

  Future<Success> updateRoomImage(
      {required String token,
      required File image,
      required int room_id}) async {
    return await _apiProvider.updateRoomImage(
        token: token, image: image, room_id: room_id);
  }
}
