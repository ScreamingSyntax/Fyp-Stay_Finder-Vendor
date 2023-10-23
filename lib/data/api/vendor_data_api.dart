import 'package:http/http.dart' as http;
import '../../constants/constants_exports.dart';
import '../model/model_exports.dart';

class VendorDataProvider {
  Future<Vendor> getUserData(String token) async {
    try {
      final response = await http.get(
        Uri.parse("${getIp()}vendor/data/"),
        headers: <String, String>{
          'Authorization': 'Token $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final int success = responseData['success'];
        print(responseData);
        if (success == 0) {
          return Vendor.withError(error: responseData['message']);
        }
        if (responseData.containsKey('data')) {
          return Vendor.fromMap(responseData['data']);
        } else {
          return Vendor.withError(error: "No data available");
        }
      } else {
        print('Request failed with status: ${response.statusCode}');
        return Vendor.withError(error: 'Connection Error');
      }
    } catch (err) {
      print("This is exception ${err}");
      return Vendor.withError(error: 'Connection Error');
    }
  }
}
