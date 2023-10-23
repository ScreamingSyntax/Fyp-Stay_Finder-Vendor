import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'fetch_vendor_profile_event.dart';
part 'fetch_vendor_profile_state.dart';

class FetchVendorProfileBloc extends Bloc<FetchVendorProfileEvent, FetchVendorProfileState> {
  FetchVendorProfileBloc() : super(FetchVendorProfileInitial()) {
    on<FetchVendorProfileEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
