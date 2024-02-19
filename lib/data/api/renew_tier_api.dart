import 'package:stayfinder_vendor/constants/ip.dart';
import 'package:http/http.dart' as http;
import '../model/model_exports.dart';

class RenewTierApiProvider {
  Future<Success> renewSubscription(
      {required int tier,
      required methodOfPayment,
      required String transactionId,
      required String paidAmount,
      required String paidTill,
      required String token}) async {
    try {
      Uri uri = Uri.parse("${getIp()}tier/renewTier/");
      final response = await http.post(uri,
          headers: <String, String>{
            'Authorization': 'Token ${token}',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            'tier': tier,
            'paid_till': paidTill,
            'paid_amount': paidAmount,
            'method_of_payment': methodOfPayment,
            'transaction_id': transactionId,
          }));
      print(response.body);
      if (response.statusCode == 200) {
        return Success.fromMap(jsonDecode(response.body));
      } else {
        print('Request failed with status: ${response.statusCode}');
        return Success.withError(
            "Connection Error, Are you connected to the Internet?");
      }
    } catch (e) {
      return Success.withError("Error Connecting to Internet");
    }
  }
}
