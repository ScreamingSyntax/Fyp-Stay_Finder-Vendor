import 'package:http/http.dart' as http;
import 'package:stayfinder_vendor/constants/ip.dart';
import '../model/model_exports.dart';

class VendorProfileApiProvider {
  Future<VendorProfile> getVendorProfile(String token) async {
    try {
      final response = await http.get(
          Uri.parse("${getIp()}vendor/verifiedData/"),
          headers: <String, String>{'Authorization': 'Token $token'});
      print("This is the response ${response.body}");
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final int success = responseData['success'];
        if (success == 0) {
          return VendorProfile.withError(error: responseData['message']);
        }
        if (responseData.containsKey('data')) {
          return VendorProfile.fromMap(responseData['data']);
        } else {
          return VendorProfile.withError(error: "No data available");
        }
      } else {
        print('Request failed with status: ${response.statusCode}');
        return VendorProfile.withError(error: 'Connection Error');
      }
    } catch (err) {
      return VendorProfile.withError(error: 'Connection Error');
    }
  }
}
