part of 'fetch_hostel_details_cubit.dart';

sealed class FetchHostelDetailsState extends Equatable {
  const FetchHostelDetailsState();

  @override
  List<Object> get props => [];
}

class FetchHostelDetailsInitial extends FetchHostelDetailsState {}

class FetchHostelDetailLoading extends FetchHostelDetailsState {}

class FetchHostelDetailSuccess extends FetchHostelDetailsState {
  Accommodation? accommodation;
  List<Room>? rooms;
  List<RoomImage>? images;
  FetchHostelDetailSuccess({this.accommodation, this.rooms, this.images});
}

class FetchHostelDetailError extends FetchHostelDetailsState {
  final String message;

  FetchHostelDetailError({required this.message});
}
