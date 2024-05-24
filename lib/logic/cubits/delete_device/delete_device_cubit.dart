import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/model/model_exports.dart';
import '../../../data/repository/notification_repository.dart';

part 'delete_device_state.dart';

class DeleteDeviceCubit extends Cubit<DeleteDeviceState> {
  NotificationRepository _notificationRepository = new NotificationRepository();
  DeleteDeviceCubit() : super(DeleteDeviceInitial());

  void deleteDevice({required String deviceId, required String token}) async {
    emit(DeleteDeviceLoading());
    Success success = await _notificationRepository.deleteDevice(
        token: token, deviceId: deviceId);
    if (success.success == 0) {
      return emit(DeleteDeviceError(message: success.message!));
    }
    emit(DeleteDeviceSuccess(message: success.message!));
  }
}
