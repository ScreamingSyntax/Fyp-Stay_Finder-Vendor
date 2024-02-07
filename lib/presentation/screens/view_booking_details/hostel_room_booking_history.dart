import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stayfinder_vendor/data/model/booked_model.dart';
import 'package:stayfinder_vendor/data/model/room_image_model.dart';
import 'package:stayfinder_vendor/logic/cubits/fetch_particular_booking_request/fetch_particular_booking_details_cubit.dart';
import 'package:stayfinder_vendor/presentation/screens/view_booking_details/call_booking_apis.dart';
import 'package:stayfinder_vendor/presentation/widgets/widgets_exports.dart';

import '../../../constants/ip.dart';
import '../../../data/model/model_exports.dart';
import '../../../logic/blocs/login/login_bloc.dart';
import '../../../logic/cubits/cubit_exports.dart';
import '../adding_accommodations/view_accommoation_screen.dart/hostel/hostel_room_view.dart';

class HostelRoomBookingHistory extends StatelessWidget {
  final Map data;

  HostelRoomBookingHistory({required this.data});
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

            // List<RoomImage?>? list = List.from(state.roomImage as Iterable);
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
                    child: Column(children: [
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
                            Text("Booking Details"),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                            Icon(Icons.calendar_today_outlined,
                                                color: Color(0xff4c4c4c)),
                                            SizedBox(width: 8),
                                            CustomPoppinsText(
                                              text: booked.check_in.toString(),
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
                                              text: booked.check_out.toString(),
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
                  Padding(
                    padding: const EdgeInsets.all(15.0),
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
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.all(20),
                      // color: Colors.amber,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  Row(
                                    // crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      CustomPoppinsText(
                                          text: "Rs",
                                          fontSize: 15,
                                          color: Color(0xff4c4c4c),
                                          fontWeight: FontWeight.w700),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      CustomPoppinsText(
                                          text: accommodation.admission_rate!
                                              .toString(),
                                          fontSize: 23,
                                          color: Color(0xff4c4c4c),
                                          fontWeight: FontWeight.w700),
                                    ],
                                  ),
                                ],
                              ),
                              // if (
                              //         .accommodation!.is_rejected! ||
                              //
                              //         .accommodation!.is_verified!)
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
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.toilet,
                                    size: 14,
                                    color: Color(0xffFFAB1C),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  CustomPoppinsText(
                                      text: accommodation.number_of_washroom
                                          .toString(),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Boxicons.bxs_washer,
                                    size: 14,
                                    color: Color(0xffFF5833),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  CustomPoppinsText(
                                      text: accommodation.weekly_laundry_cycles
                                          .toString(),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                  // CustomVerifiedWidget(
                                  //     value:
                                  //         .accommodation!.weekly_laundry_cycles!),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.parking,
                                    size: 14,
                                    color: Color(0xff4C4C4C),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  CustomVerifiedWidget(
                                      value:
                                          accommodation.parking_availability!)
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Icon(
                                  //   Icons.,
                                  //   size: 14,
                                  //   color: Color(0xffFFAB1C),
                                  // ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 14,
                                        width: 14,
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(500)),
                                      ),
                                      Text(
                                        "Non-Veg",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 8,
                                            color: Colors.red),
                                      )
                                    ],
                                  ),

                                  SizedBox(
                                    width: 10,
                                  ),

                                  CustomPoppinsText(
                                      text: accommodation.weekly_non_veg_meals
                                          .toString(),
                                      fontSize: 14,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w500),
                                ],
                              ),
                              Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.food_bank,
                                        size: 15,
                                        color: Colors.blue,
                                      ),
                                      Text(
                                        "Meals/Day",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 8,
                                            color: Colors.blue),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  CustomPoppinsText(
                                      text: accommodation.meals_per_day
                                          .toString(),
                                      fontSize: 14,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w500),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
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
                      padding: EdgeInsets.all(0),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Text("Booked Room Details"),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            HostelViewCard(
                              images: state.roomImage as List<RoomImage>,
                              id: room.id!,
                              onEdit: (p0) {},
                              onChangePhoto: (p0) async {},
                              bedCount: room.seater_beds.toString(),
                              fanAvailability: room.fan_availability!,
                              onDelete: (p0) {},
                              ruppes: room.monthly_rate.toString(),
                              roomIndex: 0,
                              washRoomStatus: room.washroom_status.toString(),
                            )
                          ]))
                ])));
          }
          return Column(
            children: [Text("I am under da water heodad")],
          );
        },
      ),
    );
  }
}
