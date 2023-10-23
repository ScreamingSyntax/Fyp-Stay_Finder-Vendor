import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stayfinder_vendor/data/model/model_exports.dart';
import 'package:stayfinder_vendor/data/repository/vendor_profile_repository.dart';

part 'fetch_vendor_profile_event.dart';
part 'fetch_vendor_profile_state.dart';

class FetchVendorProfileBloc
    extends Bloc<FetchVendorProfileEvent, FetchVendorProfileState> {
  FetchVendorProfileBloc({required VendorProfileRepository repository})
      : super(FetchVendorProfileInitial()) {
    on<HitFetchVendorProfileEvent>((event, emit) async {
      return await fetchVendorProfile(emit, event, repository);
    });
  }
  Future<void> fetchVendorProfile(
      Emitter<FetchVendorProfileState> emit,
      HitFetchVendorProfileEvent event,
      VendorProfileRepository repository) async {
    try {
      emit(FetchVendorProfileLoading());
      final vendorProfile =
          await repository.getVendorProfile(token: event.token);
      if (vendorProfile.error != null) {
        emit(FetchVendorProfileError(errorMessage: vendorProfile.error!));
        return;
      }
      emit(FetchVendorProfileLoaded(vendorProfile: vendorProfile));
      return;
    } catch (err) {
      emit(FetchVendorProfileError(
          errorMessage: "Failed to fetch data, is your device online? "));
    }
  }

  @override
  void onChange(Change<FetchVendorProfileState> change) {
    print(
        "Current State ${change.currentState}, next state ${change.nextState}");
    super.onChange(change);
  }
}
