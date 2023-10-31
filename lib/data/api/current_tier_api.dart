import 'package:stayfinder_vendor/constants/ip.dart';

import '../model/model_exports.dart';
import 'package:http/http.dart' as http;

class CurrentTierApiProvider {
  Future<TierTransaction> getCurrentTier({required String token}) async {
    try {
      final url = Uri.parse("${getIp()}tier/currentTier/");
      final response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token ${token}'
      });
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final int success = responseData['success'];
      print(success);
      if (success == 0) {
        return TierTransaction.withError(error: responseData['message']);
      }
      if (responseData.containsKey('data')) {
        return TierTransaction.fromMap(responseData['data']);
      } else {
        print("Request failed with status :${response.statusCode}");
        return TierTransaction.withError(error: "Connection Error");
      }
    } catch (err) {
      print(err);
      return TierTransaction.withError(
          error: "Check your internet Connection :) ");
    }
  }
}
