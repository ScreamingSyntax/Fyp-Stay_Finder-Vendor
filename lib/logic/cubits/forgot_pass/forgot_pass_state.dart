part of 'forgot_pass_cubit.dart';

sealed class ForgotPassState extends Equatable {
  const ForgotPassState();

  @override
  List<Object> get props => [];
}

final class ForgotPassInitial extends ForgotPassState {}

class ForgotPassLoading extends ForgotPassState {}

class ForgotPassError extends ForgotPassState {
  final String message;

  ForgotPassError({required this.message});
}

class ForgotPassSuccess extends ForgotPassState {
  final String message;

  ForgotPassSuccess({required this.message});
}
