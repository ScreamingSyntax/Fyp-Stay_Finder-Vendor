import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stayfinder_vendor/data/model/model_exports.dart';
import 'package:stayfinder_vendor/data/repository/repository_exports.dart';

part 'update_accommodation_location_state.dart';

class UpdateAccommodationLocationCubit
    extends Cubit<UpdateAccommodationLocationState> {
  AccommodationAdditionRepository _accommodationAdditionRepository =
      new AccommodationAdditionRepository();
  UpdateAccommodationLocationCubit()
      : super(UpdateAccommodationLocationInitial());
  void updateAccommodationLocation(
      {required String token,
      required String longitude,
      required String id,
      required String latitude}) async {
    emit(UpdateAccommodationLocationLoading());
    Success success = await _accommodationAdditionRepository.updateLocation(
        accommodationId: id,
        token: token,
        latitude: latitude,
        longitude: longitude);
    if (success.success == 0) {
      return emit(UpdateAccommodationLocationError(error: success.message!));
    }
    emit(UpdateAccommodationLocationSuccess(success: success));
  }

  @override
  void onChange(Change<UpdateAccommodationLocationState> change) {
    print("C :${change.currentState} N: ${change.nextState}");
    super.onChange(change);
  }
}
