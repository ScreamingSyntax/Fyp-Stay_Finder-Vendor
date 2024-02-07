import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stayfinder_vendor/logic/blocs/bloc_exports.dart';
import 'package:stayfinder_vendor/logic/cubits/cubit_exports.dart';
import 'package:stayfinder_vendor/presentation/widgets/widgets_exports.dart';

import '../../../constants/ip.dart';
import '../../../data/model/booked_model.dart';
import '../adding_accommodations/view_accommoation_screen.dart/rental_room_view.dart';
import 'call_booking_apis.dart';

class RentalRoomBookingScreen extends StatelessWidget {
  final Map data;

  const RentalRoomBookingScreen({super.key, required this.data});
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

                          // CallHotelWithTierAPi.fetchHotelWithTierApis(
                          //     context: context,
                          //     token: data['token'],
                          //     accommodationID: data['id'].toString());
                          // fetchHotelWithTierApis(
                          //     accommodationID: data['id'].toString(),
                          //     token: data['token'],
                          //     context: context);
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
            Booked booked = state.booked!;
            return RefreshIndicator(
              onRefresh: () async {
                var state = context.read<LoginBloc>().state;
                if (state is LoginLoaded) {
                  return CallBookingDetailsParticularAPi.fetchHotelWithTierApis(
                      token: state.successModel.token!,
                      id: data["id"].toString(),
                      accommodation: data["accommodation"],
                      context: context);
                }
              },
              child: SingleChildScrollView(
                  child: Column(children: [
                Column(children: [
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
                            offset: Offset(0, 3), // changes position of shadow
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
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      decoration: BoxDecoration(
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
                                      text: state.accommodation!.name!,
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
                                          text: state
                                              .accommodation!.monthly_rate!
                                              .toString(),
                                          fontSize: 23,
                                          color: Color(0xff4c4c4c),
                                          fontWeight: FontWeight.w700),
                                    ],
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
                                      "${state.accommodation!.city}, ${state.accommodation!.address}",
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
                                      text: state
                                          .accommodation!.number_of_washroom
                                          .toString(),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.dumpster,
                                    size: 14,
                                    color: Color(0xffFF5833),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  CustomVerifiedWidget(
                                      value: state.accommodation!
                                          .trash_dispose_availability!),
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
                                      value: state
                                          .accommodation!.parking_availability!)
                                ],
                              ),
                            ],
                          ),

                          // ListView.builder(
                          //   itemCount: 5,
                          //   itemBuilder: (context, index) {
                          //   return
                          // },)

                          // CustomPoppinsText(text: "", fontSize: fontSize, fontWeight: fontWeight)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomPoppinsText(
                                  text: "Room Images",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Container(
                              height: 100,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: state.roomImage!.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Row(
                                          children: [
                                            RoomImageRental(
                                                image: NetworkImage(
                                                    "${getIpWithoutSlash()}${state.roomImage![index]!.images}")),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.all(20),
                      // color: Colors.amber,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomPoppinsText(
                                  text: "Room Details",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RoomDetailWidgetRental(
                            text: "Bed",
                            value: state.room!.bed_availability!,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          RoomDetailWidgetRental(
                            text: "Fan",
                            value: state.room!.fan_availability!,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          RoomDetailWidgetRental(
                            text: "Sofa",
                            value: state.room!.sofa_availability!,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          RoomDetailWidgetRental(
                            text: "Mat",
                            value: state.room!.mat_availability!,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          RoomDetailWidgetRental(
                            text: "Carpet",
                            value: state.room!.carpet_availability!,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              CustomPoppinsText(
                                  text: '\u2022 Washroom Status :',
                                  fontSize: 13,
                                  color: Colors.black.withOpacity(0.6),
                                  fontWeight: FontWeight.w600),
                              SizedBox(
                                width: 10,
                              ),
                              CustomPoppinsText(
                                  text: state.room!.washroom_status!,
                                  fontSize: 13,
                                  color: Colors.black.withOpacity(0.6),
                                  fontWeight: FontWeight.w600),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          RoomDetailWidgetRental(
                            text: "Dustbin",
                            value: state.room!.dustbin_availability!,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          RoomDetailWidgetRental(
                            text: "Trash Disposable",
                            value: state
                                .accommodation!.trash_dispose_availability!,
                          ),
                        ],
                      ),
                      // color: Colors.amber,

                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ])
              ])),
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
