part of 'fetch_vendor_profile_bloc.dart';

sealed class FetchVendorProfileEvent extends Equatable {
  const FetchVendorProfileEvent();

  @override
  List<Object> get props => [];
}

class HitFetchVendorProfileEvent extends FetchVendorProfileEvent {
  final String token;

  HitFetchVendorProfileEvent({required this.token});
}
