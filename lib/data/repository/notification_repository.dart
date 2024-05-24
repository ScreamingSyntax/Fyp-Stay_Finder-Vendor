import 'package:stayfinder_vendor/data/api/api_exports.dart';
import 'package:stayfinder_vendor/data/model/model_exports.dart';

class NotificationRepository {
  NotificationApiProvider provider = new NotificationApiProvider();
  Future<List<NotificationModel>> getNotifications(
      {required String token}) async {
    return await provider.getNotification(token: token);
  }

  Future<Success> addDeviceId(
      {required String token,
      required String deviceID,
      String? deviceModel}) async {
    return await provider.addDeviceId(
        token: token, deviceID: deviceID, deviceModel: deviceModel);
  }

  Future<List<DevicesModel>> devices({required String token}) async =>
      await provider.devices(token: token);
  Future<Success> deleteDevice(
          {required String token, required String deviceId}) async =>
      await provider.deleteDevice(token: token, deviceId: deviceId);
}
