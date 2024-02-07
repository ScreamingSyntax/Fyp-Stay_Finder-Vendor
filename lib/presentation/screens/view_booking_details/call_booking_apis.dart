import 'package:stayfinder_vendor/data/model/model_exports.dart';
import 'package:stayfinder_vendor/logic/blocs/bloc_exports.dart';
import 'package:stayfinder_vendor/logic/cubits/fetch_particular_booking_request/fetch_particular_booking_details_cubit.dart';

import '../../widgets/widgets_exports.dart';

class CallBookingDetailsParticularAPi {
  static void fetchHotelWithTierApis(
      {required String token,
      required String id,
      required Accommodation accommodation,
      required BuildContext context}) {
    context.read<FetchParticularBookingDetailsCubit>()
      ..fetchParticularBookingDetails(
          token: token, id: id, accommodation: accommodation);
  }
}
