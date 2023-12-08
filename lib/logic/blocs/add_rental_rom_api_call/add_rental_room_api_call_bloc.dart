import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stayfinder_vendor/data/model/model_exports.dart';
import 'package:stayfinder_vendor/data/repository/repository_exports.dart';

part 'add_rental_room_api_call_event.dart';
part 'add_rental_room_api_call_state.dart';

class AddRentalRoomApiCallBloc
    extends Bloc<AddRentalRoomApiCallEvent, AddRentalRoomApiCallState> {
  AddRentalRoomApiCallBloc({required AccommodationAdditionRepository repo})
      : super(AddRentalRoomApiCallInitial()) {
    on<AddRentalRoomHitEventApi>(
      (event, emit) async {
        try {
          emit(AddRentalRoomApiCallLoading());
          Success success = await repo.addRentalRoom(
              token: event.token,
              accommodationImage: event.accommodationImage,
              accommodation: event.accommodation,
              room: event.room,
              roomImage1: event.roomImage1,
              roomImage2: event.roomImage2,
              roomImage3: event.roomImage3);
          if (success.success == 0) {
            return emit(AddRentalRoomApiCallError(message: success.message!));
          }
          if (success.success == 1) {
            return emit(AddRentalRoomApiCallSuccess(message: success.message!));
          }
        } catch (Exception) {
          return emit(AddRentalRoomApiCallError(message: "Connection Error"));
        }
      },
    );
  }
  @override
  void onChange(Change<AddRentalRoomApiCallState> change) {
    print(
        "The current state is ${change.currentState} and the next state is ${change.nextState}");
    super.onChange(change);
  }
}
