part of 'fetch_vendor_profile_bloc.dart';

sealed class FetchVendorProfileState extends Equatable {
  const FetchVendorProfileState();

  @override
  List<Object> get props => [];
}

final class FetchVendorProfileInitial extends FetchVendorProfileState {}

final class FetchVendorProfileLoading extends FetchVendorProfileState {}

final class FetchVendorProfileLoaded extends FetchVendorProfileState {
  final VendorProfile vendorProfile;
  FetchVendorProfileLoaded({required this.vendorProfile});

  @override
  List<Object> get props => [vendorProfile];
}

final class FetchVendorProfileError extends FetchVendorProfileState {
  final String errorMessage;

  FetchVendorProfileError({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
