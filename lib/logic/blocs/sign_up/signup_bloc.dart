import '../../../data/model/model_exports.dart';
import '../../../data/repository/repository_exports.dart';
import '../bloc_exports.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc({required SignUpRepository repository})
      : super(SignupIntiailState()) {
    on<SignUpEventHit>((event, emit) async {
      await waitSignUp(event, emit, repository: repository);
    });
  }

  Future<void> waitSignUp(SignUpEventHit event, Emitter<SignupState> emit,
      {required SignUpRepository repository}) async {
    try {
      emit(SignupLoading());
      Success success = await repository.signUpVendor(
          email: event.vendor.email!,
          fullName: event.vendor.fullName!,
          password: event.vendor.password!,
          phoneNumber: event.vendor.phoneNumber!);
      if (success.error != null) {
        emit(SignUpErrorState(errorMessage: success.error!));
        return;
      }
      if (success.success == 0) {
        emit(SignUpErrorState(errorMessage: success.message!));
        return;
      } else {
        emit(SignupLoaded(success: success, vendor: event.vendor));
        return;
      }
    } catch (Exception) {
      emit(SignUpErrorState(errorMessage: "Connection Error"));
    }
  }

  @override
  void onChange(Change<SignupState> change) {
    print(
        "Current State ${change.currentState}, Next State ${change.nextState}");
    super.onChange(change);
  }
}
