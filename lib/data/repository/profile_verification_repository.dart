import 'dart:io';

import 'package:stayfinder_vendor/data/api/profile_verification_api.dart';

import '../model/model_exports.dart';

class ProfileVerificationRepository {
  ProfileVerificationApi _apiProvider = ProfileVerificationApi();
  Future<Success> verifyProfile({
    required File profilePicture,
    required File citizenshipFront,
    required File citizenshipBack,
    required String address,
    required String token,
  }) async {
    print("ada");
    return await _apiProvider.verifyProfile(
      profilePicture: profilePicture,
      citizenshipFront: citizenshipFront,
      citizenshipBack: citizenshipBack,
      address: address,
      token: token,
    );
  }
}
