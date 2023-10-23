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
      print("This is the response ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final int success = responseData['success'];

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
      print(err);
      return Vendor.withError(error: 'Connection Error');
    }
  }
}
