import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stayfinder_vendor/constants/constants_exports.dart';
import 'package:stayfinder_vendor/data/model/success_model.dart';

class SignUpApiProvider {
  Future<Success> signUp({
    required String fullName,
    required String phoneNumber,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("${getIp()}vendor/signup/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'full_name': fullName,
          'email': email,
          'phone_number': phoneNumber,
          'user_type': 'vendor',
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        return Success.fromMap(jsonDecode(response.body));
      } else {
        print('Request failed with status: ${response.statusCode}');
        return Success.withError(
            "Connection Error, Are you connected to the Internet?");
      }
    } catch (e) {
      print(e);
      return Success.withError(
          "Connection Error, Are you connected to the Internet?");
    }
  }

  Future<Success> signUpWithOtp({
    required String fullName,
    required String phoneNumber,
    required String email,
    required String password,
    required String otp,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("${getIp()}vendor/signup/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'full_name': fullName,
          'email': email,
          'phone_number': phoneNumber,
          'user_type': 'vendor',
          'password': password,
          'otp': otp,
        }),
      );

      if (response.statusCode == 200) {
        return Success.fromMap(jsonDecode(response.body));
      } else {
        print('Request failed with status: ${response.statusCode}');
        return Success.withError(
            "Connection Error, Are you connected to the Internet?");
      }
    } catch (e) {
      print(e);
      return Success.withError(
          "Connection Error, Are you connected to the Internet?");
    }
  }
}
