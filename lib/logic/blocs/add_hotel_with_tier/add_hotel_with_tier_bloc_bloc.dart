import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/api/api_exports.dart';
import '../../../data/model/model_exports.dart';

part 'add_hotel_with_tier_bloc_event.dart';
part 'add_hotel_with_tier_bloc_state.dart';

class AddHotelWithTierBlocBloc
    extends Bloc<AddHotelWithTierBlocEvent, AddHotelWithTierBlocState> {
  AddHotelWithTierBlocBloc() : super(AddHotelWithTierBlocState()) {
    on<AddAccommodationWithTierEvent>(addAccommodation);
    on<AddHotelTierWithTierEvent>(addHotelWithTier);
    on<DeleteTierOnAccommodationWithTierEvent>(clearTierHotel);
    on<ClearEverythingAccommodationWithTierEvent>(clearAllTiers);
  }
  Future<void> clearAllTiers(ClearEverythingAccommodationWithTierEvent event,
      Emitter<AddHotelWithTierBlocState> emit) async {
    emit(state.copyWith(rooms: {}, tier: {}, tierImages: {}));
  }

  Future<void> clearTierHotel(DeleteTierOnAccommodationWithTierEvent event,
      Emitter<AddHotelWithTierBlocState> emit) async {
    Tier tier = event.tier;
    Map<int, Tier>? tiers = Map.from(state.tier!);
    Map<int, List<Room>>? rooms = Map.from(state.rooms!);
    Map<int, File>? tierImages = Map.from(state.tierImages!);
    int index = 0;
    tiers.forEach((key, value) {
      if (value == tier) {
        index = key;
        // print()
      }
    });
    // print(index);
    // print(tiers);
    // print(rooms);
    // print(tierImages);
    // tiers.forEach((key, value) {
    //   print("The tier ${key} ${value}");
    // });
    // rooms.forEach((key, value) {
    //   print("The room ${key} ${value}");
    // });
    // tierImages.forEach((key, value) {
    //   print("The tier Image ${key} ${value}");
    // });
    tiers.remove(index);
    rooms.remove(index);
    tierImages.remove(index);
    emit(state.copyWith(rooms: rooms, tier: tiers, tierImages: tierImages));
  }

  Future<void> addHotelWithTier(AddHotelTierWithTierEvent event,
      Emitter<AddHotelWithTierBlocState> emit) async {
    Tier tier = event.tier;
    File tierImage = event.tierImage;
    List<Room> rooms = event.rooms;
    late Map<int, Tier>? tiers;
    late Map<int, File>? tierImages;
    late Map<int, List<Room>>? tierRooms;

    if (state.tier == null || state.tier!.isEmpty) {
      int index = 0;
      tiers = {index: tier};
      tierImages = {index: tierImage};
      tierRooms = {index: rooms};
    } else {
      // int index = state.tiers.keys.toL;
      // state.tiers.keys.toList()[state.tiers.length - 1];
      tiers = Map.from(state.tier!);
      tierImages = Map.from(state.tierImages!);
      tierRooms = Map.from(state.rooms!);

      int index = tiers.keys.toList()[tiers.length - 1] + 1;
      tiers[index] = event.tier;
      tierImages[index] = event.tierImage;
      tierRooms[index] = event.rooms;
    }

    emit(state.copyWith(
        accommodation: state.accommodation,
        accommodationImage: state.accommodationImage,
        rooms: tierRooms,
        tier: tiers,
        tierImages: tierImages));
  }

  Future<void> addAccommodation(AddAccommodationWithTierEvent event,
      Emitter<AddHotelWithTierBlocState> emit) async {
    Accommodation accommodation = event.accommodation;
    File accommodationImage = event.accommodationImage;
    return emit(AddHotelWithTierBlocState(
        accommodation: accommodation, accommodationImage: accommodationImage));
  }

  @override
  void onChange(Change<AddHotelWithTierBlocState> change) {
    print(
        "The curent state is ${change.currentState} and the next state is ${change.nextState}");
    super.onChange(change);
  }
}
