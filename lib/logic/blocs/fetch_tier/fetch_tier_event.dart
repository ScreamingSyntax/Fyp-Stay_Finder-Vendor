part of 'fetch_tier_bloc.dart';

sealed class FetchTierEvent extends Equatable {
  const FetchTierEvent();

  @override
  List<Object> get props => [];
}

class FetchTierHitEvent extends FetchTierEvent {
  final String token;
  FetchTierHitEvent({required this.token});
}

class FetchTierClearEvent extends FetchTierEvent {}
