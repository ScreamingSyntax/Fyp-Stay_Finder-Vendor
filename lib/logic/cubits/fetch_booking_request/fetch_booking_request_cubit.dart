import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stayfinder_vendor/data/model/booked_model.dart';
import 'package:stayfinder_vendor/data/model/model_exports.dart';
import 'package:stayfinder_vendor/data/repository/repository_exports.dart';

part 'fetch_booking_request_state.dart';

class FetchBookingRequestCubit extends Cubit<FetchBookingRequestState> {
  FetchBookingRequestCubit() : super(FetchBookingRequestInitial());
  BookingRepository _bookingRepository = new BookingRepository();
  void fetchBookingRequests({required String token}) async {
    try {
      Success success =
          await _bookingRepository.fetchBookRequests(token: token);
      if (success.success == 0) {
        return emit(FetchBookingRequestError(message: success.message!));
      }
      if (success.success == 1) {
        print("yes");
        print(success);

        final requests = success.data!['requests'];
        final bookings = success.data!['booking'];
        List<BookingRequest> bookingRequests =
            List.from(requests).map((e) => BookingRequest.fromMap(e)).toList();
        List<Booked> booked =
            List.from(bookings).map((e) => Booked.fromMap(e)).toList();
        emit(FetchBookingRequestSuccesss(
            bookingRequests: bookingRequests, bookedCustomers: booked));
      }
    } catch (e) {
      print(e);
      emit(FetchBookingRequestError(message: "Something wen't wrong :BLoc"));
    }
  }

  @override
  void onChange(Change<FetchBookingRequestState> change) {
    print(
        "The current state is ${change.currentState} next state: ${change.nextState}");
    super.onChange(change);
  }
}
