part of 'add_rental_room_api_call_bloc.dart';

sealed class AddRentalRoomApiCallEvent extends Equatable {
  const AddRentalRoomApiCallEvent();

  @override
  List<Object> get props => [];
}

class AddRentalRoomHitEventApi extends AddRentalRoomApiCallEvent {
  final Accommodation accommodation;
  final Room room;
  final File accommodationImage;
  final File roomImage1;
  final File roomImage2;
  final File roomImage3;
  final String token;

  AddRentalRoomHitEventApi(
      {required this.accommodation,
      required this.room,
      required this.accommodationImage,
      required this.roomImage1,
      required this.roomImage2,
      required this.roomImage3,
      required this.token});
}
