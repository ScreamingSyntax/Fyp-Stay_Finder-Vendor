import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stayfinder_vendor/data/model/notification_model.dart';
import 'package:stayfinder_vendor/data/repository/notification_repository.dart';

part 'fetch_notifications_state.dart';

class FetchNotificationsCubit extends Cubit<FetchNotificationsState> {
  NotificationRepository _notificationRepository = new NotificationRepository();
  FetchNotificationsCubit() : super(FetchNotificationsInitial());
  void fetchNotification({required String token}) async {
    emit(FetchNotificationsLoading());
    List<NotificationModel> notifications =
        await _notificationRepository.getNotifications(token: token);
    print(notifications);
    if (notifications[0].error != null) {
      return emit(FetchNotificationsError(error: notifications[0].error!));
    }
    return emit(FetchNotificationsSuccess(notifications));
  }
}
