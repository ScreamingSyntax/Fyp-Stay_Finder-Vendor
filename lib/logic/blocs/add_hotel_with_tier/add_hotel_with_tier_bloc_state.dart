// ignore_for_file: must_be_immutable

part of 'add_hotel_with_tier_bloc_bloc.dart';

class AddHotelWithTierBlocState extends Equatable {
  Accommodation? accommodation;
  Map<int, Tier>? tier;
  Map<int, List<Room>>? rooms;
  File? accommodationImage;
  // File? tierImage;
  Map<int, File>? tierImages;
  AddHotelWithTierBlocState(
      {this.accommodation,
      this.tier,
      this.rooms,
      this.accommodationImage,
      this.tierImages});
  AddHotelWithTierBlocState copyWith(
      {Accommodation? accommodation,
      Map<int, Tier>? tier,
      Map<int, List<Room>>? rooms,
      File? accommodationImage,
      Map<int, File>? tierImages}) {
    return AddHotelWithTierBlocState(
        accommodation: accommodation ?? this.accommodation,
        accommodationImage: accommodationImage ?? this.accommodationImage,
        rooms: rooms ?? this.rooms,
        tier: tier ?? this.tier,
        tierImages: tierImages ?? this.tierImages);
  }

  @override
  List<Object> get props {
    List instances = [
      this.accommodation,
      this.tierImages,
      this.tier,
      this.rooms,
      this.accommodationImage
    ];
    List<Object> toReturn = [];
    instances.forEach((element) {
      if (element != null) {
        toReturn.add(element);
      }
    });
    return toReturn;
  }
}
