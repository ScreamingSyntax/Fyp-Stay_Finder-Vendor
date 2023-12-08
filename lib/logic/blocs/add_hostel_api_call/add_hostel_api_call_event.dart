// ignore_for_file: must_be_immutable

part of 'add_hostel_api_call_bloc.dart';

sealed class AddHostelApiCallEvent extends Equatable {
  const AddHostelApiCallEvent();

  @override
  List<Object> get props => [];
}

class AddHostelApiAddEvent extends AddHostelApiCallEvent {
  final Accommodation accommodation;
  final File accommodationImage;
  final List<Room?> room;
  final Map<int, List> roomImages;
  final String token;

  AddHostelApiAddEvent(
      {required this.accommodation,
      required this.token,
      required this.accommodationImage,
      required this.room,
      required this.roomImages});

  // AddHostelApiAddEvent(this.accommodation, this.accommodationImage, this.room);
}
