import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stayfinder_vendor/constants/constants_exports.dart';

import '../model/model_exports.dart';

class LoginApiProvider {
  Future<Success> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("${getIp()}vendor/login/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        return Success.fromMap(jsonDecode(response.body));
      } else {
        print('Request failed with status: ${response.statusCode}');
        return Success.withError("Connection Issue");
      }
    } catch (err) {
      print(err);
      return Success.withError("Connection Issue");
    }
  }
}
