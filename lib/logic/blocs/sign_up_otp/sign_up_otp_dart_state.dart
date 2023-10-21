part of 'sign_up_otp_dart_bloc.dart';

sealed class SignUpOtpDartState extends Equatable {
  const SignUpOtpDartState();

  @override
  List<Object> get props => [];
}

final class SignUpOtpDartInitial extends SignUpOtpDartState {}

final class SignupOtpLoading extends SignUpOtpDartState {}

final class SignupOtpLoaded extends SignUpOtpDartState {
  final Vendor vendor;
  final Success success;
  SignupOtpLoaded({
    required this.success,
    required this.vendor,
  });
  List<Object> get props => [vendor, success];
}

final class SignUpOtpErrorState extends SignUpOtpDartState {
  final String errorMessage;

  SignUpOtpErrorState({required this.errorMessage});
}
