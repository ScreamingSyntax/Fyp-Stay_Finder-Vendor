import 'package:stayfinder_vendor/presentation/widgets/widgets_exports.dart';

import '../../logic/blocs/bloc_exports.dart';
import '../../logic/blocs/fetch_added_accommodations/fetch_added_accommodations_bloc.dart';
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

bool checkLimit(BuildContext context, LoginLoaded state) {
  var currentTierState = context.read<FetchVendorProfileBloc>().state;
  var currentProfileState = context.read<FetchCurrentTierBloc>().state;
  var accommodationsState = context.read<FetchAddedAccommodationsBloc>().state;
  var tierList = context.read<FetchTierBloc>().state;
  if (currentTierState is FetchVendorProfileLoaded) {
    if (currentTierState.vendorProfile.is_verified == 'True') {
      if (currentProfileState is FetchCurrentTierLoaded) {
        late int accommodationLimit;
        if (tierList is FetchTierLoadedState) {
          tierList.tierList.forEach((element) {
            if (currentProfileState.currentTier.tier == element.id) {
              accommodationLimit = element.accomodationLimit!;
            }
          });
        }
        if (accommodationsState is FetchAddedAccommodationsLoaded) {
          print(accommodationsState.accommodation.length);

          if (accommodationsState.accommodation.length >= accommodationLimit) {
            customScaffold(
                context: context,
                title: "Limit Reached",
                message: "To add more upgrade your subscription",
                contentType: ContentType.failure);
            return false;
          }
        }
      }
    }
  }
  return true;
}
