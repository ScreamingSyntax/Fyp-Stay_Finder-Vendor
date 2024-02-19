import 'package:stayfinder_vendor/constants/ip.dart';
import 'package:stayfinder_vendor/data/model/success_model.dart';
import 'package:http/http.dart' as http;

import '../model/model_exports.dart';

class RevenueApiProvider {
  Future<Success> fetchRevenueData(
      {String? period, required String token}) async {
    String url = "";
    if (period == null || period == "") {
      url = "${getIp()}book/revenue/";
    } else {
      url = "${getIp()}book/revenue/?period=${period}";
    }
    try {
      final request = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Token ${token}',
        'Content-Type': 'application/json; charset=UTF-8'
      });
      return Success.fromMap(jsonDecode(request.body));
    } catch (e) {
      return Success(
          success: 0, message: "Please check your internet connection");
    }
  }
}
// 'Content-Type': 'application/json; charset=UTF-8',