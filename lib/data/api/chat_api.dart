import 'dart:convert';

import 'package:stayfinder_vendor/constants/ip.dart';
import 'package:stayfinder_vendor/data/model/success_model.dart';
import 'package:http/http.dart' as http;

class ChatApiProvider {
  Future<Success> getAllMessages(
      {required String token, required String userId}) async {
    try {
      final url = "${getIp()}chat/all/?sender_id=$userId";
      final request = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json; charset=UTF-8'
      });
      final body = jsonDecode(request.body);
      return Success.fromMap(body);
    } catch (e) {
      return Success(success: 0, message: "Connection Error");
    }
  }

  Future<Success> seenAllMessages(
      {required String token,
      required String userId,
      required String recieverId}) async {
    try {
      final url = "${getIp()}chat/?sender_id=$userId&receiver_id=$recieverId";
      final request = await http.post(Uri.parse(url), headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json; charset=UTF-8'
      });
      final body = jsonDecode(request.body);

      return Success.fromMap(body);
    } catch (e) {
      return Success(success: 0, message: "Something went wrong");
    }
  }

  Future viewPersonAllMessage(
      {required String token,
      required String userId,
      required String recieverId}) async {
    try {
      final url = "${getIp()}chat/?sender_id=$userId&receiver_id=$recieverId";
      final request = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json; charset=UTF-8'
      });
      final body = jsonDecode(request.body);
      print(body);
      return Success.fromMap(body);
    } catch (e) {
      return Success(success: 0, message: "Something wen't wrong");
    }
  }
}
