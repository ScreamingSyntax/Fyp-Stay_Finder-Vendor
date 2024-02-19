import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stayfinder_vendor/data/model/success_model.dart';
import 'package:stayfinder_vendor/data/repository/repository_exports.dart';
import 'package:stayfinder_vendor/data/repository/vendor_profile_repository.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  VendorRepository _repository = new VendorRepository();
  ResetPasswordCubit() : super(ResetPasswordInitial());

  void resetPassword(
      {required String token,
      required String oldPass,
      required String newPass}) async {
    emit(ResetPasswordLoading());
    Success success = await _repository.resetPassword(
        token: token, oldPass: oldPass, newPass: newPass);
    if (success.success == 0) {
      return emit(ResetPasswordError(message: success.message!));
    }
    return emit(ResetPasswordSuccess(message: success.message!));
  }
}
