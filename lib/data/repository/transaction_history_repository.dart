import 'package:stayfinder_vendor/data/api/api_exports.dart';
import 'package:stayfinder_vendor/data/model/model_exports.dart';

class TransactionHistoryRepository {
  TransactionHistoryApiProvider _apiProvider = TransactionHistoryApiProvider();
  Future<List<TransactionHistory>> getTransactionHistory(
      {required String token}) async {
    return await _apiProvider.getTransactionHistory(token: token);
  }
}
