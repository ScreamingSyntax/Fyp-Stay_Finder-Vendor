import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import '../../constants/constants_exports.dart';
import '../model/model_exports.dart';

class VendorDataProvider {
  Future<Success> resetPassword(
      {required String token,
      required String old_pass,
      required String new_pass}) async {
    try {
      final url = "${getIp()}vendor/resetPass/";
      final request = await http.patch(Uri.parse(url),
          // da
          body: jsonEncode({'old_pass': old_pass, 'new_pass': new_pass}),
          headers: {
            'Authorization': 'Token $token',
            'Content-Type': 'application/json; charset=UTF-8'
          });
      final response = jsonDecode(request.body);

      return Success.fromMap(response);
    } catch (e) {
      return Success(success: 0, message: "Something wen't wrong");
    }
  }

  Future<Vendor> getUserData(String token) async {
    try {
      final response = await http.get(
        Uri.parse("${getIp()}vendor/data/"),
        headers: <String, String>{
          'Authorization': 'Token $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final int success = responseData['success'];
        print(responseData);
        if (success == 0) {
          return Vendor.withError(error: responseData['message']);
        }
        if (responseData.containsKey('data')) {
          return Vendor.fromMap(responseData['data']);
        } else {
          return Vendor.withError(error: "No data available");
        }
      } else {
        print('Request failed with status: ${response.statusCode}');
        return Vendor.withError(error: 'Connection Error');
      }
    } catch (err) {
      print("This is exception ${err}");
      return Vendor.withError(error: 'Connection Error');
    }
  }

  Future<Success> forgotPassword(
      {required String email, String? newPassword, String? otp}) async {
    try {
      final url = "${getIp()}vendor/forgotPass/";
      Map data = {'email': email};
      if (otp != null) {
        data['otp'] = otp;
      }
      if (newPassword != null) {
        data['new_pass'] = newPassword;
      }
      final request = await http.post(Uri.parse(url),
          body: jsonEncode(data),
          headers: {'Content-Type': 'application/json; charset=UTF-8'});
      return Success.fromMap(jsonDecode(request.body));
    } catch (e) {
      print(e);
      return Success(success: 0, message: "Connection Error");
    }
  }
}
