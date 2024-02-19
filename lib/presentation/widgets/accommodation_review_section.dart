import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:stayfinder_vendor/logic/cubits/cubit_exports.dart';
import 'package:stayfinder_vendor/presentation/widgets/widgets_exports.dart';

import '../../data/model/model_exports.dart';
import '../screens/screen_exports.dart';

class CustomReviewSection extends StatelessWidget {
  CustomReviewSection({super.key, required BuildContext context});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchAccommodationReviewsCubit,
        FetchAccommodationReviewsState>(
      builder: (context, state) {
        if (state is FetchAccommodationReviewsSuccess) {
          List<ReviewModel> reviewModel = state.reviewModel;
          double averageRatings = 0;
          if (reviewModel.length != 0) {
            int count = reviewModel.length;
            double totalRatings = 0;
            reviewModel.forEach((element) {
              totalRatings += double.parse(element.title!);
            });
            averageRatings = totalRatings / count;
            String stringValue = averageRatings.toStringAsFixed(1);
            averageRatings = double.parse(stringValue);
          }
          return Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Ratings & Reviews",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                if (state.reviewModel.length != 0)
                  Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    // color: Colors.black,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              averageRatings.toString(),
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            RatingBar.builder(
                              initialRating: averageRatings,
                              minRating: 1,
                              updateOnDrag: false,
                              ignoreGestures: true,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              unratedColor: Colors.black.withOpacity(0.1),
                              itemSize: 25,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ListView.builder(
                  padding: EdgeInsets.all(0),
                  shrinkWrap: true,
                  itemCount: state.reviewModel.length > 2
                      ? 2
                      : state.reviewModel.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ReviewsCard(
                        description: reviewModel[index].description!,
                        image: reviewModel[index].image,
                        ratings: double.parse(reviewModel[index].title!),
                        userName: reviewModel[index].customer!.full_name!,
                        date: reviewModel[index].added_time.toString(),
                      ),
                    );
                  },
                ),
                if (state.reviewModel.length == 0)
                  Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "The accommodation has no reviews",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.3), fontSize: 10),
                      ),
                    ],
                  ),
                SizedBox(
                  height: 19,
                ),
                if (reviewModel.length > 2)
                  Column(
                    children: [
                      Divider(),
                      SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      RatingsScreen(reviews: reviewModel)));
                        },
                        child: Text(
                          "View All (${reviewModel.length}) >",
                          style: TextStyle(color: Colors.red),
                        ),
                      )
                    ],
                  ),
                SizedBox(
                  height: 19,
                ),
              ],
            ),
          );
        }
        return SizedBox();
      },
    );
  }
}
