part of 'update_hotel_without_tier_cubit.dart';

sealed class UpdateHotelWithoutTierState extends Equatable {
  const UpdateHotelWithoutTierState();

  @override
  List<Object> get props => [];
}

final class UpdateHotelWithoutTierInitial extends UpdateHotelWithoutTierState {}

final class UpdateHotelWithoutTierLoading extends UpdateHotelWithoutTierState {}

final class UpdateHotelWithoutTierSuccess extends UpdateHotelWithoutTierState {
  final String message;

  UpdateHotelWithoutTierSuccess({required this.message});
}

final class UpdateHotelWithoutTierError extends UpdateHotelWithoutTierState {
  final String message;

  UpdateHotelWithoutTierError({required this.message});
}
