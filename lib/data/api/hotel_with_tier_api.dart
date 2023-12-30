import 'package:dio/dio.dart';
import 'package:stayfinder_vendor/constants/ip.dart';
import 'package:stayfinder_vendor/data/api/api_exports.dart';
import 'package:stayfinder_vendor/data/model/model_exports.dart';
import 'package:stayfinder_vendor/data/model/success_model.dart';
import 'package:http/http.dart' as http;

class HotelWithTierAPiProvider {
  Dio dio = new Dio();
  Future<Success> fetchHotel({
    required String token,
    required String accommodation_id,
  }) async {
    try {
      final request = await dio.get('${getIp()}accommodation/hotel/tier/',
          data: {'accommodation_id': accommodation_id},
          options: Options(
              headers: <String, String>{'Authorization': 'Token $token'}));
      // return Success.fromMap(map)
      if (request.data['success'] == 0) {
        return Success(success: 0, message: request.data['message']);
      }
      return Success(success: 1, data: request.data['data']);
    } catch (Exception) {
      return Success(success: 0, message: "Connection Error");
    }
  }

  Future<Success> updateHotelDetails(
      {required Map data, required String token}) async {
    try {
      final request = await dio.patch(
          '${getIp()}accommodation/hotel/tier/update/',
          data: data,
          options: Options(
              headers: <String, String>{'Authorization': 'Token $token'}));
      print(request.data);
      return Success.fromMap(request.data);
    } catch (Exception) {
      return Success(success: 0, message: "Connection Error");
    }
  }

  Future<Success> updateHotelImage(
      {required String token,
      required File image,
      required accommodation_id}) async {
    try {
      final request = await http.MultipartRequest(
          'PATCH', Uri.parse('${getIp()}accommodation/hotel/tier/update/'));
      request.headers['Authorization'] = 'Token $token';
      // request.fields['images'] =
      request.fields['id'] = accommodation_id.toString();
      request.files.add(http.MultipartFile(
          'image', image.readAsBytes().asStream(), image.lengthSync(),
          filename: 'accommodation_image.jpg',
          contentType: MediaType('image', '*')));
      final streamResponse = await request.send();
      final response = await http.Response.fromStream(streamResponse);
      print(response.body);
      return Success.fromMap(jsonDecode(response.body));
    } catch (Exception) {
      return Success(success: 0, message: "Connection Error");
    }
  }

  // Future<Success> updateHotelImage(
  //     {required String token, required File image, required int id}) async {
  //   try {
  //     // final request = await dio.patch(
  //     //     '${getIp()}accommodation/hotel/tier/update/',
  //     //     data: data,
  //     //     options: Options(
  //     //         headers: <String, String>{'Authorization': 'Token $token'}));
  //     // return Success.fromMap(request.data);
  //   } catch (Exception) {
  //     return Success(success: 0, message: "Connection Error");
  //   }
  // }
  Future<Success> updateTierDetails(
      {required Map data, required String token}) async {
    try {
      final url = "${getIp()}accommodation/hotel/tier/";
      final request = await dio.patch(url,
          data: data,
          options: Options(
              headers: <String, String>{'Authorization': 'Token $token'}));
      return Success.fromMap(request.data);
    } catch (Exception) {
      return Success(success: 0, message: "Connection Error");
    }
  }

  Future<Success> updateTierImage(
      {required File image,
      required String token,
      required String hotelTierId}) async {
    try {
      final url = "${getIp()}accommodation/hotel/tier/";
      // final request = await dio.patch(url,
      //     data: data,
      //     options: Options(
      //         headers: <String, String>{'Authorization': 'Token $token'}));
      final request = await http.MultipartRequest('PATCH', Uri.parse(url));
      request.headers['Authorization'] = 'Token $token';
      request.fields['hoteltier_id'] = hotelTierId;
      request.files.add(http.MultipartFile(
          'image', image.readAsBytes().asStream(), image.lengthSync(),
          filename: 'tier_image.jpg', contentType: MediaType('image', '*')));
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      print(response.body);
      return Success.fromMap(jsonDecode(response.body));
      // return Success.fromMap(request.data);
    } catch (Exception) {
      return Success(success: 0, message: "Connection Error");
    }
  }

