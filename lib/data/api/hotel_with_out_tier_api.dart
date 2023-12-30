import 'dart:convert';

import 'package:stayfinder_vendor/constants/ip.dart';
import 'package:stayfinder_vendor/data/model/success_model.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

import '../model/model_exports.dart';
import 'api_exports.dart';

class HotelWithoutTierApiProvider {
  Dio dio = new Dio();

  Future<Success> fetchWithoutHotelTier({
    required int accommodationId,
    required String token,
  }) async {
    try {
      final url = "${getIp()}accommodation/hotel/nonTier/";
      Dio dio = new Dio();
      // final response = http.get()
      Response<dynamic> request = await dio.get(url,
          data: {'accommodation_id': accommodationId},
          options: Options(
              headers: <String, String>{'Authorization': 'Token $token'}));
      // if (request.data['success'])
      print(request.data);
      if (request.data['success'] == 0) {
        return Success(success: 0, message: request.data['message']);
      }
      return Success(success: 1, data: request.data['data']);
    } catch (Exception) {
      return Success(success: 0, message: "Connection Error");
    }
  }

  Future<Success> patchHotelRoom(
      {required String token, required Map data}) async {
    try {
      final url = "${getIp()}accommodation/hotel/nonTier/room/";
      // final uri = Uri.parse(url);
      Response<dynamic> request = await dio.patch(url,
          data: data,
          options: Options(
              headers: <String, String>{'Authorization': 'Token $token'}));
      // if (request.data['success'])
      if (request.data['success'] == 0) {
        return Success(success: 0, message: request.data['message']);
      }
      return Success(success: 1, message: request.data['message']);
    } catch (Exception) {
      return Success(success: 0, message: "Connection Error");
    }
  }

  Future<Success> addRoom(
      {required String token,
      required Room room,
      required File roomImage,
      required String accommodationId}) async {
    try {
      final url = "${getIp()}accommodation/hotel/nonTier/room/";
      // Response<dynamic> request = await http.post(
      //   Uri.parse(url),
      //   body
      // );
      print("The room is ${room}");
      final request = await http.MultipartRequest('POST', Uri.parse(url));
      request.headers['Authorization'] = "Token ${token}";
      request.fields['accommodation_id'] = accommodationId;
      request.fields['ac_availability'] = room.ac_availability.toString();
      request.fields['water_bottle_availability'] =
          room.water_bottle_availability.toString();
      request.fields['steam_iron_availability'] =
          room.steam_iron_availability.toString();
      request.fields['per_day_rent'] = room.per_day_rent.toString();
      request.fields['seater_beds'] = room.seater_beds.toString();
      request.fields['fan_availability'] = room.fan_availability.toString();
      request.fields['coffee_powder_availability'] =
          room.coffee_powder_availability.toString();
      request.fields['milk_powder_availability'] =
          room.milk_powder_availability.toString();
      request.fields['kettle_availability'] =
          room.kettle_availability.toString();
      request.fields['tv_availability'] = room.tv_availability.toString();
      request.fields['steam_iron_availability'] =
          room.steam_iron_availability.toString();
      request.fields['tea_powder_availability'] =
          room.tea_powder_availability.toString();
      request.fields['hair_dryer_availability'] =
          room.hair_dryer_availability.toString();
      request.files.add(http.MultipartFile(
          'images', roomImage.readAsBytes().asStream(), roomImage.lengthSync(),
          filename: 'room_image.jpg', contentType: MediaType('image', '*')));
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      return Success.fromMap(jsonDecode(response.body));
    } catch (Exception) {
      return Success(success: 0, message: "Connection Error");
    }
  }

  Future<Success> deleteRoom(
      {required String token, required int room_id}) async {
    try {
      final url = "${getIp()}accommodation/hotel/nonTier/room/";
      Response<dynamic> request = await dio.delete(url,
          data: {'room_id': room_id},
          options: Options(
              headers: <String, String>{'Authorization': 'Token $token'}));
      if (request.data['success'] == 0) {
        return Success(success: 0, message: request.data['message']);
      }
      return Success(success: 1, message: request.data['message']);
    } catch (Exception) {
      return Success(success: 0, message: "Connection Error");
    }
  }

  Future<Success> updateRoomImage(
      {required String token,
      required File image,
      required int room_id}) async {
    try {
      final url = "${getIp()}accommodation/hotel/nonTier/room/";
      final request = await http.MultipartRequest('PATCH', Uri.parse(url));
      request.headers['Authorization'] = "Token ${token}";
      request.fields['room_id'] = room_id.toString();
      request.files.add(http.MultipartFile(
          'images', image.readAsBytes().asStream(), image.lengthSync(),
          filename: 'room_image.jpg', contentType: MediaType('image', '*')));
      final streamedResponse = await request.send();
      final respone = await http.Response.fromStream(streamedResponse);
      return Success.fromMap(jsonDecode(respone.body));
    } catch (Exception) {
      return Success(success: 0, message: "Connection Error");
    }
  }

  Future<Success> updateAccommodationImage(
      {required String token, required File image, required int id}) async {
    try {
      final url = "${getIp()}accommodation/hotel/nonTier/";
      final request = await http.MultipartRequest('PATCH', Uri.parse(url));
      request.headers['Authorization'] = "Token ${token}";
      request.fields['id'] = id.toString();
      request.files.add(http.MultipartFile(
          'image', image.readAsBytes().asStream(), image.lengthSync(),
          filename: 'room_image.jpg', contentType: MediaType('image', '*')));
      final streamedResponse = await request.send();
      final respone = await http.Response.fromStream(streamedResponse);
      return Success.fromMap(jsonDecode(respone.body));
    } catch (Exception) {
      return Success(success: 0, message: "Connection Error");
    }
  }

  Future<Success> accommodationUpdate({
    required String token,
    required Map data,
  }) async {
    try {
      final url = "${getIp()}accommodation/hotel/nonTier/";
      final request = await http
          .patch(Uri.parse(url), body: data, headers: <String, String>{
        'Authorization': 'Token $token',
      });
      print("The body is ${request}");
      return Success.fromMap(jsonDecode(request.body));
    } catch (Exception) {
      return Success(success: 0, message: "Connection Error");
    }
  }
}
