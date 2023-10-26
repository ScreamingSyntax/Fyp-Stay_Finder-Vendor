import 'package:stayfinder_vendor/constants/ip.dart';

import '../model/model_exports.dart';
import 'package:http/http.dart' as http;

class CurrentTierApiProvider {
  Future<CurrentTier> getCurrentTier({required String token}) async {
    try {
      final url = Uri.parse("${getIp()}tier/currentTier/");
      final response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token ${token}'
      });
      // if(response)
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final int success = responseData['success'];
      print(success);
      if (success == 0) {
        return CurrentTier.withError(error: responseData['message']);
      }
      if (responseData.containsKey('data')) {
        return CurrentTier.fromMap(responseData['data']);
      } else {
        print("Request failed with status :${response.statusCode}");
        return CurrentTier.withError(error: "Connection Error");
      }
    } catch (err) {
      print(err);
      return CurrentTier.withError(error: "Check your internet Connection :) ");
    }
  }
}
