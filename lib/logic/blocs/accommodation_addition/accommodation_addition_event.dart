// ignore_for_file: must_be_immutable

part of 'accommodation_addition_bloc.dart';

class AccommodationAdditionEvent extends Equatable {
  const AccommodationAdditionEvent();
  @override
  List<Object> get props => [];
}

class AccommodationAdditionHitEvent extends AccommodationAdditionEvent {
  Accommodation? accommodation;
  File? image;
  AccommodationAdditionHitEvent({this.accommodation, this.image});
}

class AccommodationAdditionUpdateHitEvent extends AccommodationAdditionEvent {
  Accommodation? accommodation;
  File? image;
  AccommodationAdditionUpdateHitEvent({this.accommodation, this.image});
}

class AccommodationClearEvent extends AccommodationAdditionEvent {}
