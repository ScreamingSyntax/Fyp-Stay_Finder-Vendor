// ignore_for_file: must_be_immutable

part of 'accommodation_addition_bloc.dart';

class AccommodationAdditionState extends Equatable {
  Accommodation? accommodation;
  File? image;

  AccommodationAdditionState({this.accommodation, this.image});
  AccommodationAdditionState copyWith(
      {Accommodation? accommodation, File? image}) {
    return AccommodationAdditionState(
        accommodation: accommodation ?? this.accommodation,
        image: image ?? this.image);
  }

  @override
  @override
  List<Object?> get props {
    return [accommodation, image]..removeWhere((element) => element == null);
  }
}
