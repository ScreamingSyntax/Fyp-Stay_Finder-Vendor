import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/model/model_exports.dart';
import '../../../data/repository/repository_exports.dart';

part 'fetch_accommodation_reviews_state.dart';

class FetchAccommodationReviewsCubit
    extends Cubit<FetchAccommodationReviewsState> {
  ReviewRepository _repository = new ReviewRepository();
  FetchAccommodationReviewsCubit() : super(FetchAccommodationReviewsInitial());
  void fetchAccommodationReviews({required int id}) async {
    emit(FetchAccommodationReviewsLoading());
    List<ReviewModel> _reviewModels =
        await _repository.viewAccommodationReviews(id: id);
    print(_reviewModels);
    if (_reviewModels.length == 0) {
      return emit(FetchAccommodationReviewsSuccess(reviewModel: []));
    }
    if (_reviewModels[0].error != null) {
      return emit(
          FetchAccommodationReviewsError(message: _reviewModels[0].error!));
    }
    return emit(FetchAccommodationReviewsSuccess(reviewModel: _reviewModels));
  }

  @override
  void onChange(Change<FetchAccommodationReviewsState> change) {
    print("Current :${change.currentState} Next: ${change.nextState}");
    // TODO: implement onChange
    super.onChange(change);
  }
}
