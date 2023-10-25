part of 'profile_verification_bloc.dart';

sealed class ProfileVerificationEvent extends Equatable {
  const ProfileVerificationEvent();

  @override
  List<Object> get props => [];
}

class ProfileVerificationHitEvent extends ProfileVerificationEvent {
  final File profilePicture;
  final File citizenshipFront;
  final File citizenshipBack;
  final String address;
  final String token;

  ProfileVerificationHitEvent(
      {required this.profilePicture,
      required this.citizenshipFront,
      required this.citizenshipBack,
      required this.address,
      required this.token});
}

class ProfileVerificationResetEvent extends ProfileVerificationEvent {}
