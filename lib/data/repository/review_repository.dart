import '../api/api_exports.dart';
import '../model/model_exports.dart';

class ReviewRepository {
  ReviewApiProvider _reviewApiProvider = new ReviewApiProvider();
  Future<List<ReviewModel>> viewAccommodationReviews({required int id}) async {
    return await _reviewApiProvider.viewAccommodationReviews(id: id);
  }
}
