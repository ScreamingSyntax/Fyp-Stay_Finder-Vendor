import '../api/api_exports.dart';
import '../model/model_exports.dart';

class VendorProfileRepository {
  final _apiProvider = VendorProfileApiProvider();
  Future<VendorProfile> getVendorProfile({required String token}) async {
    return await _apiProvider.getVendorProfile(token);
  }
}
