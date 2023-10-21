import 'package:stayfinder_vendor/data/api/api_exports.dart';
import 'package:stayfinder_vendor/data/model/model_exports.dart';

class VendorRepository {
  final _provider = VendorDataProvider();
  Future<Vendor> getUserData({required String token}) {
    return _provider.getUserData(token);
  }
}
