import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stayfinder_vendor/data/model/accommodation_model.dart';
import 'package:stayfinder_vendor/data/model/room_model.dart';

part 'add_rental_room_event.dart';
part 'add_rental_room_state.dart';

class AddRentalRoomBloc extends Bloc<AddRentalRoomEvent, AddRentalRoomState> {
  AddRentalRoomBloc() : super(AddRentalRoomInitial()) {
    on<InitializeRentalRoomAccommodationEvent>(intializeRentalRoom);
    on<ClearRentalRoomAdditionStateEvent>(clearRentalRoom);
    on<UpdateAccommodationEvent>(updateAccommodation);
    on<InstantiateRoomImageEvent>(instantiateRoomImage);
  }

  FutureOr<void> instantiateRoomImage(event, emit) async {
    emit(state.copyWith(
        roomImage1: event.roomImages[0],
        roomImage2: event.roomImages[1],
        roomImage3: event.roomImages[2]));
  }

  FutureOr<void> updateAccommodation(event, emit) async {
    print(event.accommodation);
    await Future.delayed(Duration.zero);
    emit(state.copyWith(
        accommodation: event.accommodation ?? state.accommodation,
        room: event.room ?? state.room));
  }

  FutureOr<void> intializeRentalRoom(event, emit) {
    // Accommodation accommodation = event.accommodation ?
    // print(event.)
    print(event.accommodation);
    return emit(AddRentalRoomState(
        accommodation: event.accommodation ?? state.accommodation,
        accommodationImage:
            event.accommodationImage ?? state.accommodationImage,
        room: event.room ?? state.room));
  }

  FutureOr<void> clearRentalRoom(event, emit) {
    return emit(AddRentalRoomState(
        accommodation: null,
        accommodationImage: null,
        room: null,
        roomImage1: null,
        roomImage2: null,
        roomImage3: null));
  }

  @override
  void onChange(Change<AddRentalRoomState> change) {
    print(
        "Current State ${change.currentState}, next state ${change.nextState}");
    super.onChange(change);
  }
}
