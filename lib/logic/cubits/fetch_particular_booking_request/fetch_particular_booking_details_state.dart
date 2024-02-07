// ignore_for_file: must_be_immutable

part of 'fetch_particular_booking_details_cubit.dart';

sealed class FetchParticularBookingDetailsState extends Equatable {
  const FetchParticularBookingDetailsState();

  @override
  List<Object> get props => [];
}

class FetchParticularBookingDetailsInitial
    extends FetchParticularBookingDetailsState {}

class FetchParticularBookingDetailsLoading
    extends FetchParticularBookingDetailsState {}

class FetchParticularBookingDetailsLoaded
    extends FetchParticularBookingDetailsState {
  HotelTier? tier;
  Room? room;
  Accommodation? accommodation;
  Booked? booked;
  List<RoomImage?>? roomImage;
  FetchParticularBookingDetailsLoaded(
      {this.tier, this.room, this.accommodation, this.booked, this.roomImage});
}

class FetchParticularBookingDetailsError
    extends FetchParticularBookingDetailsState {
  final String message;

  FetchParticularBookingDetailsError(this.message);
}
