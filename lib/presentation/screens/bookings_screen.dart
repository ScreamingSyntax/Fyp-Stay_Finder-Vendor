import 'package:stayfinder_vendor/constants/constants_exports.dart';
import 'package:stayfinder_vendor/data/model/booked_model.dart';
import 'package:stayfinder_vendor/logic/blocs/bloc_exports.dart';
import 'package:stayfinder_vendor/logic/cubits/verify_book_request/verify_booking_request_cubit.dart';
import 'package:stayfinder_vendor/presentation/screens/view_booking_details/hostel_room_booking_history.dart';
import 'package:stayfinder_vendor/presentation/screens/view_booking_details/hotel_with_tier_booking_history.dart';
import 'package:stayfinder_vendor/presentation/screens/view_booking_details/rental_room_booking_history.dart';
import 'package:stayfinder_vendor/presentation/widgets/widgets_exports.dart';
import 'package:intl/intl.dart';
import '../../data/model/model_exports.dart';
import '../../logic/cubits/cubit_exports.dart';
import 'view_booking_details/hotel_without_tier_booking_history.dart';

class BookingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocListener<VerifyBookingRequestCubit,
              VerifyBookingRequestState>(
            listener: (context, state) {
              // TODO: implement listener
              var loginState = context.read<LoginBloc>().state;
              String token = "";
              if (loginState is LoginLoaded) {
                token = loginState.successModel.token!;
              }
              if (state is VerifyBookingRequestLoading) {
                customScaffold(
                    context: context,
                    title: "Loading",
                    message: "Please wait...",
                    contentType: ContentType.warning);
              }
              if (state is VerifyBookingRequestSuccess) {
                customScaffold(
                    context: context,
                    title: "Successs",
                    message: state.message,
                    contentType: ContentType.success);
                context.read<FetchBookingRequestCubit>()
                  ..fetchBookingRequests(token: token);
              }
              if (state is VerifyBookRequestError) {
                customScaffold(
                    context: context,
                    title: "Error",
                    message: state.error,
                    contentType: ContentType.failure);
              }
            },
            child:
                BlocBuilder<FetchBookingRequestCubit, FetchBookingRequestState>(
              builder: (context, state) {
                if (state is FetchBookingRequestInitial) {
                  var state = context.read<LoginBloc>().state;
                  if (state is LoginLoaded) {
                    context.read<FetchBookingRequestCubit>()
                      ..fetchBookingRequests(token: state.successModel.token!);
                  }
                }
                if (state is FetchBookingRequestError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(state.message),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
                          child: CustomMaterialButton(
                              onPressed: () {
                                var state = context.read<LoginBloc>().state;
                                if (state is LoginLoaded) {
                                  context.read<FetchBookingRequestCubit>()
                                    ..fetchBookingRequests(
                                        token: state.successModel.token!);
                                }
                              },
                              child: Text("Retry"),
                              backgroundColor: Color(0xff514f53),
                              textColor: Colors.white,
                              height: 45),
                        )
                      ],
                    ),
                  );
                }
                if (state is FetchBookingRequestSuccesss) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      var state = context.read<LoginBloc>().state;
                      if (state is LoginLoaded) {
                        context.read<FetchBookingRequestCubit>()
                          ..fetchBookingRequests(
                              token: state.successModel.token!);
                      }
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          CustomPoppinsText(
                              text: "Current Booking",
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                          if (state.bookedCustomers.length == 0)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomPoppinsText(
                                  text: "- No Current Booking",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                          SizedBox(
                            height: 20,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: state.bookedCustomers.length,
                            itemBuilder: (BuildContext context, int index) {
                              Booked booked = state.bookedCustomers[index];
                              return InkWell(
                                onTap: () {
                                  var state = context.read<LoginBloc>().state;
                                  if (state is LoginLoaded) {
                                    print(
                                        "The accommodation is ${booked.room!.accommodation}");
                                    context.read<
                                        FetchParticularBookingDetailsCubit>()
                                      ..fetchParticularBookingDetails(
                                          token: state.successModel.token!,
                                          accommodation:
                                              booked.room!.accommodation!,
                                          id: booked.id!.toString());
                                    // if(boo)
                                    String accommodationType =
                                        booked.room!.accommodation!.type!;
                                    var data = {
                                      "accommodation":
                                          booked.room!.accommodation,
                                      "id": booked.id
                                    };
                                    if (accommodationType == "rent_room") {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  RentalRoomBookingScreen(
                                                      data: data)));
                                    }
                                    if (accommodationType == "hostel") {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  HostelRoomBookingHistory(
                                                      data: data)));
                                    }
                                    if (accommodationType == "hotel") {
                                      bool has_tier =
                                          booked.room!.accommodation!.has_tier!;
                                      if (has_tier) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    HotelWithTierBookingHistory(
                                                        data: data)));
                                      }

                                      if (has_tier == false) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    HotelWithoutTierHistory(
                                                        data: data)));
                                      }
                                    }
                                  }
                                },
                                child: Card(
                                  shadowColor: Colors.transparent,
                                  clipBehavior: Clip
                                      .antiAlias, // Adds a smooth border radius effect to the image
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  margin: EdgeInsets.all(10),
                                  elevation: 5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Accommodation Image
                                      CachedNetworkImage(
                                        imageUrl:
                                            "${getIpWithoutSlash()}${booked.room!.accommodation!.image!}", // Construct the image URL
                                        height: 100,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Accommodation Name or Type
                                            Text(
                                              booked.room!.accommodation!
                                                      .name ??
                                                  'Accommodation', // Assuming there's a 'name' field
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            // User Name
                                            Text(
                                              'Booked by: ${booked.user!.full_name}',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            // Check-in and Check-out Dates
                                            Text(
                                              'Check-in: ${booked.check_in}', // Use your formatDate function
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            Text(
                                              'Check-out: ${booked.check_out}', // Use your formatDate function
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            SizedBox(height: 5),
                                            // Paid Amount
                                            Text(
                                              'Paid Amount: ${booked.paid_amount}',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green[700],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          CustomPoppinsText(
                              text: "Requests",
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                          SizedBox(
                            height: 10,
                          ),
                          if (state.bookingRequests.length == 0)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomPoppinsText(
                                  text: "- No Requests yet",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                          // print("The length is  ${state.bookingRequests.length}");

                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: state.bookingRequests.length,
                            itemBuilder: (BuildContext context, int index) {
                              // if (state.bookingRequests.length == 0) {
                              //   return CustomPoppinsText(
                              //       text: "No Bookings Yet",
                              //       fontSize: 10,
                              //       fontWeight: FontWeight.w400);
                              // }
                              BookingRequest request =
                                  state.bookingRequests[index];
                              DateTime parsedDate =
                                  DateFormat("yyyy-MM-ddTHH:mm:ss.S")
                                      .parse(request.requested_on!, true)
                                      .toLocal();
                              // Format the DateTime object into "YYYY-MM-DD"
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(parsedDate);

                              return Card(
                                shadowColor: Colors.transparent,
                                margin: EdgeInsets.all(8.0),
                                elevation: 5,
                                child: Column(
                                  children: [
                                    Container(
                                      child: CachedNetworkImage(
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          width: double.infinity,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(5),
                                              topRight: Radius.circular(5),
                                            ),
                                            image: DecorationImage(
                                              alignment: Alignment.center,
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        imageUrl:
                                            "${getIpWithoutSlash()}${request.room!.accommodation!.image!}",
                                        height: 100,
                                        fit: BoxFit.cover,
                                        alignment: Alignment.center,
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        ListTile(
                                          leading: CircleAvatar(
                                            backgroundImage:
                                                CachedNetworkImageProvider(
                                              "${getIpWithoutSlash()}${request.user!.image}",
                                            ),
                                            onBackgroundImageError: (error,
                                                    stackTrace) =>
                                                Image.asset(
                                                    'assets/logos/logo.png'),
                                          ),
                                          title: Text(
                                              request.user?.full_name ??
                                                  'Unknown User',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12)),
                                          subtitle: Text(
                                            'Requested on: ${formattedDate}\nStatus: ${request.status}',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          trailing: request.status == "rejected"
                                              ? Icon(
                                                  Icons.close,
                                                  color: Colors.red,
                                                )
                                              : Icon(
                                                  request.status == "pending"
                                                      ? Icons.hourglass_empty
                                                      : Icons.check_circle,
                                                  color: request.status ==
                                                          "pending"
                                                      ? Colors.orange
                                                      : Colors.green),
                                        ),
                                        if (request.status == "pending")
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  showExitPopup(
                                                      context: context,
                                                      message:
                                                          "Are you sure you want to confirm ?",
                                                      title: "Confirmation",
                                                      noBtnFunction: () =>
                                                          Navigator.pop(
                                                              context),
                                                      yesBtnFunction: () {
                                                        var state = context
                                                            .read<LoginBloc>()
                                                            .state;
                                                        if (state
                                                            is LoginLoaded) {
                                                          context.read<
                                                              VerifyBookingRequestCubit>()
                                                            ..verifyBookingRequest(
                                                                verify: true,
                                                                token: state
                                                                    .successModel
                                                                    .token!,
                                                                roomId: request
                                                                    .room!.id!,
                                                                bookRequestId:
                                                                    request
                                                                        .id!);
                                                          Navigator.pop(
                                                              context);
                                                        }
                                                      });
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(20),
                                                  alignment: Alignment.center,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3,
                                                  decoration: BoxDecoration(
                                                      // color: Colors.green,
                                                      ),
                                                  child: SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: Row(
                                                      children: [
                                                        CustomPoppinsText(
                                                            text: "Accept",
                                                            fontSize: 12,
                                                            color: Colors.blue,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Icon(
                                                          Icons.verified,
                                                          color: Colors.blue,
                                                          size: 15,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  showExitPopup(
                                                      context: context,
                                                      message:
                                                          "Are you sure you want to confirm ?",
                                                      title: "Confirmation",
                                                      noBtnFunction: () =>
                                                          Navigator.pop(
                                                              context),
                                                      yesBtnFunction: () {
                                                        var state = context
                                                            .read<LoginBloc>()
                                                            .state;
                                                        if (state
                                                            is LoginLoaded) {
                                                          context.read<
                                                              VerifyBookingRequestCubit>()
                                                            ..verifyBookingRequest(
                                                                verify: false,
                                                                token: state
                                                                    .successModel
                                                                    .token!,
                                                                roomId: request
                                                                    .room!.id!,
                                                                bookRequestId:
                                                                    request
                                                                        .id!);
                                                          Navigator.pop(
                                                              context);
                                                        }
                                                      });
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(20),
                                                  alignment: Alignment.center,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3,
                                                  decoration: BoxDecoration(
                                                      // color: Colors.green,
                                                      ),
                                                  child: SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: Row(
                                                      children: [
                                                        CustomPoppinsText(
                                                            text: "Reject",
                                                            fontSize: 12,
                                                            color: Colors.red,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Icon(
                                                          Icons.verified,
                                                          color: Colors.red,
                                                          size: 15,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomPoppinsText(
                              text: "Pasts Bookings",
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                          if (state.pastBooking.length == 0)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomPoppinsText(
                                  text: "- No Pasts Booking",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                          SizedBox(
                            height: 20,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: state.pastBooking.length,
                            itemBuilder: (BuildContext context, int index) {
                              Booked booked = state.pastBooking[index];
                              return InkWell(
                                onTap: () {
                                  var state = context.read<LoginBloc>().state;
                                  if (state is LoginLoaded) {
                                    print(
                                        "The accommodation is ${booked.room!.accommodation}");
                                    context.read<
                                        FetchParticularBookingDetailsCubit>()
                                      ..fetchParticularBookingDetails(
                                          token: state.successModel.token!,
                                          accommodation:
                                              booked.room!.accommodation!,
                                          id: booked.id!.toString());
                                    // if(boo)
                                    String accommodationType =
                                        booked.room!.accommodation!.type!;
                                    var data = {
                                      "accommodation":
                                          booked.room!.accommodation,
                                      "id": booked.id
                                    };
                                    if (accommodationType == "rent_room") {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  RentalRoomBookingScreen(
                                                      data: data)));
                                    }
                                    if (accommodationType == "hostel") {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  HostelRoomBookingHistory(
                                                      data: data)));
                                    }
                                    if (accommodationType == "hotel") {
                                      bool has_tier =
                                          booked.room!.accommodation!.has_tier!;
                                      if (has_tier) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    HotelWithTierBookingHistory(
                                                        data: data)));
                                      }

                                      if (has_tier == false) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    HotelWithoutTierHistory(
                                                        data: data)));
                                      }
                                    }
                                  }
                                },
                                child: Card(
                                  shadowColor: Colors.transparent,
                                  clipBehavior: Clip
                                      .antiAlias, // Adds a smooth border radius effect to the image
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  margin: EdgeInsets.all(10),
                                  elevation: 5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Accommodation Image
                                      CachedNetworkImage(
                                        imageUrl:
                                            "${getIpWithoutSlash()}${booked.room!.accommodation!.image!}", // Construct the image URL
                                        height: 100,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Accommodation Name or Type
                                            Text(
                                              booked.room!.accommodation!
                                                      .name ??
                                                  'Accommodation', // Assuming there's a 'name' field
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            // User Name
                                            Text(
                                              'Booked by: ${booked.user!.full_name}',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            // Check-in and Check-out Dates
                                            Text(
                                              'Check-in: ${booked.check_in}', // Use your formatDate function
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            Text(
                                              'Check-out: ${booked.check_out}', // Use your formatDate function
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            SizedBox(height: 5),
                                            // Paid Amount
                                            Text(
                                              'Paid Amount: ${booked.paid_amount}',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green[700],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
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
          ),
        ),
      ),
    );
  }
}
