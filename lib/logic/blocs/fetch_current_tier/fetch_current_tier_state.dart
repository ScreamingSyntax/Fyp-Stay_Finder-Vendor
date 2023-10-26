part of 'fetch_current_tier_bloc.dart';

sealed class FetchCurrentTierState extends Equatable {
  const FetchCurrentTierState();

  @override
  List<Object> get props => [];
}

final class FetchCurrentTierInitial extends FetchCurrentTierState {}

final class FetchCurrentTierLoading extends FetchCurrentTierState {}

final class FetchCurrentTierLoaded extends FetchCurrentTierState {
  final CurrentTier currentTier;

  FetchCurrentTierLoaded({required this.currentTier});
  List<Object> get props => [currentTier];
}

final class FetchCurrentTierError extends FetchCurrentTierState {
  final String message;

  FetchCurrentTierError({required this.message});
  List<Object> get props => [message];
}
