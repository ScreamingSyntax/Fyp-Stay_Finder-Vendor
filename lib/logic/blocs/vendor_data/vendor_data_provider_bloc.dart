import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:stayfinder_vendor/data/repository/vendor_repository.dart';
import 'package:stayfinder_vendor/logic/blocs/vendor_data/vendor_data_provider_state.dart';

part 'vendor_data_provider_event.dart';

class VendorDataProviderBloc
    extends Bloc<VendorDataProviderEvent, VendorDataProviderState>
    with HydratedMixin {
  VendorDataProviderBloc({required VendorRepository vendorRepository})
      : super(VendorDataProviderInitial()) {
    on<LoadDataEvent>((event, emit) async {
      try {
        emit(VendorDataLoading());
        final data = await vendorRepository.getUserData(token: event.token);
        print(event.token);
        if (data.error != null) {
          emit(VendorLoadingError(message: data.error));
        }
        emit(VendorLoaded(vendorModel: data));
      } catch (Exception) {
        emit(VendorLoadingError(
            message:
                "Failed to fetch data, is your device connected to internet ?"));
      }
    });
  }
  @override
  void onChange(Change<VendorDataProviderState> change) {
    print(
        "Current state is ${change.currentState}, Next state is ${change.nextState}");
    super.onChange(change);
  }

  @override
  VendorDataProviderState? fromJson(Map<String, dynamic> json) {
    try {
      return VendorLoaded.fromMap(json);
    } catch (e) {
      return VendorDataProviderInitial();
    }
  }

  @override
  Map<String, dynamic>? toJson(VendorDataProviderState state) {
    if (state is VendorLoaded) {
      return state.toMap();
    }
    return {};
  }
}
