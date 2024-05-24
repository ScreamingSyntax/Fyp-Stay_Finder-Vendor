import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stayfinder_vendor/data/model/model_exports.dart';
import 'package:stayfinder_vendor/data/repository/notification_repository.dart';

part 'add_device_id_state.dart';

class AddDeviceIdCubit extends Cubit<AddDeviceIdState> {
  NotificationRepository _repository = new NotificationRepository();
  AddDeviceIdCubit() : super(AddDeviceIdInitial());
  void addDeviceId(
      {required String token, required String id, String? deviceModel}) async {
    emit(AddDeviceIdLoading());
    Success success = await _repository.addDeviceId(
        token: token, deviceID: id, deviceModel: deviceModel);
    if (success.success == 0) {
      return emit(AddDeviceIdError(success: success));
    }
    emit(AddDeviceIdSuccess(success: success));
  }
}
