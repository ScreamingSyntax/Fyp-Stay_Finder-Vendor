part of 'fetch_current_tier_bloc.dart';

sealed class FetchCurrentTierEvent extends Equatable {
  const FetchCurrentTierEvent();

  @override
  List<Object> get props => [];
}

class FetchCurrentTierHitEvent extends FetchCurrentTierEvent {
  final String token;

  FetchCurrentTierHitEvent({required this.token});
}
