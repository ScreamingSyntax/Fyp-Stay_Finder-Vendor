import '../api/api_exports.dart';
import '../model/model_exports.dart';

class VendorRepository {
  final _provider = VendorDataProvider();
  Future<Vendor> getUserData({required String token}) {
    return _provider.getUserData(token);
  }
}
