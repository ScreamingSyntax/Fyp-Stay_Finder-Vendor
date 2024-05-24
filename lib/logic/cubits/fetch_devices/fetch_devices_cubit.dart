import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/model/model_exports.dart';
import '../../../data/repository/notification_repository.dart';

part 'fetch_devices_state.dart';

class FetchDevicesCubit extends Cubit<FetchDevicesState> {
  NotificationRepository _notificationRepository = new NotificationRepository();
  FetchDevicesCubit() : super(FetchDevicesInitial());

  void fetchNotification({required String token}) async {
    emit(FetchDevicesLoading());
    List<DevicesModel> devices =
        await _notificationRepository.devices(token: token);
    print(devices);
    // if(devices)
    if (devices.length == 0) {
      return emit(FetchDevicesSuccess(devices: devices));
    }
    if (devices[0].error != null) {
      return emit(FetchDevicesError(message: devices[0].error!));
    }
    return emit(FetchDevicesSuccess(devices: devices));
  }
}
