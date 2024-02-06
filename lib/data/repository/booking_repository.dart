import 'package:stayfinder_vendor/data/api/api_exports.dart';
import 'package:stayfinder_vendor/data/model/model_exports.dart';

class BookingRepository {
  BookingApiProvider bookingApiProvider = new BookingApiProvider();
  Future<Success> fetchBookRequests({required String token}) async {
    return bookingApiProvider.fetchBookRequests(token: token);
  }

  Future<Success> verifyBookingRequest(
      {required int roomId,
      required bookRequestId,
      required String status,
      required String token}) async {
    return bookingApiProvider.verifyBookingRequest(
        roomId: roomId,
        bookRequestId: bookRequestId,
        status: status,
        token: token);
  }
}
