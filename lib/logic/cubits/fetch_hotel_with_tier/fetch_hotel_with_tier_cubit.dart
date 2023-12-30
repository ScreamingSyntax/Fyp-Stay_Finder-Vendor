import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stayfinder_vendor/data/model/model_exports.dart';
import 'package:stayfinder_vendor/data/repository/repository_exports.dart';

part 'fetch_hotel_with_tier_state.dart';

class FetchHotelWithTierCubit extends Cubit<FetchHotelWithTierState> {
  HotelWithTierRepository _hotelWithTierRepository = HotelWithTierRepository();
  FetchHotelWithTierCubit() : super(FetchHotelWithTierInitial());
  void fetchHotelWithTierDetails(
      {required String token, required String acccommodationID}) async {
    emit(FetchHotelTierLoading());
    Success success = await _hotelWithTierRepository.fetchHotelDetails(
        token: token, accommodation_id: acccommodationID);
    if (success.success == 1) {
      // print("a");
      return emit(FetchHotelTierSuccess(
          Accommodation.fromMap(success.data!["accommodation"]),
          List.from(success.data!['tier'])
              .map((e) => HotelTier.fromMap(e))
              .toList(),
          List.from(success.data!["room"])
              .map((e) => Room.fromMap(e))
              .toList()));
    }
    print(success);
    emit(FetchHotelWithTierError(message: success.message!));
  }

  @override
  void onChange(Change<FetchHotelWithTierState> change) {
    print("Current state ${change.currentState} next ${change.nextState}");
    // TODO: implement onChange
    super.onChange(change);
  }
}
