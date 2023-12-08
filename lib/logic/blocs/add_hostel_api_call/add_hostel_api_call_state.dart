part of 'add_hostel_api_call_bloc.dart';

sealed class AddHostelApiCallState extends Equatable {
  const AddHostelApiCallState();

  @override
  List<Object> get props => [];
}

final class AddHostelApiCallInitial extends AddHostelApiCallState {}

class AddHostelApiCallSuccess extends AddHostelApiCallState {
  final String message;

  AddHostelApiCallSuccess({required this.message});
}

class AddHostelApiCallLoading extends AddHostelApiCallState {}

class AddHostelApiCallError extends AddHostelApiCallState {
  final String message;

  AddHostelApiCallError({required this.message});
}
