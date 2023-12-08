import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stayfinder_vendor/data/model/accommodation_model.dart';

import '../../../data/model/model_exports.dart';
import '../../../data/repository/repository_exports.dart';

part 'add_hostel_api_call_event.dart';
part 'add_hostel_api_call_state.dart';

class AddHostelApiCallBloc
    extends Bloc<AddHostelApiCallEvent, AddHostelApiCallState> {
  AddHostelApiCallBloc({required AccommodationAdditionRepository repo})
      : super(AddHostelApiCallInitial()) {
    on<AddHostelApiAddEvent>((event, emit) async {
      try {
        emit(AddHostelApiCallLoading());
        Success response = await repo.hostelRoomAddition(
            accommodation: event.accommodation,
            room: event.room,
            token: event.token,
            roomImages: event.roomImages,
            accommodationImage: event.accommodationImage);
        if (response.success == 1) {
          return emit(AddHostelApiCallSuccess(message: response.message!));
        }
        return emit(AddHostelApiCallError(message: response.message!));
      } catch (Exception) {
        return emit(AddHostelApiCallError(message: "Connection Error"));
      }
    });
  }
  @override
  void onChange(Change<AddHostelApiCallState> change) {
    // TODO: implement onChange
    print(
        "The current state is ${change.currentState} and the next state is ${change.nextState}");
    super.onChange(change);
  }
}
