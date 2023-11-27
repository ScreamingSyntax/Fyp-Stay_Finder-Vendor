part of 'renew_subscription_bloc.dart';

sealed class RenewSubscriptionState extends Equatable {
  const RenewSubscriptionState();

  @override
  List<Object> get props => [];
}

final class RenewSubscriptionInitial extends RenewSubscriptionState {}

final class RenewSubscriptionLoading extends RenewSubscriptionState {}

final class RenewSubscriptionLoaded extends RenewSubscriptionState {
  final String message;

  RenewSubscriptionLoaded({required this.message});
  @override
  List<Object> get props => [this.message];
}

final class RenewSubscriptionError extends RenewSubscriptionState {
  final String message;

  RenewSubscriptionError({required this.message});
  @override
  List<Object> get props => [this.message];
}
