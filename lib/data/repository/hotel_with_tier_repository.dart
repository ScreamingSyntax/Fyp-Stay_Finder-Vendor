import 'package:stayfinder_vendor/data/api/api_exports.dart';
import 'package:stayfinder_vendor/data/model/model_exports.dart';

class HotelWithTierRepository {
  HotelWithTierAPiProvider _hotelWithTierAPiProvider =
      HotelWithTierAPiProvider();
  Future<Success> fetchHotelDetails({
    required String token,
    required String accommodation_id,
  }) async {
    return _hotelWithTierAPiProvider.fetchHotel(
        token: token, accommodation_id: accommodation_id);
  }

  Future<Success> updateHotelDetails(
      {required Map data, required String token}) async {
    return await _hotelWithTierAPiProvider.updateHotelDetails(
        data: data, token: token);
  }

  Future<Success> updateHotelImage(
      {required String token,
      required File image,
      required int accommodation_id}) async {
    return await _hotelWithTierAPiProvider.updateHotelImage(
        accommodation_id: accommodation_id, token: token, image: image);
  }

  Future<Success> addTier(
      {required String token,
      required String tier_name,
      required String description,
      required File image,
      required String accommodationID}) async {
    return await _hotelWithTierAPiProvider.addTier(
        token: token,
        tier_name: tier_name,
        description: description,
        image: image,
        accommodationID: accommodationID);
  }

  Future<Success> updateTierImage(
      {required File image,
      required String token,
      required String hotelTierId}) async {
    return await _hotelWithTierAPiProvider.updateTierImage(
        image: image, token: token, hotelTierId: hotelTierId);
  }

  Future<Success> updateTierDetails(
      {required Map data, required String token}) async {
    return await _hotelWithTierAPiProvider.updateTierDetails(
        data: data, token: token);
  }

  Future<Success> deleteTier(
      {required String hotelTierId, required String token}) async {
    return await _hotelWithTierAPiProvider.deleteTier(
        hotelTierId: hotelTierId, token: token);
  }

  Future<Success> addTierRoom(
      {required Map data, required String token}) async {
    return await _hotelWithTierAPiProvider.addTierRoom(
        data: data, token: token);
  }

  Future<Success> updateTierRoom(
      {required Map data, required String token}) async {
    return await _hotelWithTierAPiProvider.updateRoomDetails(
        data: data, token: token);
  }

  Future<Success> updateRoomImage(
      {required File image, required String token}) async {
    return await _hotelWithTierAPiProvider.updateRoomImage(
        image: image, token: token);
  }

  Future<Success> deleteRoom(
      {required String room_id, required String token}) async {
    return await _hotelWithTierAPiProvider.deleteTierRoom(
        room_id: room_id, token: token);
  }
}
