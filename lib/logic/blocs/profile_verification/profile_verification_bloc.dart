import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stayfinder_vendor/data/model/model_exports.dart';

import '../../../data/repository/repository_exports.dart';

part 'profile_verification_event.dart';
part 'profile_verification_state.dart';

class ProfileVerificationBloc
    extends Bloc<ProfileVerificationEvent, ProfileVerificationState> {
  ProfileVerificationBloc({required ProfileVerificationRepository repository})
      : super(ProfileVerificationInitial()) {
    on<ProfileVerificationHitEvent>((event, emit) async {
      try {
        emit(ProfileVerificationLoadingState());
        Success success = await repository.verifyProfile(
            profilePicture: event.profilePicture,
            citizenshipFront: event.citizenshipFront,
            citizenshipBack: event.citizenshipBack,
            address: event.address,
            token: event.token);
        if (success.error != null) {
          emit(ProfileVerificationErrorState(message: success.error!));
          return;
        }
        if (success.success == 0) {
          emit(ProfileVerificationErrorState(message: success.message!));
          return;
        }
        emit(ProfileVerificationLoadedState(success: success));
      } catch (err) {
        emit(ProfileVerificationErrorState(message: "Connection Error"));
      }
    });
  }
  @override
  void onChange(Change<ProfileVerificationState> change) {
    print(
        "Current State ${change.currentState}, next state ${change.nextState}");
    super.onChange(change);
  }
}
