part of 'add_hotel_with_tier_api_bloc.dart';

class AddHotelWithTierApiEvent extends Equatable {
  const AddHotelWithTierApiEvent();

  @override
  List<Object> get props => [];
}

class AddHotelWithTierHitApiEvent extends AddHotelWithTierApiEvent {
  final Accommodation accommodation;
  final Map<int, Tier> tier;
  final Map<int, List<Room>> rooms;
  final File accommodationImage;
  final String token;
  final Map<int, File>? tierImages;

  AddHotelWithTierHitApiEvent(
      {required this.accommodation,
      required this.token,
      required this.tierImages,
      required this.tier,
      required this.rooms,
      required this.accommodationImage});
}
