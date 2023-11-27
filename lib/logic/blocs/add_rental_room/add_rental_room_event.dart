// ignore_for_file: must_be_immutable

part of 'add_rental_room_bloc.dart';

class AddRentalRoomEvent extends Equatable {
  const AddRentalRoomEvent();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class InitializeRentalRoomAccommodationEvent extends AddRentalRoomEvent {
  Accommodation? accommodation;
  Room? room;
  File? accommodationImage;
  InitializeRentalRoomAccommodationEvent(
      {this.accommodation, this.room, this.accommodationImage});
}

class UpdateAccommodationEvent extends AddRentalRoomEvent {
  Accommodation? accommodation;

  Room? room;
  UpdateAccommodationEvent({this.accommodation, this.room});
}

class InstantiateRoomImageEvent extends AddRentalRoomEvent {
  final List<File> roomImages;

  InstantiateRoomImageEvent({required this.roomImages});
}

class ClearRentalRoomAdditionStateEvent extends AddRentalRoomEvent {}
