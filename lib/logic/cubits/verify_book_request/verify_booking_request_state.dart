part of 'verify_booking_request_cubit.dart';

sealed class VerifyBookingRequestState extends Equatable {
  const VerifyBookingRequestState();

  @override
  List<Object> get props => [];
}

class VerifyBookingRequestInitial extends VerifyBookingRequestState {}

class VerifyBookingRequestLoading extends VerifyBookingRequestState {
  VerifyBookingRequestLoading();
}

class VerifyBookingRequestSuccess extends VerifyBookingRequestState {
  final String message;
  VerifyBookingRequestSuccess(this.message);
}

class VerifyBookRequestError extends VerifyBookingRequestState {
  final String error;
  VerifyBookRequestError(this.error);
}