  Future<Success> deleteTier(
      {required String hotelTierId, required String token}) async {
    try {
      final url = "${getIp()}accommodation/hotel/tier/";
      final request = await dio.delete(url,
          data: {'hoteltier_id': hotelTierId},
          options: Options(
              headers: <String, String>{'Authorization': 'Token $token'}));
      return Success.fromMap(request.data);
    } catch (Exception) {
      return Success(success: 0, message: "Connection Error");
    }
  }

  Future<Success> deleteTierRoom(
      {required String room_id, required String token}) async {
    try {
      final url = "${getIp()}accommodation/hotel/tier/room/";
      final request = await dio.delete(url,
          data: {'room_id': room_id},
          options: Options(
              headers: <String, String>{'Authorization': 'Token $token'}));
      return Success.fromMap(request.data);
    } catch (Exception) {
      return Success(success: 0, message: "Connection Error");
    }
  }

  Future<Success> addTierRoom(
      {required Map data, required String token}) async {
    try {
      final url = "${getIp()}accommodation/hotel/tier/room/";
      final request = await dio.post(url,
          data: data,
          options: Options(
              headers: <String, String>{'Authorization': 'Token $token'}));
      print(request.data);
      return Success.fromMap(request.data);
    } catch (Exception) {
      return Success(success: 0, message: "Connection Error");
    }
  }

  Future<Success> addTier(
      {required String token,
      required String tier_name,
      required String description,
      required File image,
      required String accommodationID}) async {
    try {
      final url = "${getIp()}accommodation/hotel/tier/update/";
      final request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers['Authorization'] = 'Token $token';
      request.fields['tier_name'] = tier_name.toString();
      request.fields['description'] = description.toString();
      request.fields['accommodation'] = accommodationID;
      request.files.add(
        http.MultipartFile(
            'image', image.readAsBytes().asStream(), image.lengthSync(),
            filename: 'tier_image.jpg', contentType: MediaType('image', '*')),
      );
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      print(response.body);
      return Success.fromMap(jsonDecode(response.body));
    } catch (Exception) {
      return Success(success: 0, message: "Connection Error");
    }
  }

  Future<Success> updateRoomDetails(
      {required Map data, required String token}) async {
    try {
      final url = "${getIp()}accommodation/hotel/tier/room/";
      final request = await dio.patch(url,
          data: data,
          options: Options(
              headers: <String, String>{'Authorization': 'Token $token'}));
      print(request.data);
      return Success.fromMap(request.data);
    } catch (Exception) {
      return Success(success: 0, message: "Connection Error");
    }
  }

  Future<Success> updateRoomImage(
      {required File image, required String token}) async {
    try {
      final url = "${getIp()}accommodation/hotel/tier/room/";
      final request = await http.MultipartRequest('PATCH', Uri.parse(url));
      request.headers['Authorization'] = 'Token $token';
      request.files.add(
        http.MultipartFile(
            'image', image.readAsBytes().asStream(), image.lengthSync(),
            contentType: MediaType('image', '*'), filename: 'room_image.jpg'),
      );
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      return Success.fromMap(jsonDecode(response.body));
      // return Success.fromMap(request.data);
    } catch (Exception) {
      return Success(success: 0, message: "Connection Error");
    }
  }
  // Future<Success> deleteTierRoom(
  //     {required String room_id, required String token}) async {
  //   try {
  //     final url = "${getIp()}accommodation/hotel/tier/room/";
  //     final request = await dio.delete(url,
  //         data: {'room_id': room_id},
  //         options: Options(
  //             headers: <String, String>{'Authorization': 'Token $token'}));
  //     return Success.fromMap(request.data);
  //   } catch (Exception) {
  //     return Success(success: 0, message: "Connection Error");
  //   }
  // }
}
