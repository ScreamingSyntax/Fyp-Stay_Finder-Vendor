import 'package:stayfinder_vendor/constants/constants_exports.dart';

import '../model/model_exports.dart';
import 'package:http/http.dart' as http;

import 'api_exports.dart';

class InventoryApiProvider {
  Future<Success> fetchInventory({
    required String token,
    required int accommodationId,
    String? type,
    String? date,
    String? endDate,
  }) async {
    try {
      print(date);
      List<String> queryParams = [
        "accommodation=${accommodationId}",
        if (type != null) "filter_type=$type",
        if (date != null) "date_value=$date",
        if (endDate != null) "end_date_value=$endDate",
      ];

      String queryString = queryParams.join('&');
      String url = "${getIp()}inventory/?$queryString";
      final request = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Token $token',
      });
      return Success.fromMap(jsonDecode(request.body));
    } catch (e) {
      print(e);
      return Success(success: 0, message: "Connection Error");
    }
  }

  Future<Success> addInventoryItem(
      {required String token,
      required int inventoryId,
      required String name,
      required String count,
      required String price,
      required File image}) async {
    try {
      final url = "${getIp()}inventory/";
      final request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers['Authorization'] = "Token $token";
      request.fields['name'] = name;
      request.fields['count'] = count;
      request.fields['price'] = price;
      request.fields['inventory'] = inventoryId.toString();
      request.files.add(http.MultipartFile(
          'image', image.readAsBytes().asStream(), image.lengthSync(),
          filename: 'image.jpg', contentType: MediaType('image', '*')));
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      return Success.fromMap(jsonDecode(response.body));
    } catch (e) {
      return Success(success: 0, message: "Connection Error");
    }
  }

  Future<Success> deleteInventoryItem(
      {required int itemId, required String token}) async {
    try {
      final url = "${getIp()}inventory/?item_id=$itemId";
      final request = await http.delete(
        Uri.parse(url),
        headers: {
          'Authorization': 'Token $token',
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      return Success.fromMap(jsonDecode(request.body));
    } catch (e) {
      print(e);
      return Success(success: 0, message: 'Connection error');
    }
  }

  Future<Success> editInventoryItem(
      {required int itemId,
      required int count,
      required String token,
      required String action}) async {
    try {
      final url = "${getIp()}inventory/?item_id=$itemId";
      final request = await http.patch(Uri.parse(url),
          body: jsonEncode({'count': count, 'action': action}),
          headers: {
            'Authorization': 'Token $token',
            'Content-Type': 'application/json; charset=UTF-8'
          });
      return Success.fromMap(jsonDecode(request.body));
    } catch (e) {
      return Success(success: 0, message: "Connection Error");
    }
  }
}
