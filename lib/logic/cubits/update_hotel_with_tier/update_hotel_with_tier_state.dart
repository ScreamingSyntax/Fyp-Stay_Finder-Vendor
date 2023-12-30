part of 'update_hotel_with_tier_cubit.dart';

sealed class UpdateHotelWithTierState extends Equatable {
  const UpdateHotelWithTierState();

  @override
  List<Object> get props => [];
}

class UpdateHotelWithTierInitial extends UpdateHotelWithTierState {}

class UpdateHotelWithTierLoading extends UpdateHotelWithTierState {}

class UpdateHotelWithTierSuccess extends UpdateHotelWithTierState {
  final String message;

  UpdateHotelWithTierSuccess({required this.message});
}

class UpdateHotelWithTierError extends UpdateHotelWithTierState {
  final String message;

  UpdateHotelWithTierError({required this.message});
}
