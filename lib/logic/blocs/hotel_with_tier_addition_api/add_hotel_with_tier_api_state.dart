part of 'add_hotel_with_tier_api_bloc.dart';

sealed class AddHotelWithTierApiState extends Equatable {
  const AddHotelWithTierApiState();

  @override
  List<Object> get props => [];
}

class AddHotelWithTierApiInitial extends AddHotelWithTierApiState {}

class AddHotelWithTierLoading extends AddHotelWithTierApiState {}

class AddHotelWithTierSuccess extends AddHotelWithTierApiState {
  final String message;

  AddHotelWithTierSuccess({required this.message});
}

class AddHotelWithTierError extends AddHotelWithTierApiState {
  final String message;

  AddHotelWithTierError({required this.message});
}
