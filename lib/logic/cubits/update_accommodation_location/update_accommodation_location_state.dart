part of 'update_accommodation_location_cubit.dart';

class UpdateAccommodationLocationState extends Equatable {
  const UpdateAccommodationLocationState();

  @override
  List<Object> get props => [];
}

class UpdateAccommodationLocationLoading
    extends UpdateAccommodationLocationState {}

class UpdateAccommodationLocationSuccess
    extends UpdateAccommodationLocationState {
  final Success success;

  UpdateAccommodationLocationSuccess({required this.success});
}

class UpdateAccommodationLocationError
    extends UpdateAccommodationLocationState {
  final String error;

  UpdateAccommodationLocationError({required this.error});
}

class UpdateAccommodationLocationInitial
    extends UpdateAccommodationLocationState {}
