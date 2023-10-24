part of 'profile_verification_bloc.dart';

sealed class ProfileVerificationState extends Equatable {
  const ProfileVerificationState();

  @override
  List<Object> get props => [];
}

final class ProfileVerificationInitial extends ProfileVerificationState {}

final class ProfileVerificationLoadingState extends ProfileVerificationState {}

final class ProfileVerificationLoadedState extends ProfileVerificationState {
  final Success success;

  ProfileVerificationLoadedState({required this.success});
}

final class ProfileVerificationErrorState extends ProfileVerificationState {
  final String message;

  ProfileVerificationErrorState({required this.message});
}
