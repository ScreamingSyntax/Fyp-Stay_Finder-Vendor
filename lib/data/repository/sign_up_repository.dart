import 'package:stayfinder_vendor/data/api/sign_up_api.dart';
import 'package:stayfinder_vendor/data/model/success_model.dart';

class SignUpRepository {
  final _provider = SignUpApiProvider();
  Future<Success> signUpVendor(
      {required String email,
      required String fullName,
      required String password,
      required String phoneNumber}) {
    return _provider.signUp(
        fullName: fullName,
        phoneNumber: phoneNumber,
        email: email,
        password: password);
  }

  Future<Success> signUpVendorWithOtp(
      {required String email,
      required String fullName,
      required String password,
      required String phoneNumber,
      required String otp}) {
    return _provider.signUpWithOtp(
        fullName: fullName,
        phoneNumber: phoneNumber,
        email: email,
        password: password,
        otp: otp);
  }
}
