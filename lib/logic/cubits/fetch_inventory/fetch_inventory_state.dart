part of 'fetch_inventory_cubit.dart';

sealed class FetchInventoryState extends Equatable {
  const FetchInventoryState();

  @override
  List<Object> get props => [];
}

class FetchInventoryInitial extends FetchInventoryState {}

class FetchInventoryError extends FetchInventoryState {
  final String message;

  FetchInventoryError({required this.message});
}

class FetchInventoryLoading extends FetchInventoryState {}

class FetchInventorySuccess extends FetchInventoryState {
  final List<InventoryItemModel> items;
  final List<InventoryLogs> itemLogs;
  final int ins;
  final int outs;
  final int total;

  FetchInventorySuccess(
      {required this.items,
      required this.itemLogs,
      required this.ins,
      required this.outs,
      required this.total});
}
