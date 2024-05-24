import 'package:stayfinder_vendor/constants/ip.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:stayfinder_vendor/data/api/api_exports.dart';

import '../model/model_exports.dart';

class HostelApiProvider {
  Future<Success> fetchHostelAccommodation(
      {required String token, required String accommodationId}) async {
    try {
      final url = "${getIp()}accommodation/hostel/";
      final request = await Dio().get(url,
          data: {'id': accommodationId},
          options: Options(
              headers: <String, String>{'Authorization': 'Token ${token}'}));
      // print("The ressponse ${request.data}");

      if (request.data['success'] == 0) {
        return Success(success: 0, message: request.data['message']);
      }
      print(request.data);
      print("object");
      Success success = Success(success: 1, data: request.data['data']);
      // print("Thsi is success ${success}");\\
      return success;
    } catch (Exception) {
      return Success(success: 0, message: "Connection Error");
    }
  }

  Future<Success> fetchHostelRoom(
      {required String token, required String accommodationId}) async {
    try {
      final url = "${getIp()}accommodation/hostel/room/";
      final request = await Dio().get(url,
          data: {'id': accommodationId},
          options: Options(
            headers: <String, String>{
              'Authorization': "Token $token",
            },
          ));
      if (request.data['success'] == 0) {
        return Success(success: 0, message: request.data['message']);
      }
      return Success(success: 1, data: request.data['data']);
    } catch (Exception) {
      return Success(success: 0, message: "Connection Error");
    }
  }

  Future<Success> deleteHostelRoom(
      {required String token, required String roomID}) async {
    try {
      final url = "${getIp()}accommodation/hostel/room/";
      final request = await Dio().delete(url,
          data: {'id': roomID},
          options: Options(
            headers: <String, String>{
              'Authorization': "Token $token",
            },
          ));
      return Success.fromMap(request.data);
    } catch (Exception) {
      return Success(success: 0, message: "Connection Error");
    }
  }

  Future<Success> updateHostelRooms(
      {required String token, required Map<String, dynamic> data}) async {
    try {
      final url = "${getIp()}accommodation/hostel/room/";
      final request = await Dio().patch(url,
          data: data,
          options: Options(
            headers: <String, String>{
              'Authorization': 'Token $token',
            },
          ));
      print(request.data);
      return Success.fromMap(request.data);
    } catch (Exception) {
      return Success(success: 0, message: "Connection Error");
    }
  }

  Future<Success> updateRoomImage(
      {required String token,
      required int room_id,
      required int room_image_id,
      required File image}) async {
    try {
      final url = Uri.parse("${getIp()}accommodation/hostel/room/image/");
      final request = http.MultipartRequest(
        'PATCH',
        url,
      );
      request.headers['Authorization'] = 'Token ${token}';
      request.fields['room_id'] = room_id.toString();
      request.fields['room_image_id'] = room_image_id.toString();

      request.files.add(http.MultipartFile(
          'image', image.readAsBytes().asStream(), image.lengthSync(),
          filename: 'accommodation_image.jpg',
          contentType: MediaType('image', '*')));
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      return Success.fromMap(jsonDecode(response.body));
    } catch (Exception) {
      return Success(success: 0, message: "Connection Error");
    }
  }

  Future<Success> updateAccommodationImageApi(
      {required File image,
      required String token,
      required int accommodationId}) async {
    try {
      final url = Uri.parse("${getIp()}accommodation/hostel/");
      final request = http.MultipartRequest(
        'PATCH',
        url,
      );
      request.headers['Authorization'] = 'Token ${token}';
      request.fields['id'] = accommodationId.toString();
      request.files.add(http.MultipartFile(
          'image', image.readAsBytes().asStream(), image.lengthSync(),
          filename: 'accommodation_image.jpg',
          contentType: MediaType('image', '*')));
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      // if(response[])
      // print("This is resposne ${response.body}");
      return Success.fromMap(jsonDecode(response.body));
    } catch (e) {
      print("This is a exception ${e}");
      return Success(success: 0, message: "Connection Error");
    }
  }

  Future<Success> updateAccommodation(
      {required String token,
      required Map<String, dynamic> accommodation}) async {
    try {
      final url = Uri.parse("${getIp()}accommodation/hostel/");

      final response = await http.patch(url,
          body: jsonEncode(accommodation),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': "Token ${token}"
          });
      print("the json body is ${response.body}");
      return Success.fromMap(jsonDecode(response.body));
    } catch (Exception) {
      return Success(success: 0, message: "Connection Error");
    }
  }

  Future<Success> deleteRoom({required String token, required int room}) async {
    try {
      final url = Uri.parse("${getIp()}accommodation/hostel/room/");

      final response = await http.delete(url,
          body: jsonEncode({'id': room}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': "Token ${token}"
          });
      print("the json body is ${response.body}");
      return Success.fromMap(jsonDecode(response.body));
    } catch (Exception) {
      return Success(success: 0, message: "Connection Error");
    }
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
    try {
      final url = "${getIp()}accommodation/hostel/room/";
      final request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers['Authorization'] = 'Token $token';
      request.fields['accommodation_id'] = accommodationId.toString();
      request.fields['seater_beds'] = seaterBeds.toString();
      request.fields['washroom_status'] = washroom_status.toString();
      request.fields['fan_availability'] = fan_availability.toString();
      request.fields['monthly_rate'] = monthly_rate.toString();
      request.files.add(http.MultipartFile(
          'image_1', image1.readAsBytes().asStream(), image1.lengthSync(),
          filename: 'room_image_1.jpg', contentType: MediaType('image', '*')));
      request.files.add(http.MultipartFile(
          'image_2', image2.readAsBytes().asStream(), image2.lengthSync(),
          filename: 'room_image_2.jpg', contentType: MediaType('image', '*')));
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      print("This is the response ${response.body}");
      return Success.fromMap(jsonDecode(response.body));
    } catch (Exception) {
      return Success(success: 0, message: "Connection Error");
    }
  }
}
