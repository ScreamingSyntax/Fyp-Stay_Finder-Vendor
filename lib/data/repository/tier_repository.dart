import '../api/api_exports.dart';
import '../model/model_exports.dart';

class TierRepository {
  TierApiProvider _provider = TierApiProvider();
  Future<List<Tier>> fetchTierData({required String token}) async {
    try {
      return await _provider.fetchTierList(token);
    } catch (err) {
      return [Tier.withError(error: "Connection Error Brother")];
    }
  }
}
