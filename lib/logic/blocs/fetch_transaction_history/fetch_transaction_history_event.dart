part of 'fetch_transaction_history_bloc.dart';

sealed class FetchTransactionHistoryEvent extends Equatable {
  const FetchTransactionHistoryEvent();

  @override
  List<Object> get props => [];
}

class FetchTransactionHistoryHitEvent extends FetchTransactionHistoryEvent {
  final String token;

  FetchTransactionHistoryHitEvent({required this.token});
}
