part of 'update_hostel_cubit.dart';

sealed class UpdateHostelState extends Equatable {
  const UpdateHostelState();

  @override
  List<Object> get props => [];
}

final class UpdateHostelInitial extends UpdateHostelState {}

class UpdateHostelLoading extends UpdateHostelState {}

class UpdateHostelSuccessState extends UpdateHostelState {
  final String message;
  UpdateHostelSuccessState({required this.message});
}

class UpdateHostelErrorState extends UpdateHostelState {
  final String message;
  UpdateHostelErrorState({required this.message});
}
