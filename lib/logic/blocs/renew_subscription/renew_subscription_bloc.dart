import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stayfinder_vendor/data/model/model_exports.dart';

import '../../../data/repository/repository_exports.dart';

part 'renew_subscription_event.dart';
part 'renew_subscription_state.dart';

class RenewSubscriptionBloc
    extends Bloc<RenewSubscriptionEvent, RenewSubscriptionState> {
  RenewSubscriptionBloc({required RenewTierRepository renewTierRepository})
      : super(RenewSubscriptionInitial()) {
    on<RenewSubscriptionHitEvent>((event, emit) async {
      emit(RenewSubscriptionLoading());
      Success success = await renewTierRepository.renewTierSubscription(
          tier: event.tier,
          methodOfPayment: event.methodOfPayment,
          transactionId: event.transactionId,
          paidTill: event.paidTill,
          paidAmount: event.paidAmount,
          token: event.token);
      if (success.success == 0) {
        return emit(RenewSubscriptionError(message: success.message!));
      }
      if (success.error != null) {
        return emit(RenewSubscriptionError(message: success.error!));
      }
      return emit(RenewSubscriptionLoaded(message: success.message!));
    });
  }
  @override
  void onChange(Change<RenewSubscriptionState> change) {
    print(
        "Current State ${change.currentState}, Next State ${change.nextState}");
    super.onChange(change);
  }
}
