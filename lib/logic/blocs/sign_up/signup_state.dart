part of 'signup_bloc.dart';

sealed class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}

final class SignupIntiailState extends SignupState {}

final class SignupLoading extends SignupState {}

final class SignupLoaded extends SignupState {
  final Vendor vendor;
  final Success success;
  SignupLoaded({required this.success, required this.vendor});
}

final class SignUpErrorState extends SignupState {
  final String errorMessage;

  SignUpErrorState({required this.errorMessage});
}
