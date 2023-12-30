import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stayfinder_vendor/data/repository/repository_exports.dart';

import '../../../data/api/api_exports.dart';
import '../../../data/model/model_exports.dart';

part 'add_hotel_with_tier_api_event.dart';
part 'add_hotel_with_tier_api_state.dart';

class AddHotelWithTierApiBloc
    extends Bloc<AddHotelWithTierApiEvent, AddHotelWithTierApiState> {
  AddHotelWithTierApiBloc({required AccommodationAdditionRepository repository})
      : super(AddHotelWithTierApiInitial()) {
    on<AddHotelWithTierHitApiEvent>((event, emit) async {
      // emit(repository.)
      try {
        emit(AddHotelWithTierLoading());
        final Success success = await repository.hotelWithTierAddition(
            tierImages: event.tierImages,
            accommodation: event.accommodation,
            token: event.token,
            tier: event.tier,
            rooms: event.rooms,
            accommodationImage: event.accommodationImage);
        // emit(AddHotelWithTierLoading());
        if (success.success == 0) {
          print("It comes here brooo ");
          return emit(AddHotelWithTierError(message: success.message!));
        }
        return emit(AddHotelWithTierSuccess(message: success.message!));
      } catch (Exception) {
        return emit(AddHotelWithTierError(message: "Connection Error"));
      }
    });
  }
  @override
  void onChange(Change<AddHotelWithTierApiState> change) {
    print(
        "Current State : ${change.currentState} and the next state is ${change.nextState}");
    super.onChange(change);
  }
}
