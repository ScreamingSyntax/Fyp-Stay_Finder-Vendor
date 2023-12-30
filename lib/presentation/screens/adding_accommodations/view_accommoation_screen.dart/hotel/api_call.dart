import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../logic/cubits/fetch_hotel_with_tier/fetch_hotel_with_tier_cubit.dart';
import '../../../../widgets/widgets_exports.dart';

class CallHotelWithTierAPi {
  static void fetchHotelWithTierApis(
      {required String token,
      required String accommodationID,
      required BuildContext context}) {
    context.read<FetchHotelWithTierCubit>()
      ..fetchHotelWithTierDetails(
          token: token, acccommodationID: accommodationID);
  }
}
