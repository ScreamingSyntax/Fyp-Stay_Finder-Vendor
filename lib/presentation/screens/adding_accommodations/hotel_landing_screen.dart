import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:stayfinder_vendor/data/model/model_exports.dart';
import 'package:stayfinder_vendor/logic/blocs/accommodation_addition/accommodation_addition_bloc.dart';
import 'package:stayfinder_vendor/logic/blocs/bloc_exports.dart';
import 'package:stayfinder_vendor/presentation/widgets/widgets_exports.dart';

class HotelLandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
          child: CustomMaterialButton(
              onPressed: () {},
              child: Text("Continue"),
              backgroundColor: Color(0xff32454D),
              textColor: Colors.white,
              height: 50)),
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
                          AssetImage("assets/images/Hotel_Booking-amico.png"))),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          CustomPoppinsText(
              text: "Please add some more details",
              fontSize: 12,
              fontWeight: FontWeight.w500),
          SizedBox(
            height: 30,
          ),
          BlocBuilder<AccommodationAdditionBloc, AccommodationAdditionState>(
            builder: (context, state) {
              return Column(
                children: [
                  WidgetRow(
                    widget1: CustomCheckBoxTile(
                        title: "Has Tier",
                        onChanged: (p0) {
                          print(p0);
                          context.read<AccommodationAdditionBloc>().add(
                              AccommodationAdditionUpdateHitEvent(
                                  accommodation: state.accommodation!
                                      .copyWith(has_tier: (p0!))));
                        },
                        value: context
                            .watch<AccommodationAdditionBloc>()
                            .state
                            .accommodation!
                            .has_tier!,
                        icon: Boxicons.bx_medal),
                    widget2: CustomCheckBoxTile(
                        title: "Has Parking",
                        onChanged: (p0) {
                          context.read<AccommodationAdditionBloc>().add(
                              AccommodationAdditionUpdateHitEvent(
                                  accommodation: state.accommodation!
                                      .copyWith(parking_availability: (p0!))));
                        },
                        value: context
                            .watch<AccommodationAdditionBloc>()
                            .state
                            .accommodation!
                            .parking_availability!,
                        icon: Boxicons.bx_medal),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  WidgetRow(
                      widget1: CustomCheckBoxTile(
                          title: "Has Gym",
                          onChanged: (p0) {
                            context.read<AccommodationAdditionBloc>().add(
                                AccommodationAdditionUpdateHitEvent(
                                    accommodation: state.accommodation!
                                        .copyWith(gym_availability: (p0!))));
                          },
                          value: context
                              .watch<AccommodationAdditionBloc>()
                              .state
                              .accommodation!
                              .gym_availability!,
                          icon: Boxicons.bx_medal),
                      widget2: CustomCheckBoxTile(
                          title: "Has Swimming",
                          onChanged: (p0) {
                            context.read<AccommodationAdditionBloc>().add(
                                AccommodationAdditionUpdateHitEvent(
                                    accommodation: state.accommodation!
                                        .copyWith(
                                            swimming_pool_availability:
                                                (p0!))));
                          },
                          value: context
                              .watch<AccommodationAdditionBloc>()
                              .state
                              .accommodation!
                              .swimming_pool_availability!,
                          icon: Boxicons.bx_medal)),
                ],
              );
            },
          ),
          SizedBox(
            height: 30,
          ),
          CustomPoppinsText(
              text: "Note: Tick has tier if your hotel has tier based rooms",
              fontSize: 12,
              fontWeight: FontWeight.bold)
        ],
      ),
    );
  }
}

class WidgetRow extends StatelessWidget {
  final Widget widget1;
  final Widget widget2;

  WidgetRow({
    super.key,
    required this.widget1,
    required this.widget2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
            width: MediaQuery.of(context).size.width / 2.5, child: widget1),
        SizedBox(
            width: MediaQuery.of(context).size.width / 2.3, child: widget2),
      ],
    );
  }
}
