part of 'fetch_devices_cubit.dart';

class FetchDevicesState extends Equatable {
  FetchDevicesState();

  @override
  List<Object> get props => [];
}

class FetchDevicesLoading extends FetchDevicesState {}

class FetchDevicesSuccess extends FetchDevicesState {
  final List<DevicesModel> devices;

  FetchDevicesSuccess({required this.devices});
}

class FetchDevicesError extends FetchDevicesState {
  final String message;

  FetchDevicesError({required this.message});
}

class FetchDevicesInitial extends FetchDevicesState {}
