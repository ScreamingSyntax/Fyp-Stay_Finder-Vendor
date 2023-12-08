part of 'fetch_added_accommodations_bloc.dart';

sealed class FetchAddedAccommodationsState extends Equatable {
  const FetchAddedAccommodationsState();

  @override
  List<Object> get props => [];
}

class FetchAddedAccommodationsInitial extends FetchAddedAccommodationsState {}

class FetchAddedAccommodationsLoading extends FetchAddedAccommodationsState {}

class FetchAddedAccommodationsError extends FetchAddedAccommodationsState {
  final String error;
  FetchAddedAccommodationsError({required this.error});
}

class FetchAddedAccommodationsLoaded extends FetchAddedAccommodationsState {
  final List<Accommodation> accommodation;

  FetchAddedAccommodationsLoaded({required this.accommodation});
}
