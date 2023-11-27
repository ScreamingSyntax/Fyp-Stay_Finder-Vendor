import 'package:stayfinder_vendor/presentation/widgets/widgets_exports.dart';

import '../../logic/blocs/bloc_exports.dart';
import '../../logic/blocs/fetch_current_tier/fetch_current_tier_bloc.dart';

bool checkVerification(BuildContext context, LoginLoaded state) {
  var currentTierState = context.read<FetchVendorProfileBloc>().state;
  var currentProfileState = context.read<FetchCurrentTierBloc>().state;
  if (currentTierState is FetchVendorProfileLoaded) {
    if (currentTierState.vendorProfile.is_verified != 'True') {
      customScaffold(
          context: context,
          title: 'Oops',
          message: "Please Verify your profile first",
          contentType: ContentType.warning);
      return false;
    }
    if (currentTierState.vendorProfile.is_verified == 'True') {
      if (currentProfileState is FetchCurrentTierLoaded) {
        DateTime now = DateTime.now();
        DateTime paidTill =
            DateTime.parse(currentProfileState.currentTier.paid_till!);
        if (now.isAfter(paidTill)) {
          customScaffold(
              context: context,
              title: "Subscription Ended",
              message: "Your Subscription has ended, please renew",
              contentType: ContentType.warning);
          return false;
        }
      }
    }
  }
  return true;
}
