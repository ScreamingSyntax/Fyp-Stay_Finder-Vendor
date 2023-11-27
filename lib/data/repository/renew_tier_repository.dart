import 'package:stayfinder_vendor/data/api/api_exports.dart';
import 'package:stayfinder_vendor/data/model/success_model.dart';

class RenewTierRepository {
  RenewTierApiProvider renewTierApiProvider = RenewTierApiProvider();
  Future<Success> renewTierSubscription(
      {required int tier,
      required String methodOfPayment,
      required String transactionId,
      required String paidAmount,
      required String token}) async {
    return await renewTierApiProvider.renewSubscription(
        tier: tier,
        methodOfPayment: methodOfPayment,
        transactionId: transactionId,
        paidAmount: paidAmount,
        token: token);
  }
}
