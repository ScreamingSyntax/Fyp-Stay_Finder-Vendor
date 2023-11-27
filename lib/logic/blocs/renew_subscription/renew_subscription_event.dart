part of 'renew_subscription_bloc.dart';

sealed class RenewSubscriptionEvent extends Equatable {
  const RenewSubscriptionEvent();

  @override
  List<Object> get props => [];
}

class RenewSubscriptionHitEvent extends RenewSubscriptionEvent {
  final int tier;
  final String methodOfPayment;
  final String transactionId;
  final String paidAmount;
  final String token;

  RenewSubscriptionHitEvent(
      {required this.tier,
      required this.methodOfPayment,
      required this.transactionId,
      required this.paidAmount,
      required this.token});
}
