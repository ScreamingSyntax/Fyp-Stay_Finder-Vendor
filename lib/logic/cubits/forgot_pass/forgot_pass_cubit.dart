import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stayfinder_vendor/data/repository/repository_exports.dart';

import '../../../data/model/model_exports.dart';

part 'forgot_pass_state.dart';

class ForgotPassCubit extends Cubit<ForgotPassState> {
  VendorRepository _repository = new VendorRepository();
  ForgotPassCubit() : super(ForgotPassInitial());
  void forgotPassword(
      {required String email, String? newPass, String? otp}) async {
    emit(ForgotPassLoading());
    print(email);
    print(newPass);
    print(otp);
    Success success = await _repository.forgotPassword(
        email: email, newPassword: newPass, otp: otp);
    print(success);
    if (success.success == 0) {
      return emit(ForgotPassError(message: success.message!));
    }
    return emit(ForgotPassSuccess(message: success.message!));
  }
}
