import 'package:stayfinder_vendor/constants/constants_exports.dart';
import '../model/model_exports.dart';
import 'package:http/http.dart' as http;

class BookingApiProvider {
  Future<Success> fetchBookRequests({required String token}) async {
    try {
      final url = Uri.parse("${getIp()}book/");
      final request = await http.get(
        url,
        headers: {
          "Authorization": "Token ${token}",
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      final response = json.decode(request.body);
      print(response);
      Success success = Success.fromMap(response);
      return success;
    } catch (e) {
      return Success(success: 0, message: "Check your internet connection");
    }
  }

  Future<Success> verifyBookingRequest(
      {required int roomId,
      required bookRequestId,
      required String status,
      required String token}) async {
    try {
      final url = Uri.parse("${getIp()}book/request/verify/");
      final request = await http.post(url,
          headers: {
            "Authorization": "Token ${token}",
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({
            'room_id': roomId.toString(),
            'book_request_id': bookRequestId.toString(),
            'status': status,
          }));
      final response = json.decode(request.body);
      Success success = Success.fromMap(response);
      return success;
    } catch (e) {
      return Success(success: 0, message: "Check your internet connection");
    }
  }
}
