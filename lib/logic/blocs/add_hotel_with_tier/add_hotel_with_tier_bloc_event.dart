// ignore_for_file: must_be_immutable

part of 'add_hotel_with_tier_bloc_bloc.dart';

sealed class AddHotelWithTierBlocEvent extends Equatable {
  AddHotelWithTierBlocEvent();

  @override
  List<Object> get props => [];
}

// class AddHotelRoomsWithTierEvent extends AddHotelWithTierBlocEvent {

//   AddHotelRoomsWithTierEvent({required this.tierID, required this.room});
// }

class AddHotelTierWithTierEvent extends AddHotelWithTierBlocEvent {
  final Tier tier;
  final File tierImage;
  final List<Room> rooms;

  AddHotelTierWithTierEvent(
      {required this.tier, required this.tierImage, required this.rooms});
}

class AddAccommodationWithTierEvent extends AddHotelWithTierBlocEvent {
  final Accommodation accommodation;
  final File accommodationImage;
  AddAccommodationWithTierEvent(
      {required this.accommodation, required this.accommodationImage});
}

class DeleteTierOnAccommodationWithTierEvent extends AddHotelWithTierBlocEvent {
  final Tier tier;
  DeleteTierOnAccommodationWithTierEvent(this.tier);
}

class ClearEverythingAccommodationWithTierEvent
    extends AddHotelWithTierBlocEvent {}
