import 'dart:ffi';

import '../api/api_exports.dart';
import '../model/model_exports.dart';

class VendorRepository {
  final _provider = VendorDataProvider();
  Future<Vendor> getUserData({required String token}) {
    return _provider.getUserData(token);
  }

  Future<Success> resetPassword(
      {required String token,
      required String oldPass,
      required String newPass}) async {
    return await _provider.resetPassword(
        token: token, old_pass: oldPass, new_pass: newPass);
  }

  Future<Success> forgotPassword(
      {required String email, String? newPassword, String? otp}) async {
    return await _provider.forgotPassword(
        email: email, newPassword: newPassword, otp: otp);
  }
}
