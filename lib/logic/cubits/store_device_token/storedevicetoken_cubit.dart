import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'storedevicetoken_state.dart';

class StoredevicetokenCubit extends Cubit<StoredevicetokenState> {
  StoredevicetokenCubit() : super(StoredevicetokenState());
  void storeDeviceToken({required String deviceToken}) =>
      emit(StoredevicetokenState(token: deviceToken));
}
