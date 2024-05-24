part of 'add_inventory_cubit.dart';

sealed class AddInventoryState extends Equatable {
  const AddInventoryState();

  @override
  List<Object> get props => [];
}

class AddInventoryInitial extends AddInventoryState {}

class AddInventoryLoading extends AddInventoryState {}

class AddInventorySuccess extends AddInventoryState {
  final String message;

  AddInventorySuccess({required this.message});
}

class AddInventoryError extends AddInventoryState {
  final String message;

  AddInventoryError({required this.message});
}
