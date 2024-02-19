import 'package:http/http.dart' as http;

import '../../constants/constants_exports.dart';
import '../model/model_exports.dart';

class ReviewApiProvider {
  Future<List<ReviewModel>> viewAccommodationReviews({required int id}) async {
    try {
      final url = "${getIp()}review/?id=${id}";
      final request = await http.get(Uri.parse(url));
      final body = jsonDecode(request.body);
      // return await List.from(÷)
      print(body);
      int success = body['success'];
      print("A");
      if (success == 0) {
        return [ReviewModel.withError(body['message'])];
      }
      print("A");
      return await List.from(body["data"])
          .map((e) => ReviewModel.fromMap(e))
          .toList();
    } catch (e) {
      print(e);
      return [ReviewModel.withError("Connection Error")];
    }
  }
}
