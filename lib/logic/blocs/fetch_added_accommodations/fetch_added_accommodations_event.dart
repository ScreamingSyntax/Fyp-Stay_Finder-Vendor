part of 'fetch_added_accommodations_bloc.dart';

sealed class FetchAddedAccommodationsEvent extends Equatable {
  const FetchAddedAccommodationsEvent();

  @override
  List<Object> get props => [];
}

class FetchAddedAccommodationHitEvent extends FetchAddedAccommodationsEvent {
  final String token;

  FetchAddedAccommodationHitEvent({required this.token});
}

class FetchAddedAccommodationResetEvent extends FetchAddedAccommodationsEvent {}
