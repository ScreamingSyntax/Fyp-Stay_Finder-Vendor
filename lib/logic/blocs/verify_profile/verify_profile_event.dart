part of 'verify_profile_bloc.dart';

sealed class VerifyProfileEvent extends Equatable {
  const VerifyProfileEvent();

  @override
  List<Object> get props => [];
}

class OnSelectImageEvent extends VerifyProfileEvent {}

class UnSelectImageEvent extends VerifyProfileEvent {}

class onSubmitImageEvent extends VerifyProfileEvent {}
