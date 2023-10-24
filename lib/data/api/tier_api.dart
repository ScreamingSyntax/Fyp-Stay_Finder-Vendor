import 'package:http/http.dart' as http;
import '../../constants/ip.dart';
import '../model/model_exports.dart';

class TierApiProvider {
  Future<List<Tier>> fetchTierList(String token) async {
    try {
      final response = await http.get(
        Uri.parse('${getIp()}tier/'),
        headers: <String, String>{
          'Authorization': 'Token $token',
        },
      );
      print("This is the response ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        if (responseData.containsKey('data')) {
          final List<dynamic> tierDataList = responseData['data'];
          List<Tier> tierList =
              tierDataList.map((e) => Tier.fromMap(e)).toList();
          return tierList;
        } else {
          return [Tier.withError(error: "No data available")];
        }
      } else {
        print('Request failed with status: ${response.statusCode}');
        return [Tier.withError(error: "Connection Error, Please try again")];
      }
    } catch (err) {
      print(err);
      return [Tier.withError(error: "Connection Error, Please try again")];
    }
  }
}
