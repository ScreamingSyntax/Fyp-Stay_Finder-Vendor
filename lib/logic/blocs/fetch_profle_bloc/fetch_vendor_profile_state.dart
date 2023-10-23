part of 'fetch_vendor_profile_bloc.dart';

sealed class FetchVendorProfileState extends Equatable {
  const FetchVendorProfileState();
  
  @override
  List<Object> get props => [];
}

final class FetchVendorProfileInitial extends FetchVendorProfileState {}
