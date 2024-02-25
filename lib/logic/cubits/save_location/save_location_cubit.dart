import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'save_location_state.dart';

class SaveLocationCubit extends Cubit<SaveLocationState> {
  SaveLocationCubit() : super(SaveLocationState());
  void storeLocation({required String longitude, required String latitude}) =>
      emit(SaveLocationState(longitude: longitude, latitude: latitude));

  void clearLocation() => emit(SaveLocationState());
  @override
  void onChange(Change<SaveLocationState> change) {
    print("Current :${change.currentState} next: ${change.nextState}");
    super.onChange(change);
  }
}
