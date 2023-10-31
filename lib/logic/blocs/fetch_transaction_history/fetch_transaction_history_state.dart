part of 'fetch_transaction_history_bloc.dart';

sealed class FetchTransactionHistoryState extends Equatable {
  const FetchTransactionHistoryState();

  @override
  List<Object> get props => [];
}

final class FetchTransactionHistoryInitial
    extends FetchTransactionHistoryState {}

final class FetchTransactionHistoryLoading
    extends FetchTransactionHistoryState {}

final class FetchTransactionHistoryLoaded extends FetchTransactionHistoryState {
  final List<TransactionHistory> transactionHistory;

  FetchTransactionHistoryLoaded({required this.transactionHistory});
  @override
  List<Object> get props => [transactionHistory];
}

final class FetchTransactionHistoryError extends FetchTransactionHistoryState {
  final String message;
  FetchTransactionHistoryError({required this.message});
  @override
  List<Object> get props => [message];
}
