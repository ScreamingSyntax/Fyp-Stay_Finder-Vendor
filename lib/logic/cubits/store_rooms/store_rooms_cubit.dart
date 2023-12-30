import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stayfinder_vendor/data/model/model_exports.dart';

part 'store_rooms_state.dart';

class StoreRoomsCubit extends Cubit<StoreRoomsState> {
  StoreRoomsCubit() : super(StoreRoomsState(rooms: []));
  void addRooms(Room room) {
    List<Room> rooms = List<Room>.from(state.rooms!).toList();
    rooms.add(room);
    emit(state.copyWith(rooms));
  }

  void clearEverything() {
    emit(state.copyWith(List<Room>.from([]).toList()));
  }

  void deleteRoom(Room room) {
    List<Room> rooms = List<Room>.from(state.rooms!).toList();
    rooms.remove(room);
    emit(state.copyWith(rooms));
  }

  void edit(int index, Room room) {
    List<Room> rooms = List<Room>.from(state.rooms!).toList();
    rooms[index] = room;
    emit(state.copyWith(rooms));
  }

  @override
  void onChange(Change<StoreRoomsState> change) {
    print(
        "The current state is ${change.currentState} and the next state is ${change.nextState}");
    super.onChange(change);
  }
}
