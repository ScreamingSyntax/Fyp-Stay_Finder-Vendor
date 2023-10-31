import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stayfinder_vendor/data/model/model_exports.dart';
import 'package:stayfinder_vendor/data/repository/repository_exports.dart';

part 'fetch_transaction_history_event.dart';
part 'fetch_transaction_history_state.dart';

class FetchTransactionHistoryBloc
    extends Bloc<FetchTransactionHistoryEvent, FetchTransactionHistoryState> {
  FetchTransactionHistoryBloc(
      {required TransactionHistoryRepository transactionHistoryRepository})
      : super(FetchTransactionHistoryInitial()) {
    on<FetchTransactionHistoryHitEvent>((event, emit) async {
      return await fetchTransactionHistory(
          event, emit, transactionHistoryRepository);
    });
  }
  Future<void> fetchTransactionHistory(
      FetchTransactionHistoryHitEvent event,
      Emitter<FetchTransactionHistoryState> emit,
      TransactionHistoryRepository transactionHistoryRepository) async {
    emit(FetchTransactionHistoryLoading());
    List<TransactionHistory> transactionHistoryList =
        await transactionHistoryRepository.getTransactionHistory(
            token: event.token);
    if (transactionHistoryList[0].error != null) {
      return emit(FetchTransactionHistoryError(
          message: transactionHistoryList[0].error!));
    }
    return emit(FetchTransactionHistoryLoaded(
        transactionHistory: transactionHistoryList));
  }

  @override
  void onChange(Change<FetchTransactionHistoryState> change) {
    print(
        "Current State ${change.currentState}, next state ${change.nextState}");
    super.onChange(change);
  }
}
