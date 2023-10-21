part of 'sign_up_otp_dart_bloc.dart';

sealed class SignUpOtpDartEvent extends Equatable {
  const SignUpOtpDartEvent();

  @override
  List<Object> get props => [];
}

class SignUpEventHitOtp extends SignUpOtpDartEvent {
  final Vendor vendor;

  SignUpEventHitOtp({required this.vendor});
}
