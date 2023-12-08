// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stayfinder_vendor/data/model/accommodation_model.dart';
import 'package:stayfinder_vendor/data/model/room_model.dart';

part 'hostel_addition_event.dart';
part 'hostel_addition_state.dart';

class HostelAdditionBloc
    extends Bloc<HostelAdditionEvent, HostelAdditionState> {
  HostelAdditionBloc() : super(HostelAdditionState()) {
    on<HostelAddtionHitEvent>(hostelInitizalization);
    on<HostelUpdateRoomDetailsHitEvent>(updateRoomDetails);
    on<ClearHostelAdditionEvent>(clearRoomDetails);
    on<HostelChangePictureHitEvent>(changeImageClear);
    on<ChangeAccommodationDetailEvent>(changeAccommodation);
    on<ClearRoomsEvent>(clearRooms);
  }
  Future<void> clearRooms(
      ClearRoomsEvent event, Emitter<HostelAdditionState> emit) async {
    return emit(state.copyWith(room: [], roomImages: {}));
  }

  Future<void> changeAccommodation(ChangeAccommodationDetailEvent event,
      Emitter<HostelAdditionState> emit) async {
    Accommodation? accommodation = event.accommodation;
    emit(state.copyWith(accommodation: accommodation));
  }

  Future<void> changeImageClear(HostelChangePictureHitEvent event,
      Emitter<HostelAdditionState> emit) async {
    // print(state.roomImages);
    print("These are the room images ${state.roomImages}");
    print("These are the room index ${event.index}");
    Map<int, List> roomImages = Map.from(state.roomImages!);
    roomImages[event.index] = [event.image2, event.image1];
    return emit(state.copyWith(roomImages: roomImages));
  }

  Future<void> hostelInitizalization(
      HostelAddtionHitEvent event, Emitter<HostelAdditionState> emit) async {
    // print(event.accommodation);
    Accommodation? accommodation = event.accommodation;
    List<Room?>? newRoom = [];
    Map<int, List>? roomImages = {};
    if (event.room != null && state.room != null) {
      int index = state.room!.length + 1;
      event.room!.id = index;
      newRoom = List<Room>.from(state.room!).toList()..add(event.room!);
      roomImages = state.roomImages;
      roomImages![index] = [event.images![0], event.images![1]];
    }
    if (event.room != null && state.room == null) {
      int index = 0;
      event.room!.id = index;
      roomImages[index] = [event.images![0], event.images![1]];
      newRoom = newRoom..add(event.room);
    }
    if (state.room != null && event.room == null) {
      roomImages = state.roomImages;
      newRoom = List<Room>.from(state.room!).toList();
    }
    return emit(HostelAdditionState(
        accommodation: accommodation ?? state.accommodation,
        room: newRoom,
        roomImages: roomImages,
        accommodationImage:
            event.accommodationImage ?? state.accommodationImage));
  }

  Future<void> clearRoomDetails(
      ClearHostelAdditionEvent event, Emitter<HostelAdditionState> emit) async {
    List<Room?>? room = List<Room>.from(state.room!).toList();
    room.remove(event.room);
    Map<int, List> images = Map.from(state.roomImages!);
    images.remove(event.room.id);
    return emit(state.copyWith(room: room, roomImages: images));
  }

  Future<void> updateRoomDetails(HostelUpdateRoomDetailsHitEvent event,
      Emitter<HostelAdditionState> emit) async {
    int index = event.index;
    List<Room?>? stateRooms = state.room;
    List<Room?>? rooms = List<Room?>.from(stateRooms!).toList();
    rooms[index] = event.room;
    return emit(state.copyWith(room: rooms));
  }

  @override
  void onChange(Change<HostelAdditionState> change) {
    print(
        "The current accommodation  is ${change.currentState.accommodation} and the next accommodation is ${change.nextState.accommodation}");
    print(
        "The current room list is ${change.currentState.room} and the next room list is ${change.nextState.room}");
    print(
        "The current accommodation Image is ${change.currentState.accommodationImage} and the next image is ${change.nextState.accommodationImage}");
    super.onChange(change);
  }
}
