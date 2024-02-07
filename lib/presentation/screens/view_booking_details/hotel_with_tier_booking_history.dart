import 'package:flutter/cupertino.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stayfinder_vendor/logic/cubits/fetch_particular_booking_request/fetch_particular_booking_details_cubit.dart';
import 'package:stayfinder_vendor/presentation/screens/view_booking_details/call_booking_apis.dart';
import 'package:stayfinder_vendor/presentation/widgets/widgets_exports.dart';

import '../../../constants/constants_exports.dart';
import '../../../data/model/booked_model.dart';
import '../../../data/model/model_exports.dart';
import '../../../logic/blocs/bloc_exports.dart';

class HotelWithTierBookingHistory extends StatelessWidget {
  final Map data;

  Widget customRoomCard(
      {required BuildContext context, required Room room, required int index}) {
    return Container(
        child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
                initiallyExpanded: true,
                title: ListTile(
                  subtitle: CustomPoppinsText(
                      text:
                          "This room has ${room.seater_beds} beds and costs ${room.per_day_rent} ruppess",
                      fontSize: 12,
                      color: Colors.black.withOpacity(0.5),
                      fontWeight: FontWeight.w400),
                  title: CustomPoppinsText(
                      text: "Room ${index + 1} ",
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                expandedAlignment: Alignment.center,
                children: [
                  Container(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomCheckBoxDetailTile(
                                icon: FontAwesomeIcons.fan,
                                text: "Fan",
                                value: room.fan_availability!,
                              ),
                              CustomCheckBoxDetailTile(
                                icon: Icons.ac_unit,
                                text: "A.C",
                                value: room.ac_availability!,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomCheckBoxDetailTile(
                                icon: Icons.water,
                                text: "Milk",
                                value: room.milk_powder_availability!,
                              ),
                              CustomCheckBoxDetailTile(
                                icon: FontAwesomeIcons.jar,
                                text: "Kettle",
                                value: room.kettle_availability!,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomCheckBoxDetailTile(
                                icon: Icons.iron,
                                text: "Iron",
                                value: room.steam_iron_availability!,
                              ),
                              CustomCheckBoxDetailTile(
                                icon: Icons.hot_tub,
                                text: "Tea",
                                value: room.tea_powder_availability!,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomCheckBoxDetailTile(
                                icon: FontAwesomeIcons.bottleWater,
                                text: "Bottle",
                                value: room.water_bottle_availability!,
                              ),
                              CustomCheckBoxDetailTile(
                                icon: Icons.coffee,
                                text: "Coffee",
                                value: room.coffee_powder_availability!,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomCheckBoxDetailTile(
                                icon: FontAwesomeIcons.hotjar,
                                text: "Dryer",
                                value: room.hair_dryer_availability!,
                              ),
                              CustomCheckBoxDetailTile(
                                  icon: Icons.tv,
                                  text: "T.V",
                                  value: room.tv_availability!)
                            ],
                          ),
                        ],
                      ))
                ])));
  }

  const HotelWithTierBookingHistory({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FetchParticularBookingDetailsCubit,
          FetchParticularBookingDetailsState>(
        builder: (context, state) {
          if (state is FetchParticularBookingDetailsLoading) {
            return CircularProgressIndicator();
          }
          if (state is FetchParticularBookingDetailsError) {
            return Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomPoppinsText(
                      text: state.message,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100.0),
                    child: CustomMaterialButton(
                        onPressed: () async {
                          var state = context.read<LoginBloc>().state;
                          if (state is LoginLoaded) {
                            CallBookingDetailsParticularAPi
                                .fetchHotelWithTierApis(
                                    token: state.successModel.token!,
                                    id: data["id"].toString(),
                                    accommodation: data["accommodation"],
                                    context: context);
                          }
                        },
                        child: Text("Retry"),
                        backgroundColor: Color(0xff4C4C4C),
                        textColor: Colors.white,
                        height: 45),
                  )
                ],
              ),
            );
          }
          if (state is FetchParticularBookingDetailsLoaded) {
            Room room = state.room!;
            Accommodation accommodation = state.accommodation!;
            Booked booked = state.booked!;
            HotelTier hotelTier = state.tier!;

            return RefreshIndicator(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomMainImageVIew(
                        imageLink:
                            "${getIpWithoutSlash()}${state.accommodation!.image}",
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(20),
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        CustomPoppinsText(
                                            text: accommodation.name!,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                        SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Divider(
                                  color: Color(0xff4c4c4c).withOpacity(0.5),
                                  height: 0.5,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Boxicons.bx_map_pin,
                                      size: 14,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    CustomPoppinsText(
                                        text:
                                            "${accommodation.city}, ${accommodation.address}",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                FontAwesomeIcons.parking,
                                                color: Colors.red,
                                                size: 14,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              CustomVerifiedWidget(
                                                  value: accommodation
                                                      .parking_availability!)
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Boxicons.bx_dumbbell,
                                                color: Colors.green,
                                                size: 14,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              CustomVerifiedWidget(
                                                  value: accommodation
                                                      .gym_availability!)
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                FontAwesomeIcons.swimmingPool,
                                                color: Colors.red,
                                                size: 14,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              CustomVerifiedWidget(
                                                  value: accommodation
                                                      .swimming_pool_availability!)
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ]),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                    // padding: EdgeInsets.all(20),

                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      // mainAxisAlignment,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CustomPoppinsText(
                                              text: "Booked Tier & Room",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          height: 25,
                                        ),
                                        Container(
                                          height: 150,
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                "${getIpWithoutSlash()}${hotelTier.image}",
                                            imageBuilder:
                                                (context, imageProvider) {
                                              return Container(
                                                // alignment: Alignment.center,
                                                // padding: EdgeInsets.all(19),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    1,
                                                height: 150,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    image: DecorationImage(
                                                        alignment:
                                                            Alignment.center,
                                                        image: imageProvider,
                                                        fit: BoxFit.cover)),
                                              );
                                            },
                                          ),
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16.0, vertical: 15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    child: CustomPoppinsText(
                                                        text: hotelTier
                                                            .tier_name!,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              CustomPoppinsText(
                                                  text: hotelTier.description!,
                                                  fontSize: 12,
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  fontWeight: FontWeight.w500),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              customRoomCard(
                                  context: context, room: room, index: 1),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                onRefresh: () async {
                  var state = context.read<LoginBloc>().state;
                  if (state is LoginLoaded) {
                    CallBookingDetailsParticularAPi.fetchHotelWithTierApis(
                        token: state.successModel.token!,
                        id: data["id"].toString(),
                        accommodation: data["accommodation"],
                        context: context);
                  }
                });
          }
          return Column(
            children: [],
          );
        },
      ),
    );
  }
}
