import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stayfinder_vendor/presentation/widgets/widgets_exports.dart';

import '../../../constants/ip.dart';
import '../../../data/model/booked_model.dart';
import '../../../data/model/model_exports.dart';
import '../../../logic/blocs/bloc_exports.dart';
import '../../../logic/cubits/cubit_exports.dart';
import 'call_booking_apis.dart';

class HotelWithoutTierHistory extends StatelessWidget {
  final Map data;

  Widget customRoomCard(
      {required BuildContext context, required Room room, required int index}) {
    return Container(
        padding: EdgeInsets.all(10),
        child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
                initiallyExpanded: true,
                title: ListTile(
                  subtitle: CustomPoppinsText(
                      text:
                          "This room has ${room.seater_beds} beds and costs ${room.per_day_rent} ruppess",
                      fontSize: 11,
                      fontWeight: FontWeight.w400),
                  title: CustomPoppinsText(
                      text: "Room ${index + 1} ",
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
                expandedAlignment: Alignment.center,

                // expandedCrossAxisAlignment: CrossAxisAlignment.center,
                // childrenPadding: EdgeInsets.symmetric(horizontal: 25),
                children: [
                  Container(
                      padding: EdgeInsets.all(25),
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

  const HotelWithoutTierHistory({super.key, required this.data});
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
            return RefreshIndicator(
              onRefresh: () async {
                var state = context.read<LoginBloc>().state;
                if (state is LoginLoaded) {
                  CallBookingDetailsParticularAPi.fetchHotelWithTierApis(
                      token: state.successModel.token!,
                      id: data["id"].toString(),
                      accommodation: data["accommodation"],
                      context: context);
                }
              },
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
                        // color: Colors.amber,
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
                              Text("Booking Details"),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.account_circle_outlined,
                                              color: Color(0xff4c4c4c)),
                                          SizedBox(width: 8),
                                          CustomPoppinsText(
                                              text: booked.user!.full_name!,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400)
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.email_outlined,
                                            color: Color(0xff4c4c4c),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          CustomPoppinsText(
                                              text: booked.user!.email!,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400)
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(Icons.payment_outlined,
                                              color: Color(0xff4c4c4c)),
                                          SizedBox(width: 8),
                                          CustomPoppinsText(
                                            text:
                                                "At Rs ${booked.paid_amount.toString()}",
                                            fontSize: 14,
                                            color: Color(0xff4c4c4c),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                  Icons.calendar_today_outlined,
                                                  color: Color(0xff4c4c4c)),
                                              SizedBox(width: 8),
                                              CustomPoppinsText(
                                                text:
                                                    booked.check_in.toString(),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ],
                                          ),
                                          Text(" -- "),
                                          Row(
                                            children: [
                                              Icon(Icons.calendar_month,
                                                  color: Color(0xff4c4c4c)),
                                              SizedBox(width: 8),
                                              CustomPoppinsText(
                                                text:
                                                    booked.check_out.toString(),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        )),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 40.0),
                            child: Text("Booked Room Details"),
                          ),
                          customRoomCard(
                              context: context, index: 1, room: room),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    )
                  ],
                ),
              ),
            );
          }
          return Column(
            children: [],
          );
        },
      ),
    );
  }
}
