import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stayfinder_vendor/data/model/model_exports.dart';
import 'package:stayfinder_vendor/data/repository/repository_exports.dart';

part 'resumbit_accommodation_verification_state.dart';

class ResumbitAccommodationVerificationCubit
    extends Cubit<ResumbitAccommodationVerificationState> {
  ResumbitAccommodationVerificationCubit()
      : super(ResumbitAccommodationVerificationInitial());
  AccommodationAdditionRepository accommodationAdditionRepository =
      new AccommodationAdditionRepository();
  void resubmitForVerification(
      {required String token, required int accommodationId}) async {
    emit(ResubmitAccommodationVerificationLoading());
    Success success =
        await accommodationAdditionRepository.reSubmitForVerification(
            accommodationId: accommodationId, token: token);
    if (success.success == 0) {
      return emit(
          ResubmitAccommodationVerificationError(message: success.message!));
    }
    emit(ResubmitAccommodationVerificationSuccess(message: success.message!));
  }

  @override
  void onChange(Change<ResumbitAccommodationVerificationState> change) {
    print(
        "The current state is ${change.currentState} next state: ${change.nextState}");
    super.onChange(change);
  }
}
