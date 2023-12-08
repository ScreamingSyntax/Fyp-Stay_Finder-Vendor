part of 'add_rental_room_api_call_bloc.dart';

class AddRentalRoomApiCallState extends Equatable {
  const AddRentalRoomApiCallState();

  @override
  List<Object> get props => [];
}

class AddRentalRoomApiCallInitial extends AddRentalRoomApiCallState {}

class AddRentalRoomApiCallLoading extends AddRentalRoomApiCallState {}

class AddRentalRoomApiCallSuccess extends AddRentalRoomApiCallState {
  final String message;

  AddRentalRoomApiCallSuccess({required this.message});
}

class AddRentalRoomApiCallError extends AddRentalRoomApiCallState {
  final String message;

  AddRentalRoomApiCallError({required this.message});
}
