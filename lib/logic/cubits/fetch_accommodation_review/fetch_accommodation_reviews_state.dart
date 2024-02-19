part of 'fetch_accommodation_reviews_cubit.dart';

sealed class FetchAccommodationReviewsState extends Equatable {
  const FetchAccommodationReviewsState();

  @override
  List<Object> get props => [];
}

final class FetchAccommodationReviewsInitial
    extends FetchAccommodationReviewsState {}

class FetchAccommodationReviewsLoading extends FetchAccommodationReviewsState {}

class FetchAccommodationReviewsSuccess extends FetchAccommodationReviewsState {
  final List<ReviewModel> reviewModel;

  FetchAccommodationReviewsSuccess({required this.reviewModel});
  @override
  List<Object> get props => [reviewModel];
}

class FetchAccommodationReviewsError extends FetchAccommodationReviewsState {
  final String message;

  FetchAccommodationReviewsError({required this.message});
  @override
  List<Object> get props => [message];
}
