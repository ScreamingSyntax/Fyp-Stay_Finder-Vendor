import '../../logic/cubits/cubit_exports.dart';
import '../../presentation/widgets/widgets_exports.dart';

// ignore: must_be_immutable
class OnBoardingScreen extends StatelessWidget {
  int index = 0;
  double value = 0;
  List<Widget> images = [
    templateBoarding(
      imagePath: "assets/on_boarding_images/On_Boarding_1.png",
      heading: "Welcome to Stay Finder",
      body:
          "Get started by signing up and verifying your identity with your citizenship card.",
    ),
    templateBoarding(
      imagePath: "assets/on_boarding_images/On_Boarding_2.png",
      heading: "Add Yours too",
      body:
          "List your accommodations and reach students seeking their ideal stay.",
    ),
    templateBoarding(
      imagePath: "assets/on_boarding_images/On_Boarding_3.png",
      heading: "Make Money",
      body:
          "Grow your business with additional listings through our monthly subscription.",
    ),
  ];
  CarouselController buttonCarsouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        context.read<OnBoardingCubit>()..visitedOnBoarding();
                        Navigator.pushNamed(context, "/");
                      },
                      child: Hero(tag: "here", child: Text("Skip")))
                ],
              ),
            ),
            FlutterCarousel(
              items: images,
              options: CarouselOptions(
                onPageChanged: (index, reason) {
                  this.index = index;
                },
                onScrolled: (value) {
                  // this.index = value.;
                  this.value = value!;
                },
                autoPlay: false,
                controller: buttonCarsouselController,
                height: MediaQuery.of(context).size.height / 1.4,
                enlargeCenterPage: true,
                viewportFraction: 0.9,
                aspectRatio: 2.0,
                showIndicator: false,
                initialPage: 0,
              ),
            ),
            Hero(
              tag: "htere",
              child: TextButton(
                  onPressed: () {
                    if (this.index == 2) {
                      Navigator.pushNamed(context, "/");
                    } else {
                      buttonCarsouselController.nextPage();
                      context.read<OnBoardingCubit>()..visitedOnBoarding();
                    }
                  },
                  child:
                      Text("Next", style: TextStyle(color: Color(0xff29383F)))),
            )
          ],
        ),
      ),
    );
  }
}

class templateBoarding extends StatelessWidget {
  final String imagePath;
  final String heading;
  final String body;
  const templateBoarding({
    super.key,
    required this.imagePath,
    required this.heading,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(imagePath),
        Text(
          heading,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xff29383F),
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          body,
          style: TextStyle(color: Color(0xff808080)),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
