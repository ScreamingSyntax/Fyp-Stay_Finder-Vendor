import '../../../data/model/model_exports.dart';
import '../../../data/repository/sign_up_repository.dart';
import '../bloc_exports.dart';

part 'sign_up_otp_dart_event.dart';
part 'sign_up_otp_dart_state.dart';

class SignUpOtpDartBloc extends Bloc<SignUpOtpDartEvent, SignUpOtpDartState> {
  SignUpOtpDartBloc({required SignUpRepository repository})
      : super(SignUpOtpDartInitial()) {
    on<SignUpEventHitOtp>((event, emit) async {
      await waitSignUpOtp(event, emit, repository: repository);
    });
  }

  Future<void> waitSignUpOtp(
      SignUpEventHitOtp event, Emitter<SignUpOtpDartState> emit,
      {required SignUpRepository repository}) async {
    try {
      emit(SignupOtpLoading());
      print(event.vendor);
      Success success = await repository.signUpVendorWithOtp(
          email: event.vendor.email!,
          fullName: event.vendor.fullName!,
          password: event.vendor.password!,
          phoneNumber: event.vendor.phone_number!,
          otp: event.vendor.otp!);
      print(success);
      if (success.error != null) {
        emit(SignUpOtpErrorState(errorMessage: success.error!));
        return;
      }
      if (success.success == 0) {
        emit(SignUpOtpErrorState(errorMessage: success.message!));
        return;
      } else {
        emit(SignupOtpLoaded(vendor: event.vendor, success: success));
        return;
      }
    } catch (Exception) {
      print(Exception);
      // print(e);
      emit(SignUpOtpErrorState(errorMessage: "Connection Error"));
      return;
    }
  }
}
