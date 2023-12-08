import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:stayfinder_vendor/presentation/widgets/widgets_exports.dart';

class HostelWithoutTierScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Arc(
            height: 50,
            arcType: ArcType.CONVEX,
            child: Container(
              height: MediaQuery.of(context).size.height / 2.5,
              decoration: BoxDecoration(
                  color: Color(0xff32454D),
                  image: DecorationImage(
                      image:
                          AssetImage("assets/images/Hotel_Booking-bro.png"))),
            ),
          ),
        ],
      ),
    );
  }
}
