part of 'add_hotel_without_tier_api_callback_bloc_bloc.dart';

sealed class AddHotelWithoutTierApiCallbackBlocState extends Equatable {
  const AddHotelWithoutTierApiCallbackBlocState();

  @override
  List<Object> get props => [];
}

class AddHotelWithoutTierApiCallbackBlocInitial
    extends AddHotelWithoutTierApiCallbackBlocState {}

class AddHotelWithoutTierApiCallbackBlocLoading
    extends AddHotelWithoutTierApiCallbackBlocState {}

final class AddHotelWithoutTierApiCallbackBlocSuccess
    extends AddHotelWithoutTierApiCallbackBlocState {
  final String message;

  AddHotelWithoutTierApiCallbackBlocSuccess({required this.message});
}

final class AddHotelWithoutTierApiCallbackBlocError
    extends AddHotelWithoutTierApiCallbackBlocState {
  final String message;

  AddHotelWithoutTierApiCallbackBlocError({required this.message});
}
