import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/api/api_exports.dart';
import '../../../data/model/model_exports.dart';

part 'add_hotel_without_tier_event.dart';
part 'add_hotel_without_tier_state.dart';

class AddHotelWithoutTierBloc
    extends Bloc<AddHotelWithoutTierEvent, AddHotelWithoutTierState> {
  AddHotelWithoutTierBloc() : super(AddHotelWithoutTierState()) {
    on<AddHotelWithoutTierEvent>((event, emit) {});
    on<AddHotelWithoutTierHitEvent>(hostelInitizalization);
    on<UpdateHotelRoomWithoutTierHitEvent>(updateRoomDetails);
    on<ClearHotelWithoutTierAdditionEvent>(clearRoomDetails);
    on<HostelWithoutTierChangePictureHitEvent>(changeImageClear);
    on<ChangeHotelWithoutTierAccommodationDetailEvent>(changeAccommodation);
    on<ClearHotelWithoutTierRoomsEvent>(clearRooms);
  }
  Future<void> clearRooms(ClearHotelWithoutTierRoomsEvent event,
      Emitter<AddHotelWithoutTierState> emit) async {
    return emit(state.copyWith(room: [], roomImages: {}));
  }

  Future<void> changeAccommodation(
      ChangeHotelWithoutTierAccommodationDetailEvent event,
      Emitter<AddHotelWithoutTierState> emit) async {
    Accommodation? accommodation = event.accommodation;
    return emit(state.copyWith(accommodation: accommodation));
  }

  Future<void> changeImageClear(HostelWithoutTierChangePictureHitEvent event,
      Emitter<AddHotelWithoutTierState> emit) async {
    print(state.roomImages);
    // print("This is state image")
    // Map<int, List> roomImages = Map.from(state.roomImages!);
    // roomImages[event.index] = [event.roomImage];
    // return emit(state.copyWith(roomImages: roomImages));
  }

  Future<void> hostelInitizalization(AddHotelWithoutTierHitEvent event,
      Emitter<AddHotelWithoutTierState> emit) async {
    // print(event.accommodation);
    Accommodation? accommodation = event.accommodation;
    List<Room?>? newRoom = [];
    Map<int, List>? roomImages = {};
    if (event.room != null && state.room != null) {
      int index = state.room![state.room!.length - 1]!.id! + 1;
      event.room!.id = index;
      newRoom = List<Room>.from(state.room!).toList()..add(event.room!);
      roomImages = state.roomImages;
      roomImages![index] = [event.roomImage];
    }
    if (event.room != null && state.room == null) {
      int index = 0;
      event.room!.id = index;
      roomImages[index] = [event.roomImage];
      newRoom = newRoom..add(event.room);
    }
    if (state.room != null && event.room == null) {
      roomImages = state.roomImages;
      newRoom = List<Room>.from(state.room!).toList();
    }
    return emit(AddHotelWithoutTierState(
        accommodation: accommodation ?? state.accommodation,
        room: newRoom,
        roomImages: roomImages,
        accommodationImage:
            event.accommodationImage ?? state.accommodationImage));
  }

  Future<void> updateRoomDetails(UpdateHotelRoomWithoutTierHitEvent event,
      Emitter<AddHotelWithoutTierState> emit) async {
    int index = event.index;
    List<Room?>? stateRooms = state.room;
    List<Room?>? rooms = List<Room?>.from(stateRooms!).toList();
    event.room.id = rooms[index - 1]!.id;
    print(event.room);
    print(rooms);
    rooms[index - 1] = event.room;
    print(rooms);
    return emit(state.copyWith(room: rooms));
  }

  Future<void> clearRoomDetails(ClearHotelWithoutTierAdditionEvent event,
      Emitter<AddHotelWithoutTierState> emit) async {
    List<Room?>? room = List<Room>.from(state.room!).toList();
    room.remove(event.room);
    Map<int, List> images = Map.from(state.roomImages!);
    images.remove(event.room.id);
    return emit(state.copyWith(room: room, roomImages: images));
  }

  @override
  void onChange(Change<AddHotelWithoutTierState> change) {
    print(
        "The current state is ${change.currentState} and the next state is ${change.nextState}");
    super.onChange(change);
  }
}
