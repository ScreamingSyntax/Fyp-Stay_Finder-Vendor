import 'package:stayfinder_vendor/logic/blocs/bloc_exports.dart';
import 'package:stayfinder_vendor/logic/blocs/renew_subscription/renew_subscription_bloc.dart';
import 'package:stayfinder_vendor/presentation/widgets/widgets_exports.dart';
import '../../data/model/model_exports.dart';

void showPaymentResult(BuildContext context, String title,
    {PaymentSuccessModel? successModel,
    PaymentFailureModel? failureModel,
    Tier? tier}) {
  showDialog(
    context: context,
    builder: (_) {
      if (successModel != null) {
        var loginState = context.read<LoginBloc>().state;
        if (loginState is LoginLoaded) {
          context.read<RenewSubscriptionBloc>().add(RenewSubscriptionHitEvent(
              tier: tier!.id!,
              methodOfPayment: 'Khalti',
              transactionId: successModel.idx,
              paidAmount: tier.price!,
              token: loginState.successModel.token!));
        }
      }
      return AlertDialog(
        title: CustomPoppinsText(
          text: title,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Color(0xff32454D),
        ),
        actions: [
          SimpleDialogOption(
              padding: EdgeInsets.all(8),
              child: CustomPoppinsText(
                text: "Ok",
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xff32454D),
              ),
              onPressed: () {
                customScaffold(
                    context: context,
                    title: "Renewed",
                    message:
                        "Please reload your application to view your changes",
                    contentType: ContentType.success);
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/home', (Route<dynamic> route) => false);
              })
        ],
      );
    },
  );
}

void onCancel(BuildContext context) {
  Navigator.popAndPushNamed(context, "/home");
  customScaffold(
      context: context,
      title: "Sucessfully Cancelled",
      message: "Your payment has been sucessfully cancelled :) ",
      contentType: ContentType.success);
}

void payWithKhaltiInApp({required BuildContext context, required Tier tier}) {
  final config = PaymentConfig(
    amount: 2000,
    productIdentity: tier.description!,
    productName: tier.name!,
  );

  KhaltiScope.of(context).pay(
    config: config,
    preferences: [PaymentPreference.khalti],
    onSuccess: (successModel) => showPaymentResult(
        context, "Successfully Paid :)",
        successModel: successModel, tier: tier),
    onCancel: () => onCancel(context),
    onFailure: (paymentFailure) => showPaymentResult(context, "Failed Bro"),
  );
}
