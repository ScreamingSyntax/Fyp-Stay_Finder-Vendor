part of 'fetch_notifications_cubit.dart';

sealed class FetchNotificationsState extends Equatable {
  const FetchNotificationsState();

  @override
  List<Object> get props => [];
}

class FetchNotificationsInitial extends FetchNotificationsState {}

class FetchNotificationsLoading extends FetchNotificationsState {}

class FetchNotificationsSuccess extends FetchNotificationsState {
  final List<NotificationModel> notifications;

  FetchNotificationsSuccess(this.notifications);
}

class FetchNotificationsError extends FetchNotificationsState {
  final String error;

  FetchNotificationsError({required this.error});
}
