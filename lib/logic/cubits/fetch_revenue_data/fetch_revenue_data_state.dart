part of 'fetch_revenue_data_cubit.dart';

sealed class FetchRevenueDataState extends Equatable {
  const FetchRevenueDataState();

  @override
  List<Object> get props => [];
}

final class FetchRevenueDataInitial extends FetchRevenueDataState {}

class FetchRevenueDataLoading extends FetchRevenueDataState {}

class FetchRevenueDataSuccess extends FetchRevenueDataState {
  final Success success;

  FetchRevenueDataSuccess({required this.success});
}

class FetchRevenueDataError extends FetchRevenueDataState {
  final String message;

  FetchRevenueDataError({required this.message});
}
