import 'dart:io';

import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:stayfinder_vendor/data/repository/repository_exports.dart';
import 'package:stayfinder_vendor/logic/blocs/add_hotel_with_tier/add_hotel_with_tier_bloc_bloc.dart';
import 'package:stayfinder_vendor/logic/blocs/bloc_exports.dart';
import 'package:stayfinder_vendor/presentation/screens/screen_exports.dart';
import 'package:stayfinder_vendor/presentation/widgets/widgets_exports.dart';

import '../../../logic/blocs/hotel_with_tier_addition_api/add_hotel_with_tier_api_bloc.dart';
import '../../../logic/cubits/store_rooms/store_rooms_cubit.dart';

class HostelWithTierScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddHotelWithTierApiBloc(
          repository: AccommodationAdditionRepository()),
      child: Builder(builder: (context) {
        return WillPopScope(
          onWillPop: () {
            return showExitPopup(
              context: context,
              message: "Are you sure you want to exit?",
              title: "Confirmation",
              noBtnFunction: () {
                Navigator.pop(context);
              },
              yesBtnFunction: () {
                int count = 0;
                Navigator.of(context).popUntil((_) => count++ >= 7);
              },
            );
          },
          child: Scaffold(
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(20.0),
              child: BlocConsumer<AddHotelWithTierApiBloc,
                  AddHotelWithTierApiState>(
                listener: (context, state) {
                  if (state is AddHotelWithTierLoading) {
                    return customScaffold(
                        context: context,
                        title: "Please Wait",
                        message: "We are verifying your data",
                        contentType: ContentType.warning);
                  }
                  if (state is AddHotelWithTierError) {
                    return customScaffold(
                        context: context,
                        title: "Error",
                        message: state.message,
                        contentType: ContentType.failure);
                  }
                  if (state is AddHotelWithTierSuccess) {
                    customScaffold(
                        context: context,
                        title: "Success",
                        message: state.message,
                        contentType: ContentType.success);
                    var loginState = context.read<LoginBloc>().state;
                    if (loginState is LoginLoaded) {
                      callApis(context, loginState);
                    }
                    int count = 0;
                    Navigator.of(context).popUntil((_) => count++ >= 6);
                  }
                },
                builder: (context, state) {
                  if (state is AddHotelWithTierLoading) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [CircularProgressIndicator()],
                    );
                  }
                  return CustomMaterialButton(
                      onPressed: () {
                        AddHotelWithTierBlocState addHotelWithTierBlocState =
                            context.read<AddHotelWithTierBlocBloc>().state;
                        if (addHotelWithTierBlocState.tier!.length < 2) {
                          return customScaffold(
                              context: context,
                              title: "Warning",
                              message: "Please add atleast two tier",
                              contentType: ContentType.warning);
                        } else {
                          // print(context)
                          var state = context.read<LoginBloc>().state;
                          if (state is LoginLoaded) {
                            context.read<AddHotelWithTierApiBloc>()
                              ..add(AddHotelWithTierHitApiEvent(
                                  tierImages:
                                      addHotelWithTierBlocState.tierImages,
                                  token: state.successModel.token!,
                                  accommodation:
                                      addHotelWithTierBlocState.accommodation!,
                                  tier: addHotelWithTierBlocState.tier!,
                                  rooms: addHotelWithTierBlocState.rooms!,
                                  accommodationImage: addHotelWithTierBlocState
                                      .accommodationImage!));
                          }
                        }
                      },
                      child: Text("Confirm Addition"),
                      backgroundColor: Color(0xff32454D),
                      textColor: Colors.white,
                      height: 45);
                },
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
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
                                      "assets/images/Hotel_Booking-bro.png"))),
                        ),
                      ),
                      Positioned(
                          top: 50,
                          left: 30,
                          child: InkWell(
                            onTap: () {
                              showExitPopup(
                                context: context,
                                message: "Do you really want to go back?",
                                title: "Confirmation",
                                noBtnFunction: () {
                                  Navigator.pop(context);
                                },
                                yesBtnFunction: () {
                                  int count = 0;
                                  Navigator.of(context)
                                      .popUntil((_) => count++ >= 7);
                                },
                              );
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ))
                    ],
                  ),

                  // Text("A"),
                  (context.watch<AddHotelWithTierBlocBloc>().state.tier != null)
                      ? showTiers(context)
                      : Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            CustomPoppinsText(
                                text: "Please add atleast one tier for w",
                                color: Color(0xff32454D),
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: CustomMaterialButton(
                        onPressed: () {
                          context.read<StoreRoomsCubit>().clearEverything();
                          Navigator.pushNamed(
                              context, "/hotelWithTierAddTierScreen");
                        },
                        child: Icon(
                          Icons.add,
                          size: 30,
                        ),
                        backgroundColor: Color(0xff32454D),
                        textColor: Colors.white,
                        height: 50),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget showTiers(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount:
              context.watch<AddHotelWithTierBlocBloc>().state.tier!.length,
          itemBuilder: (context, index) {
            int index2 = 0;

            int totalRooms = 0;
            List prices = [];
            late int lowest;
            late int highest;
            index2 = context
                .read<AddHotelWithTierBlocBloc>()
                .state
                .tier!
                .keys
                .toList()[index];
            var tier = context
                .watch<AddHotelWithTierBlocBloc>()
                .state
                .rooms![index2]!
                .forEach((element) {
              totalRooms += element.seater_beds!;
              prices.add(element.monthly_rate);
            });
            File tierImage = context
                .watch<AddHotelWithTierBlocBloc>()
                .state
                .tierImages![index2]!;
            prices.sort();
            var tiers = context
                .watch<AddHotelWithTierBlocBloc>()
                .state
                .tier!
                .values
                .toList();
            if (prices.length > 1) {
              lowest = prices[0];
              highest = prices[1];
            } else {
              lowest = 0;
              highest = prices[0];
            }
            // return Text(tiers[index].description!);
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xfff5eeec),
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  children: [
                    ListTile(
                      trailing: InkWell(
                        onTap: () {
                          context.read<AddHotelWithTierBlocBloc>()
                            ..add(DeleteTierOnAccommodationWithTierEvent(
                                tiers[index]));
                        },
                        child: Icon(
                          Boxicons.bx_trash_alt,
                          color: Colors.red,
                        ),
                      ),
                      leading: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image:
                                DecorationImage(image: FileImage(tierImage))),
                      ),

                      // Image.file(
                      //   tierImage,
                      // ),
                      //  Image.asset("assets/logos/logo.png"),
                      title: CustomPoppinsText(
                          text: tiers[index].name!,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),

                      // Text("${tiers[index].name!}",

                      // ),
                      subtitle: CustomPoppinsText(
                          text: tiers[index].description!,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.bed,
                                // size: 15,
                                color: Color(0xff32454D),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                totalRooms.toString(),
                                style: TextStyle(
                                    color: Color(0xff32454D), fontSize: 12),
                              ),
                              // Text(prices.toString())
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Icon(
                                Boxicons.bx_dollar,
                                color: Color(0xff32454D),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                lowest.toString(),
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(" - "),
                              Text(
                                highest.toString(),
                                style: TextStyle(fontSize: 12),
                              ),
                              // Text(prices.toString())
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
