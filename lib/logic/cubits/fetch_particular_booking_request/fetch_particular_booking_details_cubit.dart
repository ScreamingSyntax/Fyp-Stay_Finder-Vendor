import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stayfinder_vendor/data/model/booked_model.dart';
import 'package:stayfinder_vendor/data/model/model_exports.dart';
import 'package:stayfinder_vendor/data/model/room_image_model.dart';
import 'package:stayfinder_vendor/data/repository/repository_exports.dart';

part 'fetch_particular_booking_details_state.dart';

class FetchParticularBookingDetailsCubit
    extends Cubit<FetchParticularBookingDetailsState> {
  BookingRepository _bookingRepository = new BookingRepository();
  FetchParticularBookingDetailsCubit()
      : super(FetchParticularBookingDetailsInitial());
  void fetchParticularBookingDetails(
      {required String id,
      required String token,
      required Accommodation accommodation}) async {
    emit(FetchParticularBookingDetailsLoading());
    Success success = await _bookingRepository.viewParticularBookingDetails(
      token: token,
      id: id,
    );
    if (success.success == 0) {
      return emit(FetchParticularBookingDetailsError(success.message!));
    }
    final data = success.data;
    if (accommodation.type == "rent_room" || accommodation.type == "hostel") {
      Accommodation accommodation =
          Accommodation.fromMap(data!["accommodation"]);
      Room room = Room.fromMap(data["room"]);
      List<RoomImage> roomImages =
          List.from(data["images"]).map((e) => RoomImage.fromMap(e)).toList();
      Booked booked = Booked.fromMap(data["book"]);
      return emit(FetchParticularBookingDetailsLoaded(
          booked: booked,
          accommodation: accommodation,
          room: room,
          roomImage: roomImages));
    }
    if (accommodation.type == "hotel") {
      if (accommodation.has_tier == true) {
        Accommodation accommodation =
            Accommodation.fromMap(data!["accommodation"]);
        Room room = Room.fromMap(data["room"]);
        HotelTier tier = HotelTier.fromMap(data["tier"]);
        Booked booked = Booked.fromMap(data["book"]);
        return emit(FetchParticularBookingDetailsLoaded(
            booked: booked,
            accommodation: accommodation,
            room: room,
            tier: tier));
      }
      if (accommodation.has_tier == false) {
        Accommodation accommodation =
            Accommodation.fromMap(data!["accommodation"]);
        Room room = Room.fromMap(data["room"]);
        List<RoomImage> roomImages =
            List.from(data["images"]).map((e) => RoomImage.fromMap(e)).toList();
        Booked booked = Booked.fromMap(data["book"]);
        return emit(FetchParticularBookingDetailsLoaded(
            booked: booked,
            accommodation: accommodation,
            room: room,
            roomImage: roomImages));
      }
    }
  }
}
