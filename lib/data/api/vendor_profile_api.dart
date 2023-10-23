import 'package:http/http.dart' as http;
import 'package:stayfinder_vendor/constants/ip.dart';
import '../model/model_exports.dart';

class VendorProfileApiProvider {
  Future<VendorProfile> getVendorProfile(String token) async {
    try {
      final response = await http.get(
          Uri.parse("${getIp()}vendor/verifedData/"),
          headers: <String, String>{'Authorization': 'Token $token'});
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        // print(responseData['data']);
        final int success = responseData['success'];
        print(responseData);
        print(responseData.containsKey('data'));
        if (success == 0) {
          return VendorProfile.withError(error: responseData['message']);
        }
        if (responseData.containsKey('data')) {
          // print('a');
          print(VendorProfile.fromMap(responseData['data']));
          return VendorProfile.fromMap(responseData['data']);
        } else {
          return VendorProfile.withError(error: "No data available");
        }
      } else {
        print('Request failed with status: ${response.statusCode}');
        return VendorProfile.withError(error: 'Connection Error');
      }
    } catch (err) {
      print(err);
      return VendorProfile.withError(error: 'Connection Error');
    }
  }
}
