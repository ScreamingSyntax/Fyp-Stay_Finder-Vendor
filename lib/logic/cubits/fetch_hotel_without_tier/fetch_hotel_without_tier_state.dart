part of 'fetch_hotel_without_tier_cubit.dart';

sealed class FetchHotelWithoutTierState extends Equatable {
  const FetchHotelWithoutTierState();

  @override
  List<Object> get props => [];
}

class FetchHotelWithoutTierInitial extends FetchHotelWithoutTierState {}

class FetchHotelWithoutTierLoading extends FetchHotelWithoutTierState {}

class FetchHotelWithoutTierSuccess extends FetchHotelWithoutTierState {
  final Accommodation accommodation;
  final List<Room> room;
  final List<RoomImage> image;

  FetchHotelWithoutTierSuccess(
      {required this.accommodation, required this.room, required this.image});
}

class FetchHotelWithoutTierError extends FetchHotelWithoutTierState {
  final String message;

  FetchHotelWithoutTierError({required this.message});
}
