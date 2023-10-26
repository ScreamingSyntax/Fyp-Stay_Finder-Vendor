import 'package:stayfinder_vendor/data/api/api_exports.dart';
import 'package:stayfinder_vendor/data/model/model_exports.dart';

class CurrentTierApiRepository {
  final CurrentTierApiProvider _apiProvider = CurrentTierApiProvider();
  Future<CurrentTier> getCurrentTier({required String token}) async {
    return await _apiProvider.getCurrentTier(token: token);
  }
}
