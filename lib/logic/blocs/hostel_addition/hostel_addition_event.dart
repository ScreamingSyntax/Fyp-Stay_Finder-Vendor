// ignore_for_file: must_be_immutable

part of 'hostel_addition_bloc.dart';

sealed class HostelAdditionEvent extends Equatable {
  const HostelAdditionEvent();

  @override
  List<Object> get props => [];
}

class HostelAddtionHitEvent extends HostelAdditionEvent {
  Accommodation? accommodation;
  Room? room;
  File? accommodationImage;
  List<File?>? images;
  HostelAddtionHitEvent(
      {this.accommodation, this.room, this.accommodationImage, this.images});
}

class HostelUpdateRoomDetailsHitEvent extends HostelAdditionEvent {
  final Room room;
  final int index;

  HostelUpdateRoomDetailsHitEvent({required this.room, required this.index});
}

class HostelChangePictureHitEvent extends HostelAdditionEvent {
  final int index;
  final File image1;
  final File image2;

  HostelChangePictureHitEvent({
    required this.image1,
    required this.image2,
    required this.index,
  });
}

class ChangeAccommodationDetailEvent extends HostelAdditionEvent {
  Accommodation? accommodation;
  ChangeAccommodationDetailEvent({required this.accommodation});
}

class ClearHostelAdditionEvent extends HostelAdditionEvent {
  final Room room;

  ClearHostelAdditionEvent({required this.room});
}

class ClearRoomsEvent extends HostelAdditionEvent {}
