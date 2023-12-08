// ignore_for_file: must_be_immutable

part of 'hostel_addition_bloc.dart';

class HostelAdditionState extends Equatable {
  Accommodation? accommodation;
  File? accommodationImage;
  List<Room?>? room;
  Map<int, List>? roomImages;
  HostelAdditionState(
      {this.accommodation,
      this.room,
      this.roomImages,
      this.accommodationImage});

  HostelAdditionState copyWith({
    Accommodation? accommodation,
    List<Room?>? room,
    File? accommodationImage,
    Map<int, List>? roomImages,
  }) {
    return HostelAdditionState(
      accommodation: accommodation ?? this.accommodation,
      room: room ?? this.room,
      accommodationImage: accommodationImage ?? this.accommodationImage,
      roomImages: roomImages ?? this.roomImages,
    );
  }

  @override
  List<Object> get props {
    List<Object?>? items = [
      this.accommodation,
      this.room,
      this.roomImages,
      this.accommodationImage
    ];
    List<Object> toReturn = [];
    items.forEach((element) {
      if (element != null) {
        toReturn.add(element);
      }
    });
    return toReturn;
  }
}
