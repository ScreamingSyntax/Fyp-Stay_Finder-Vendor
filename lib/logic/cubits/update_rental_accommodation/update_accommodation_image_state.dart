part of 'update_accommodation_image_cubit.dart';

sealed class UpdateRentalState extends Equatable {
  const UpdateRentalState();

  @override
  List<Object> get props => [];
}

final class UpdateRentalInitial extends UpdateRentalState {}

class UpdateRentalLoading extends UpdateRentalState {}

class UpdateRentalError extends UpdateRentalState {
  final String message;

  UpdateRentalError({required this.message});
}

class UpdateRentalSuccess extends UpdateRentalState {
  final String message;

  UpdateRentalSuccess({required this.message});
}
