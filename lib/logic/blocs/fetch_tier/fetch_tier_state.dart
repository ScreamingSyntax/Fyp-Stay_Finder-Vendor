part of 'fetch_tier_bloc.dart';

sealed class FetchTierState extends Equatable {
  const FetchTierState();

  @override
  List<Object> get props => [];
}

final class FetchTierInitialState extends FetchTierState {}

final class FetchTierLoadingState extends FetchTierState {}

final class TierLoadedState extends FetchTierState {
  final List<Tier> tierList;
  TierLoadedState({required this.tierList});
  @override
  List<Object> get props => [tierList];
}

final class TierErrorState extends FetchTierState {
  final String errorMessage;
  TierErrorState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
