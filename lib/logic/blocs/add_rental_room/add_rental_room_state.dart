// ignore_for_file: must_be_immutable

part of 'add_rental_room_bloc.dart';

class AddRentalRoomState extends Equatable {
  Accommodation? accommodation;
  Room? room;
  File? accommodationImage;
  File? roomImage1;
  File? roomImage2;
  File? roomImage3;

  AddRentalRoomState(
      {this.accommodation,
      this.room,
      this.accommodationImage,
      this.roomImage1,
      this.roomImage2,
      this.roomImage3});

  AddRentalRoomState copyWith(
      {Accommodation? accommodation,
      Room? room,
      File? accommodationImage,
      File? roomImage1,
      File? roomImage2,
      File? roomImage3}) {
    return AddRentalRoomState(
        accommodation: accommodation ?? this.accommodation,
        accommodationImage: accommodationImage ?? this.accommodationImage,
        room: room ?? this.room,
        roomImage1: roomImage1 ?? this.roomImage1,
        roomImage2: roomImage2 ?? this.roomImage2,
        roomImage3: roomImage3 ?? this.roomImage3);
  }

  @override
  List<Object> get props {
    List toCheck = [
      this.accommodation,
      this.room,
      this.accommodationImage,
      this.roomImage1,
      this.roomImage2,
      this.roomImage3
    ];
    List<Object> toReturn = [];
    toCheck.forEach((element) {
      if (element != null) {
        toReturn.add(element);
      }
    });
    return toReturn;
  }
}

final class AddRentalRoomInitial extends AddRentalRoomState {}
