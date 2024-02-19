import 'package:stayfinder_vendor/data/api/api_exports.dart';

import '../model/model_exports.dart';

class RevenueRepository {
  RevenueApiProvider _revenueApiProvider = new RevenueApiProvider();
  Future<Success> fetchRevenueData(
          {String? period, required String token}) async =>
      await _revenueApiProvider.fetchRevenueData(token: token, period: period);
}
