// ignore_for_file: must_be_immutable

part of 'store_rooms_cubit.dart';

class StoreRoomsState extends Equatable {
  List<Room>? rooms;
  StoreRoomsState({this.rooms});
  StoreRoomsState copyWith(List<Room>? room) {
    return StoreRoomsState(rooms: room ?? this.rooms);
  }

  @override
  List<Object> get props => [rooms!];
}
