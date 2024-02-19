part of 'resumbit_accommodation_verification_cubit.dart';

sealed class ResumbitAccommodationVerificationState extends Equatable {
  const ResumbitAccommodationVerificationState();

  @override
  List<Object> get props => [];
}

class ResumbitAccommodationVerificationInitial
    extends ResumbitAccommodationVerificationState {}

class ResubmitAccommodationVerificationLoading
    extends ResumbitAccommodationVerificationState {}

class ResubmitAccommodationVerificationSuccess
    extends ResumbitAccommodationVerificationState {
  final String message;

  ResubmitAccommodationVerificationSuccess({required this.message});
}

class ResubmitAccommodationVerificationError
    extends ResumbitAccommodationVerificationState {
  final String message;

  ResubmitAccommodationVerificationError({required this.message});
}
