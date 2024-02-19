import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:stayfinder_vendor/constants/ip.dart';
import 'package:stayfinder_vendor/presentation/widgets/widgets_exports.dart';

class ReviewsCard extends StatelessWidget {
  final String userName;
  final double ratings;
  final String date;
  String? image;
  final String description;
  ReviewsCard({
    Key? key,
    required this.userName,
    required this.ratings,
    required this.date,
    required this.description,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                RatingBar.builder(
                  initialRating: ratings,
                  minRating: 1,
                  updateOnDrag: false,
                  ignoreGestures: true,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  unratedColor: Colors.black.withOpacity(0.2),
                  itemSize: 15,
                  itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
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
                Text(
                  userName,
                  style: TextStyle(
                      fontSize: 10,
                      color: Colors.black.withOpacity(0.2),
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Text(
              formatDateTimeinMMMMDDYYY(date),
              style: TextStyle(
                  fontSize: 10,
                  color: Colors.black.withOpacity(0.2),
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        if (image != null)
          CachedNetworkImage(
              key: UniqueKey(),
              imageUrl: "${getIpWithoutSlash()}${image}",
              maxHeightDiskCache: 200,
              imageBuilder: (context, imageProvider) {
                return Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                          image: imageProvider)),
                );
              },
              placeholder: (context, url) => Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(

                        // borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/logos/logo.png"))),
                  ),
              errorWidget: (context, url, error) => Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/logos/logo.png"))),
                  )),
        SizedBox(
          height: 10,
        ),
        Text(
          description,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
