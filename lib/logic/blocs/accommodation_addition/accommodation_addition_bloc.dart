import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stayfinder_vendor/data/model/accommodation_model.dart';

part 'accommodation_addition_event.dart';
part 'accommodation_addition_state.dart';

class AccommodationAdditionBloc
    extends Bloc<AccommodationAdditionEvent, AccommodationAdditionState> {
  AccommodationAdditionBloc() : super(AccommodationAdditionState()) {
    on<AccommodationAdditionHitEvent>((event, emit) {
      print(event.image);
      emit(AccommodationAdditionState(
          accommodation: event.accommodation ?? null,
          image: event.image ?? null));
    });
    on<AccommodationClearEvent>(
      (event, emit) =>
          AccommodationAdditionState(accommodation: null, image: null),
    );
    on<AccommodationAdditionUpdateHitEvent>(((event, emit) => emit(
        state.copyWith(
            accommodation: event.accommodation ?? state.accommodation,
            image: event.image ?? state.image))));
  }
  @override
  void onChange(Change<AccommodationAdditionState> change) {
    print(
        "The current state is ${change.currentState} and the next state is ${change.nextState}");
    super.onChange(change);
  }
}
