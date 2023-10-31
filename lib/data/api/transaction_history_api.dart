import 'package:stayfinder_vendor/constants/constants_exports.dart';
import 'package:stayfinder_vendor/data/model/model_exports.dart';
import 'package:http/http.dart' as http;

class TransactionHistoryApiProvider {
  Future<List<TransactionHistory>> getTransactionHistory(
      {required String token}) async {
    try {
      final url = Uri.parse("${getIp()}tier/transactionHistory/");
      final response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token ${token}'
      });
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData.containsKey('data')) {
        final List<dynamic> transactionHistoryList = responseData['data'];
        final List<TransactionHistory> tierList = transactionHistoryList
            .map((e) => TransactionHistory.fromMap(e))
            .toList();
        return tierList;
      } else {
        return [TransactionHistory.withError(error: "No Data available")];
      }
    } catch (err) {
      print(err);
      return [
        TransactionHistory.withError(
            error: "Connection Error, Please try again")
      ];
    }
  }
}
