import 'package:stayfinder_vendor/data/api/api_exports.dart';
import 'package:stayfinder_vendor/data/model/model_exports.dart';

class NotificationRepository {
  NotificationApiProvider provider = new NotificationApiProvider();
  Future<List<NotificationModel>> getNotifications(
      {required String token}) async {
    return await provider.getNotification(token: token);
  }
}
