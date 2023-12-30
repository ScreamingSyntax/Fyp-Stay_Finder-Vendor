part of 'fetch_hotel_with_tier_cubit.dart';

sealed class FetchHotelWithTierState extends Equatable {
  const FetchHotelWithTierState();

  @override
  List<Object> get props => [];
}

class FetchHotelWithTierInitial extends FetchHotelWithTierState {}

class FetchHotelTierLoading extends FetchHotelWithTierState {}

class FetchHotelTierSuccess extends FetchHotelWithTierState {
  final Accommodation accommodation;
  final List<HotelTier> tier;
  final List<Room> room;

  FetchHotelTierSuccess(this.accommodation, this.tier, this.room);
  // final String message;
}

class FetchHotelWithTierError extends FetchHotelWithTierState {
  final String message;

  FetchHotelWithTierError({required this.message});
}
