// ignore_for_file: must_be_immutable

part of 'room_addition_cubit.dart';

class RoomAdditionState extends Equatable {
  Room? room;
  RoomAdditionState({this.room});

  RoomAdditionState copyWith(Room? room) {
    return RoomAdditionState(room: room ?? this.room);
  }

  @override
  List<Object> get props {
    if (this.room != null) {
      return [this.room!];
    }
    return [];
  }
}
