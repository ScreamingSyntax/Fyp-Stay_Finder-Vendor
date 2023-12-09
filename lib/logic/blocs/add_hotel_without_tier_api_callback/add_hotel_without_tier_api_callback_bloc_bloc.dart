import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stayfinder_vendor/data/model/model_exports.dart';
import 'package:stayfinder_vendor/data/repository/accommodation_addition_repository.dart';

import '../../../data/api/api_exports.dart';

part 'add_hotel_without_tier_api_callback_bloc_event.dart';
part 'add_hotel_without_tier_api_callback_bloc_state.dart';

class AddHotelWithoutTierApiCallbackBlocBloc extends Bloc<
    AddHotelWithoutTierApiCallbackBlocEvent,
    AddHotelWithoutTierApiCallbackBlocState> {
  AddHotelWithoutTierApiCallbackBlocBloc(
      {required AccommodationAdditionRepository repo})
      : super(AddHotelWithoutTierApiCallbackBlocInitial()) {
    on<HitHotelWithoutTierApi>((event, emit) async {
      emit(AddHotelWithoutTierApiCallbackBlocLoading());
      Success success = await repo.hotelWithoutTierAddition(
          token: event.token,
          accommodation: event.accommodation,
          rooms: event.room,
          accommodationImage: event.accommodationImage,
          roomImages: event.roomImages);
      if (success.success == 0) {
        return emit(AddHotelWithoutTierApiCallbackBlocError(
            message: success.message.toString()));
      }
      return emit(AddHotelWithoutTierApiCallbackBlocSuccess(
          message: success.message.toString()));
    });
  }
}
