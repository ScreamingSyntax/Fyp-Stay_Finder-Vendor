import 'dart:io';

import 'package:stayfinder_vendor/constants/constants_exports.dart';
import 'package:stayfinder_vendor/data/api/api_exports.dart';
import 'package:stayfinder_vendor/data/model/model_exports.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class RentalRoomApiProvider {
  Future<Success> fetchRentalRooms(
      {required String token, required int accommodationId}) async {
    try {
      final response = await Dio().get("${getIp()}accommodation/rental_room/",
          data: {'accommodation': accommodationId},
          options: Options(
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Token ${token}'
            },
          ));
      if (response.data['success'] == 0) {
        return Success(success: 0, message: response.data['message']);
      }
      return Success(success: 1, data: response.data);
    } catch (Exception) {
      return Success(success: 0, message: "Connection Error");
    }
  }

  Future<Success> updateAccommodationImageApi(
      {required File image,
      required String token,
      required int accommodationId}) async {
    // try {
    final url = Uri.parse("${getIp()}accommodation/rental_room/");
    final request = http.MultipartRequest(
      'PATCH',
      url,
    );
    request.headers['Authorization'] = 'Token ${token}';
    request.fields['accommodation[id]'] = accommodationId.toString();
    request.files.add(http.MultipartFile('accommodation[image]',
        image.readAsBytes().asStream(), image.lengthSync(),
        filename: 'accommodation_image.jpg',
        contentType: MediaType('image', '*')));
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    // if(response[])
    return Success.fromMap(jsonDecode(response.body));
  }

  Future<Success> updateAccommodationDetail(
      {required String token,
      required Map<String, dynamic> accommodations}) async {
    try {
      final url = Uri.parse("${getIp()}accommodation/rental_room/");

      final response = await http.patch(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Token $token",
        },
        body: jsonEncode(accommodations),
      );
      return Success.fromMap(jsonDecode(response.body));
    } catch (Exception) {
      return Success(success: 0, message: "Connection Error");
    }
  }

  Future<Success> updateRoomImageUpdate(
      {required String room_id,
      required String room_image_id,
      required String token,
      required File image}) async {
    try {
      print("This is room ${room_id}");
      final url = Uri.parse("${getIp()}accommodation/rental_room/image/");
      final request = await http.MultipartRequest('PATCH', url);
      request.headers['Authorization'] = "Token ${token}";
      request.fields['room_id'] = room_id;
      request.fields['room_image_id'] = room_image_id;
      request.files.add(http.MultipartFile(
          'image', image.readAsBytes().asStream(), image.lengthSync(),
          contentType: MediaType('image', '*'), filename: 'room_image'));
      // return Success.fromMap(jsonDecode(request.body))/;
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      return Success.fromMap(jsonDecode(response.body));
    } catch (Exception) {
      return Success(success: 0, message: "Connection Error");
    }
  }

  Future<Success> updateRoomDetails(
      {required String token, required Map data}) async {
    // try {
    final url = Uri.parse("${getIp()}accommodation/rental_room/room/");
    final response =
        await http.patch(url, body: jsonEncode(data), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token $token'
    });
    print("This is response ${response.body}");
    return Success.fromMap(jsonDecode(response.body));
    // } catch (Exception) {
    //   return Success(success: 0, message: "Connection Error");
    // }
  }
}
