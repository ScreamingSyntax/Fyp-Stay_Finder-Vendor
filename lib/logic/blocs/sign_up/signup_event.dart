part of 'signup_bloc.dart';

sealed class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class SignUpEventWait extends SignupEvent {
  final Vendor vendor;
  SignUpEventWait({required this.vendor});
}

class SignUpEventHit extends SignupEvent {
  final Vendor vendor;

  SignUpEventHit({required this.vendor});
}
