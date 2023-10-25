import '../../../data/repository/repository_exports.dart';
import '../bloc_exports.dart';
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
