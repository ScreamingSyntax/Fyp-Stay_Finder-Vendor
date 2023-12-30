part of 'fetch_rental_room_cubit.dart';

sealed class FetchRentalRoomState extends Equatable {
  const FetchRentalRoomState();

  @override
  List<Object> get props => [];
}

final class FetchRentalRoomInitial extends FetchRentalRoomState {}

class FetchRentalRoomLoading extends FetchRentalRoomState {}

class FetchRentalRoomError extends FetchRentalRoomState {
  final String message;

  FetchRentalRoomError({required this.message});
}

class FetchRentalRoomSuccess extends FetchRentalRoomState {
  final Accommodation accommodation;
  final Room room;
  final List<RoomImage> roomImages;

  FetchRentalRoomSuccess(
      {required this.accommodation,
      required this.room,
      required this.roomImages});
}
