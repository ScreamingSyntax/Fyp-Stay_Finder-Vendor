import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/model/room_model.dart';

part 'room_addition_state.dart';

class RoomAdditionCubit extends Cubit<RoomAdditionState> {
  RoomAdditionCubit()
      : super(RoomAdditionState(
            room: Room(
          ac_availability: false,
          bed_availability: false,
          carpet_availability: false,
          coffee_powder_availability: false,
          dustbin_availability: false,
          fan_availability: false,
          hair_dryer_availability: false,
          kettle_availability: false,
          mat_availability: false,
          milk_powder_availability: false,
          sofa_availability: false,
          steam_iron_availability: false,
          tea_powder_availability: false,
          tv_availability: false,
          water_bottle_availability: false,
        )));
  void RoomUpdate(Room room) {
    return emit(RoomAdditionState(room: room));
  }

  @override
  void onChange(Change<RoomAdditionState> change) {
    print(
        "The current state is ${change.currentState} and the next state is ${change.nextState}");
    super.onChange(change);
  }
}
