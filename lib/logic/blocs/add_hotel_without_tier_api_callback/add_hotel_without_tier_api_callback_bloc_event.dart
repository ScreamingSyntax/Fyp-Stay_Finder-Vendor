part of 'add_hotel_without_tier_api_callback_bloc_bloc.dart';

sealed class AddHotelWithoutTierApiCallbackBlocEvent extends Equatable {
  const AddHotelWithoutTierApiCallbackBlocEvent();

  @override
  List<Object> get props => [];
}

class HitHotelWithoutTierApi extends AddHotelWithoutTierApiCallbackBlocEvent {
  final Accommodation accommodation;
  final List<Room?>? room;
  final File accommodationImage;
  final Map<int, List> roomImages;
  final String token;
  HitHotelWithoutTierApi(
      {required this.token,
      required this.accommodation,
      required this.room,
      required this.accommodationImage,
      required this.roomImages});
}
