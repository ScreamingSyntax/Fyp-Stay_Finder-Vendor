part of 'vendor_data_provider_bloc.dart';

sealed class VendorDataProviderEvent extends Equatable {
  const VendorDataProviderEvent();

  @override
  List<Object> get props => [];
}

class LoadDataEvent extends VendorDataProviderEvent {
  final String token;

  LoadDataEvent({required this.token});
}
