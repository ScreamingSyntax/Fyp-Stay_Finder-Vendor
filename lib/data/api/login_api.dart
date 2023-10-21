import 'package:dio/dio.dart';
import 'package:stayfinder_vendor/constants/constants_exports.dart';

import '../model/model_exports.dart';

class LoginApiProvider {
  final dio = Dio();

  Future<Success> login(
      {required String email, required String password}) async {
    try {
      final response = await dio.post(
        "${getIp()}vendor/login/",
        data: {'email': email, 'password': password},
      );
      return Success.fromMap(response.data);
    } catch (err) {
      print(err);
      return Success.withError("Connection Issue");
    }
  }
}
