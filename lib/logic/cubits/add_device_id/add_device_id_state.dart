part of 'add_device_id_cubit.dart';

class AddDeviceIdState extends Equatable {
  AddDeviceIdState();

  @override
  List<Object> get props => [];
}

class AddDeviceIdInitial extends AddDeviceIdState {}

class AddDeviceIdLoading extends AddDeviceIdState {}

class AddDeviceIdSuccess extends AddDeviceIdState {
  final Success success;

  AddDeviceIdSuccess({required this.success});
}

class AddDeviceIdError extends AddDeviceIdState {
  final Success success;

  AddDeviceIdError({required this.success});
}
