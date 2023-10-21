import 'package:dio/dio.dart';

import '../../constants/constants_exports.dart';
import '../model/model_exports.dart';

class VendorDataProvider {
  final dio = Dio();

  Future<Vendor> getUserData(String token) async {
    try {
      final response = await dio.get("${getIp()}vendor/data/",
          options: Options(headers: {"Authorization": "Token ${token}"}));
      print("This is the response ${response.data}");
      print(response.data['data']);
      if (response.data['success'] == 0) {
        return Vendor.withError(error: response.data['message']);
      }
      return Vendor.fromMap(response.data['data']);
    } catch (err) {
      print(err);
      return Vendor.withError(error: 'Connection Error');
    }
  }
}
