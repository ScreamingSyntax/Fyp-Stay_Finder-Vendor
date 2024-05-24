part of 'delete_device_cubit.dart';

sealed class DeleteDeviceState extends Equatable {
  const DeleteDeviceState();

  @override
  List<Object> get props => [];
}

class DeleteDeviceInitial extends DeleteDeviceState {}

class DeleteDeviceLoading extends DeleteDeviceState {}

class DeleteDeviceSuccess extends DeleteDeviceState {
  final String message;

  DeleteDeviceSuccess({required this.message});
}

class DeleteDeviceError extends DeleteDeviceState {
  final String message;

  DeleteDeviceError({required this.message});
}
