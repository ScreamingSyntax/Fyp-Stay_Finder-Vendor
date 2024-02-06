part of 'fetch_booking_request_cubit.dart';

class FetchBookingRequestState extends Equatable {
  const FetchBookingRequestState();

  @override
  List<Object> get props => [];
}

class FetchBookingRequestInitial extends FetchBookingRequestState {}

class FetchBookingRequestLoading extends FetchBookingRequestState {}

class FetchBookingRequestSuccesss extends FetchBookingRequestState {
  final List<BookingRequest> bookingRequests;
  final List<Booked> bookedCustomers;

  FetchBookingRequestSuccesss(
      {required this.bookingRequests, required this.bookedCustomers});
}

class FetchBookingRequestError extends FetchBookingRequestState {
  final String message;

  FetchBookingRequestError({required this.message});
}