// ignore_for_file: must_be_immutable

part of 'add_hotel_without_tier_bloc.dart';

sealed class AddHotelWithoutTierEvent extends Equatable {
  const AddHotelWithoutTierEvent();

  @override
  List<Object> get props => [];
}

class AddHotelWithoutTierHitEvent extends AddHotelWithoutTierEvent {
  Accommodation? accommodation;
  Room? room;
  File? accommodationImage;
  List<File?>? images;
  AddHotelWithoutTierHitEvent(
      {this.accommodation, this.room, this.accommodationImage, this.images});
}

class UpdateHotelRoomWithoutTierHitEvent extends AddHotelWithoutTierEvent {
  final Room room;
  final int index;

  UpdateHotelRoomWithoutTierHitEvent({required this.room, required this.index});
}

class HostelWithoutTierChangePictureHitEvent extends AddHotelWithoutTierEvent {
  final int index;
  final File image1;
  final File image2;

  HostelWithoutTierChangePictureHitEvent({
    required this.image1,
    required this.image2,
    required this.index,
  });
}

class ChangeHotelWithoutTierAccommodationDetailEvent
    extends AddHotelWithoutTierEvent {
  Accommodation? accommodation;
  ChangeHotelWithoutTierAccommodationDetailEvent({required this.accommodation});
}

class ClearHotelWithoutTierAdditionEvent extends AddHotelWithoutTierEvent {
  final Room room;

  ClearHotelWithoutTierAdditionEvent({required this.room});
}

class ClearHotelWithoutTierRoomsEvent extends AddHotelWithoutTierEvent {}
