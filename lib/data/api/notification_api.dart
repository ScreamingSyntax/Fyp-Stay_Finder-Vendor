import 'package:http/http.dart' as http;
import 'package:stayfinder_vendor/constants/ip.dart';
import 'package:stayfinder_vendor/data/model/model_exports.dart';

class NotificationApiProvider {
  Future<List<NotificationModel>> getNotification(
      {required String token}) async {
    try {
      final url = "${getIp()}notification/";
      final request = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json; charset=UTF-8'
      });
      print(request.body);
      return List.from(jsonDecode(request.body))
          .map((e) => NotificationModel.fromMap(e))
          .toList();
    } catch (e) {
      return [NotificationModel.withError(error: "Connection Error")];
    }
  }

  Future<Success> addDeviceId(
      {required String token,
      required String deviceID,
      String? deviceModel}) async {
    try {
      print(token);
      print(deviceID);
      print(deviceModel);
      final url = "${getIp()}notification/registerDevice/";
      final request = await http.post(Uri.parse(url),
          headers: {
            'Authorization': 'Token $token',
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: deviceModel != null
              ? jsonEncode({'device_id': deviceID, 'device_model': deviceModel})
              : jsonEncode({'device_id': deviceID}));
      return Success.fromMap(jsonDecode(request.body));
    } catch (e) {
      return Success(success: 0, message: "Connection Error");
    }
  }

  Future<Success> deleteDevice(
      {required String token, required String deviceId}) async {
    try {
      final url = "${getIp()}notification/registerDevice/";
      final request = await http.delete(Uri.parse(url),
          headers: {
            'Authorization': 'Token $token',
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode({'device_id': deviceId}));
      return Success.fromMap(jsonDecode(request.body));
    } catch (e) {
      return Success(success: 0, message: "Connection Error");
    }
  }

  Future<List<DevicesModel>> devices({required String token}) async {
    try {
      final url = "${getIp()}notification/registerDevice/";
      final request = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json; charset=UTF-8'
      });
      // if(req)
      final body = jsonDecode(request.body);
      if (body['success'] == 0) {
        return [DevicesModel.withError(error: body['message'])];
      }
      return List.from(body['data'])
          .map((e) => DevicesModel.fromMap(e))
          .toList();
    } catch (e) {
      return [DevicesModel.withError(error: "Connection error")];
    }
  }
}
