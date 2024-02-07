import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stayfinder_vendor/data/model/model_exports.dart';
import 'package:stayfinder_vendor/data/repository/repository_exports.dart';

part 'verify_booking_request_state.dart';

class VerifyBookingRequestCubit extends Cubit<VerifyBookingRequestState> {
  BookingRepository _bookingRepository = new BookingRepository();
  VerifyBookingRequestCubit() : super(VerifyBookingRequestInitial());
  void verifyBookingRequest(
      {required bool verify,
      required String token,
      required int roomId,
      required int bookRequestId}) async {
    emit(VerifyBookingRequestLoading());
    Success success = await _bookingRepository.verifyBookingRequest(
        roomId: roomId,
        bookRequestId: bookRequestId,
        status: verify ? "accepted" : "rejected",
        token: token);
    if (success.success == 0) {
      emit(VerifyBookRequestError(success.message!));
    }
    if (success.success == 1) {
      emit(VerifyBookingRequestSuccess(success.message!));
    }
  }

  @override
  void onChange(Change<VerifyBookingRequestState> change) {
    print(
        "Current state is ${change.currentState} next state is ${change.nextState}");
    super.onChange(change);
  }
}
