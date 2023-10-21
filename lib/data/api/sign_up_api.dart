import 'package:dio/dio.dart';
import 'package:stayfinder_vendor/constants/constants_exports.dart';
import 'package:stayfinder_vendor/data/model/success_model.dart';

class SignUpApiProvider {
  Dio dio = Dio();
  Future<Success> signUp(
      {required String fullName,
      required String phoneNumber,
      required String email,
      required String password}) async {
    try {
      final response = await dio.post("${getIp()}vendor/signup/", data: {
        'full_name': fullName,
        'email': email,
        'phone_number': phoneNumber,
        'user_type': 'vendor',
        'password': password
      });
      return Success.fromMap(response.data);
    } catch (e) {
      return Success.withError(
          "Connection Error, Are you connected to the Internet? ");
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
      final response = await dio.post("${getIp()}vendor/signup/", data: {
        'full_name': fullName,
        'email': email,
        'phone_number': phoneNumber,
        'user_type': 'vendor',
        'password': password,
        'otp': otp
      });
      print(response);
      return Success.fromMap(response.data);
    } catch (e) {
      return Success.withError(
          "Connection Error, Are you connected to the Internet? ");
    }
  }
}
