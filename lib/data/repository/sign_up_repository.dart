import '../api/api_exports.dart';
import '../model/model_exports.dart';

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
