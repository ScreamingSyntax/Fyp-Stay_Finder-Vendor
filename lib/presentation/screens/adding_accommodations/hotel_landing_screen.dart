import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:stayfinder_vendor/logic/blocs/accommodation_addition/accommodation_addition_bloc.dart';
import 'package:stayfinder_vendor/logic/blocs/bloc_exports.dart';
import 'package:stayfinder_vendor/logic/blocs/hotel_without_tier_addition/add_hotel_without_tier_bloc.dart';
import 'package:stayfinder_vendor/presentation/widgets/widgets_exports.dart';

class HotelLandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
          child: CustomMaterialButton(
              onPressed: () {
                bool hasTier = context
                    .read<AccommodationAdditionBloc>()
                    .state
                    .accommodation!
                    .has_tier!;
                return showExitPopup(
                  context: context,
                  message: hasTier
                      ? "Are you sure your hotel has tier? "
                      : "Are you sure your hotel  doesn't have a tier?",
                  title: "Confirmation",
                  noBtnFunction: () => Navigator.pop(context),
                  yesBtnFunction: () {
                    if (hasTier) {
                      Navigator.pushNamed(context, "/hotelWithTierAddScreen");
                    }
                    if (!hasTier) {
                      context
                          .read<AddHotelWithoutTierBloc>()
                          .add(ClearHotelWithoutTierRoomsEvent());
                      BlocProvider.of<AddHotelWithoutTierBloc>(context)
                        ..add(AddHotelWithoutTierHitEvent(
                            accommodationImage: context
                                .read<AccommodationAdditionBloc>()
                                .state
                                .image,
                            accommodation: context
                                .read<AccommodationAdditionBloc>()
                                .state
                                .accommodation!));
                      Navigator.pushNamed(
                          context, "/hotelWithoutTierAddScreen");
                    }
                  },
                );
              },
              child: Text("Continue"),
              backgroundColor: Color(0xff32454D),
              textColor: Colors.white,
              height: 50)),
      body: WillPopScope(
        onWillPop: () => showExitPopup(
          context: context,
          message: "Are you sure you want to cancel adding?",
          title: "Confirmation",
          noBtnFunction: () {
            Navigator.pop(context);
          },
          yesBtnFunction: () {
            int count = 0;
            Navigator.of(context).popUntil((_) => count++ >= 5);
            context
                .read<AccommodationAdditionBloc>()
                .add(AccommodationClearEvent());
          },
        ),
        child: Column(
          children: [
            Arc(
              height: 50,
              arcType: ArcType.CONVEX,
              child: Container(
                height: MediaQuery.of(context).size.height / 2.5,
                decoration: BoxDecoration(
                    color: Color(0xff32454D),
                    image: DecorationImage(
                        image: AssetImage(
                            "assets/images/Hotel_Booking-amico.png"))),
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
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      CustomWidgetRow(
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
                                          .copyWith(
                                              parking_availability: (p0!))));
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
                      CustomWidgetRow(
                          widget1: CustomCheckBoxTile(
                              title: "Has Gym",
                              onChanged: (p0) {
                                context.read<AccommodationAdditionBloc>().add(
                                    AccommodationAdditionUpdateHitEvent(
                                        accommodation: state.accommodation!
                                            .copyWith(
                                                gym_availability: (p0!))));
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
                  ),
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
      ),
    );
  }
}
