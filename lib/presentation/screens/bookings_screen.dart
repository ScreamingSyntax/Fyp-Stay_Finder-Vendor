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

class BookingScreen extends StatefulWidget {
  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffECEFF1),
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
                if (state is FetchBookingRequestLoading) {
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Loading"),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 60,
                          decoration: BoxDecoration(
                              color: Color(0xff455A64),
                              borderRadius: BorderRadius.circular(10)),
                          child: TabBar(
                            indicatorColor: Color(0xff64FFDA),
                            // indicator: BoxDecoration(),
                            labelColor: Colors.white,
                            dividerColor: Color(0xff64FFDA),
                            unselectedLabelColor: Color(0xffB0BEC5),
                            controller: _tabController,

                            tabs: [
                              Tab(text: "Current Bookings"),
                              Tab(text: "Requests"),
                              Tab(text: "Past Bookings"),
                            ],
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              _buildCurrentBookings(state: state),
                              _buildBookingRequests(state: state),
                              _buildPastBookings(
                                state: state,
                              ) // Your method to build Past Bookings
                            ]
                                .map((e) => RefreshIndicator(
                                    onRefresh: () async {
                                      var state =
                                          context.read<LoginBloc>().state;
                                      if (state is LoginLoaded) {
                                        context.read<FetchBookingRequestCubit>()
                                          ..fetchBookingRequests(
                                              token: state.successModel.token!);
                                      }
                                    },
                                    child: SingleChildScrollView(
                                        physics:
                                            AlwaysScrollableScrollPhysics(),
                                        child: e)))
                                .toList(),
                          ),
                        ),
                      ],
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

class _buildPastBookings extends StatelessWidget {
  final FetchBookingRequestSuccesss state;
  const _buildPastBookings({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (state.pastBooking.length == 0)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                CustomPoppinsText(
                    text: "No Pasts Booking",
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ],
            ),
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
            return CurrentBookingsCard(booked: booked);
          },
        ),
      ],
    );
  }
}

class _buildBookingRequests extends StatelessWidget {
  final FetchBookingRequestSuccesss state;
  const _buildBookingRequests({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        if (state.bookingRequests.length == 0)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                CustomPoppinsText(
                    text: "No Requests yet",
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ],
            ),
          ),
        // print("The length is  ${state.bookingRequests.length}");

        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: state.bookingRequests.length,
          itemBuilder: (BuildContext context, int index) {
            BookingRequest request = state.bookingRequests[index];
            DateTime parsedDate = DateFormat("yyyy-MM-ddTHH:mm:ss.S")
                .parse(request.requested_on!, true)
                .toLocal();
            // Format the DateTime object into "YYYY-MM-DD"
            String formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  RequestsCard(request: request, formattedDate: formattedDate),
            );
          },
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class _buildCurrentBookings extends StatelessWidget {
  final FetchBookingRequestSuccesss state;

  const _buildCurrentBookings({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        if (state.bookedCustomers.length == 0)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                CustomPoppinsText(
                    text: "No Current Booking",
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ],
            ),
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
            return CurrentBookingsCard(booked: booked);
          },
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

// class PastsBookingCard extends StatelessWidget {
//   const PastsBookingCard({
//     super.key,
//     required this.booked,
//   });

//   final Booked booked;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         var state = context.read<LoginBloc>().state;
//         if (state is LoginLoaded) {
//           print("The accommodation is ${booked.room!.accommodation}");
//           context.read<FetchParticularBookingDetailsCubit>()
//             ..fetchParticularBookingDetails(
//                 token: state.successModel.token!,
//                 accommodation: booked.room!.accommodation!,
//                 id: booked.id!.toString());
//           // if(boo)
//           String accommodationType = booked.room!.accommodation!.type!;
//           var data = {
//             "accommodation": booked.room!.accommodation,
//             "id": booked.id
//           };
//           if (accommodationType == "rent_room") {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (_) => RentalRoomBookingScreen(data: data)));
//           }
//           if (accommodationType == "hostel") {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (_) => HostelRoomBookingHistory(data: data)));
//           }
//           if (accommodationType == "hotel") {
//             bool has_tier = booked.room!.accommodation!.has_tier!;
//             if (has_tier) {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (_) => HotelWithTierBookingHistory(data: data)));
//             }

//             if (has_tier == false) {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (_) => HotelWithoutTierHistory(data: data)));
//             }
//           }
//         }
//       },
//       child: Card(
//         shadowColor: Colors.transparent,
//         clipBehavior:
//             Clip.antiAlias, // Adds a smooth border radius effect to the image
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         margin: EdgeInsets.all(10),
//         elevation: 5,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Accommodation Image
//             CachedNetworkImage(
//               imageUrl:
//                   "${getIpWithoutSlash()}${booked.room!.accommodation!.image!}", // Construct the image URL
//               height: 100,
//               width: double.infinity,
//               fit: BoxFit.cover,
//               placeholder: (context, url) => CircularProgressIndicator(),
//               errorWidget: (context, url, error) => Icon(Icons.error),
//             ),
//             Padding(
//               padding: EdgeInsets.all(10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Accommodation Name or Type
//                   Text(
//                     booked.room!.accommodation!.name ??
//                         'Accommodation', // Assuming there's a 'name' field
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 5),
//                   // User Name
//                   Text(
//                     'Booked by: ${booked.user!.full_name}',
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                   SizedBox(height: 5),
//                   // Check-in and Check-out Dates
//                   Text(
//                     'Check-in: ${booked.check_in}', // Use your formatDate function
//                     style: TextStyle(fontSize: 12),
//                   ),
//                   Text(
//                     'Check-out: ${booked.check_out}', // Use your formatDate function
//                     style: TextStyle(fontSize: 12),
//                   ),
//                   SizedBox(height: 5),
//                   // Paid Amount
//                   Text(
//                     'Paid Amount: ${booked.paid_amount}',
//                     style: TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.green[700],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class CurrentBookingsCard extends StatelessWidget {
  final Booked booked;

  const CurrentBookingsCard({Key? key, required this.booked}) : super(key: key);

  void _onCardTap(BuildContext context) {
    var loginState = context.read<LoginBloc>().state;
    if (loginState is LoginLoaded) {
      var fetchCubit = context.read<FetchParticularBookingDetailsCubit>();
      fetchCubit.fetchParticularBookingDetails(
        token: loginState.successModel.token!,
        accommodation: booked.room!.accommodation!,
        id: booked.id!.toString(),
      );

      String accommodationType = booked.room!.accommodation!.type!;
      var data = {"accommodation": booked.room!.accommodation, "id": booked.id};

      switch (accommodationType) {
        case "rent_room":
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => RentalRoomBookingScreen(data: data)));
          break;
        case "hostel":
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => HostelRoomBookingHistory(data: data)));
          break;
        case "hotel":
          bool hasTier = booked.room!.accommodation!.has_tier!;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => hasTier
                  ? HotelWithTierBookingHistory(data: data)
                  : HotelWithoutTierHistory(data: data),
            ),
          );
          break;
        default:
          // Handle default or unknown types
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 0,
      color: Color(0xffFFFFFF),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xffE0E0E0),
            ),
            borderRadius: BorderRadius.circular(15)),
        height: 200,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CachedNetworkImage(
                      imageUrl:
                          "${getIpWithoutSlash()}${booked.room!.accommodation!.image!}",
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      child: Text(
                        booked.room!.accommodation!.name ?? 'Accommodation',
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            size: 16,
                            // color: Color(0xff64FFDA),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Check-in: ${booked.check_in}',
                            style: const TextStyle(
                                fontSize: 12, color: Color(0xff212121)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today_outlined, size: 16),
                          const SizedBox(width: 10),
                          Text('Check-out: ${booked.check_out}',
                              style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                  TextButton.icon(
                    onPressed: () {
                      _onCardTap(context);
                    },
                    icon: const Icon(Icons.info_outline, color: Colors.blue),
                    label: const Text('Details',
                        style: TextStyle(color: Colors.blue)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class CurrentBookingsCard extends StatelessWidget {
//   final Booked booked;

//   const CurrentBookingsCard({Key? key, required this.booked}) : super(key: key);

//   void _navigateToDetailScreen(BuildContext context) {
//     var loginState = context.read<LoginBloc>().state;
//     if (loginState is LoginLoaded) {
//       var fetchCubit = context.read<FetchParticularBookingDetailsCubit>();
//       fetchCubit.fetchParticularBookingDetails(
//         token: loginState.successModel.token!,
//         accommodation: booked.room!.accommodation!,
//         id: booked.id!.toString(),
//       );

//       String accommodationType = booked.room!.accommodation!.type!;
//       var data = {"accommodation": booked.room!.accommodation, "id": booked.id};

//       switch (accommodationType) {
//         case "rent_room":
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (_) => RentalRoomBookingScreen(data: data)));
//           break;
//         case "hostel":
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (_) => HostelRoomBookingHistory(data: data)));
//           break;
//         case "hotel":
//           bool hasTier = booked.room!.accommodation!.has_tier!;
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (_) => hasTier
//                   ? HotelWithTierBookingHistory(data: data)
//                   : HotelWithoutTierHistory(data: data),
//             ),
//           );
//           break;
//         default:
//           // Handle default or unknown types
//           break;
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () => _navigateToDetailScreen(context),
//       child: Card(
//         shadowColor: Colors.blueGrey[50],
//         clipBehavior: Clip.antiAlias,
//         shape:
//             RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
//         margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//         elevation: 6,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             CachedNetworkImage(
//               imageUrl:
//                   "${getIpWithoutSlash()}${booked.room!.accommodation!.image!}",
//               height: 120,
//               width: double.infinity,
//               fit: BoxFit.cover,
//               placeholder: (context, url) => const CircularProgressIndicator(),
//               errorWidget: (context, url, error) =>
//                   const Icon(Icons.error_outline),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(12),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     booked.room!.accommodation!.name ?? 'Accommodation',
//                     style: const TextStyle(
//                         fontSize: 14, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 8),
//                   Row(
//                     children: [
//                       Icon(Icons.person_outline,
//                           color: Colors.grey[600], size: 16),
//                       const SizedBox(width: 4),
//                       Text('Booked by: ${booked.user!.full_name}',
//                           style:
//                               TextStyle(fontSize: 12, color: Colors.grey[600])),
//                     ],
//                   ),
//                   const SizedBox(height: 8),
//                   Text('Check-in: ${booked.check_in}',
//                       style: const TextStyle(fontSize: 12)),
//                   Text('Check-out: ${booked.check_out}',
//                       style: const TextStyle(fontSize: 12)),
//                   const SizedBox(height: 8),
//                   Text(
//                     'Paid Amount: ${booked.paid_amount}',
//                     style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.green[700]),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// class CurrentBookingsCard extends StatelessWidget {
//   const CurrentBookingsCard({
//     super.key,
//     required this.booked,
//   });

//   final Booked booked;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         var state = context.read<LoginBloc>().state;
//         if (state is LoginLoaded) {
//           context.read<FetchParticularBookingDetailsCubit>()
//             ..fetchParticularBookingDetails(
//                 token: state.successModel.token!,
//                 accommodation: booked.room!.accommodation!,
//                 id: booked.id!.toString());
//           // if(boo)
//           String accommodationType = booked.room!.accommodation!.type!;
//           var data = {
//             "accommodation": booked.room!.accommodation,
//             "id": booked.id
//           };
//           if (accommodationType == "rent_room") {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (_) => RentalRoomBookingScreen(data: data)));
//           }
//           if (accommodationType == "hostel") {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (_) => HostelRoomBookingHistory(data: data)));
//           }
//           if (accommodationType == "hotel") {
//             bool has_tier = booked.room!.accommodation!.has_tier!;
//             if (has_tier) {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (_) => HotelWithTierBookingHistory(data: data)));
//             }

//             if (has_tier == false) {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (_) => HotelWithoutTierHistory(data: data)));
//             }
//           }
//         }
//       },
//       child: Card(
//         shadowColor: Colors.transparent,
//         clipBehavior:
//             Clip.antiAlias, // Adds a smooth border radius effect to the image
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         margin: EdgeInsets.all(10),
//         elevation: 5,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Accommodation Image
//             CachedNetworkImage(
//               imageUrl:
//                   "${getIpWithoutSlash()}${booked.room!.accommodation!.image!}", // Construct the image URL
//               height: 100,
//               width: double.infinity,
//               fit: BoxFit.cover,
//               placeholder: (context, url) => CircularProgressIndicator(),
//               errorWidget: (context, url, error) => Icon(Icons.error),
//             ),
//             Padding(
//               padding: EdgeInsets.all(10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Accommodation Name or Type
//                   Text(
//                     booked.room!.accommodation!.name ??
//                         'Accommodation', // Assuming there's a 'name' field
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 5),
//                   // User Name
//                   Text(
//                     'Booked by: ${booked.user!.full_name}',
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                   SizedBox(height: 5),
//                   // Check-in and Check-out Dates
//                   Text(
//                     'Check-in: ${booked.check_in}', // Use your formatDate function
//                     style: TextStyle(fontSize: 12),
//                   ),
//                   Text(
//                     'Check-out: ${booked.check_out}', // Use your formatDate function
//                     style: TextStyle(fontSize: 12),
//                   ),
//                   SizedBox(height: 5),
//                   // Paid Amount
//                   Text(
//                     'Paid Amount: ${booked.paid_amount}',
//                     style: TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.green[700],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class RequestsCard extends StatelessWidget {
//   const RequestsCard({
//     super.key,
//     required this.request,
//     required this.formattedDate,
//   });

//   final BookingRequest request;
//   final String formattedDate;

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       shadowColor: Colors.transparent,
//       margin: EdgeInsets.all(8.0),
//       elevation: 5,
//       child: Column(
//         children: [
//           Container(
//             child: CachedNetworkImage(
//               imageBuilder: (context, imageProvider) => Container(
//                 width: double.infinity,
//                 height: 100,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(5),
//                     topRight: Radius.circular(5),
//                   ),
//                   image: DecorationImage(
//                     alignment: Alignment.center,
//                     image: imageProvider,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               imageUrl:
//                   "${getIpWithoutSlash()}${request.room!.accommodation!.image!}",
//               height: 100,
//               fit: BoxFit.cover,
//               alignment: Alignment.center,
//               placeholder: (context, url) => CircularProgressIndicator(),
//               errorWidget: (context, url, error) => Icon(Icons.error),
//             ),
//           ),
//           Column(
//             children: [
//               ListTile(
//                 leading: CircleAvatar(
//                   backgroundImage: CachedNetworkImageProvider(
//                     "${getIpWithoutSlash()}${request.user!.image}",
//                   ),
//                   onBackgroundImageError: (error, stackTrace) =>
//                       Image.asset('assets/logos/logo.png'),
//                 ),
//                 title: Text(request.user?.full_name ?? 'Unknown User',
//                     style:
//                         TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
//                 subtitle: Text(
//                   'Requested on: ${formattedDate}\nStatus: ${request.status}',
//                   style: TextStyle(fontSize: 12),
//                 ),
//                 trailing: request.status == "rejected"
//                     ? Icon(
//                         Icons.close,
//                         color: Colors.red,
//                       )
//                     : Icon(
//                         request.status == "pending"
//                             ? Icons.hourglass_empty
//                             : Icons.check_circle,
//                         color: request.status == "pending"
//                             ? Colors.orange
//                             : Colors.green),
//               ),
//               if (request.status == "pending")
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     InkWell(
//                       onTap: () {
//                         showExitPopup(
//                             context: context,
//                             message: "Are you sure you want to confirm ?",
//                             title: "Confirmation",
//                             noBtnFunction: () => Navigator.pop(context),
//                             yesBtnFunction: () {
//                               var state = context.read<LoginBloc>().state;
//                               if (state is LoginLoaded) {
//                                 context.read<VerifyBookingRequestCubit>()
//                                   ..verifyBookingRequest(
//                                       verify: true,
//                                       token: state.successModel.token!,
//                                       roomId: request.room!.id!,
//                                       bookRequestId: request.id!);
//                                 Navigator.pop(context);
//                               }
//                             });
//                       },
//                       child: Container(
//                         padding: EdgeInsets.all(20),
//                         alignment: Alignment.center,
//                         width: MediaQuery.of(context).size.width / 3,
//                         decoration: BoxDecoration(
//                             // color: Colors.green,
//                             ),
//                         child: SizedBox(
//                           width: MediaQuery.of(context).size.width,
//                           child: Row(
//                             children: [
//                               CustomPoppinsText(
//                                   text: "Accept",
//                                   fontSize: 12,
//                                   color: Colors.blue,
//                                   fontWeight: FontWeight.w400),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               Icon(
//                                 Icons.verified,
//                                 color: Colors.blue,
//                                 size: 15,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () {
//                         showExitPopup(
//                             context: context,
//                             message: "Are you sure you want to confirm ?",
//                             title: "Confirmation",
//                             noBtnFunction: () => Navigator.pop(context),
//                             yesBtnFunction: () {
//                               var state = context.read<LoginBloc>().state;
//                               if (state is LoginLoaded) {
//                                 context.read<VerifyBookingRequestCubit>()
//                                   ..verifyBookingRequest(
//                                       verify: false,
//                                       token: state.successModel.token!,
//                                       roomId: request.room!.id!,
//                                       bookRequestId: request.id!);
//                                 Navigator.pop(context);
//                               }
//                             });
//                       },
//                       child: Container(
//                         padding: EdgeInsets.all(20),
//                         alignment: Alignment.center,
//                         width: MediaQuery.of(context).size.width / 3,
//                         decoration: BoxDecoration(
//                             // color: Colors.green,
//                             ),
//                         child: SizedBox(
//                           width: MediaQuery.of(context).size.width,
//                           child: Row(
//                             children: [
//                               CustomPoppinsText(
//                                   text: "Reject",
//                                   fontSize: 12,
//                                   color: Colors.red,
//                                   fontWeight: FontWeight.w400),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               Icon(
//                                 Icons.verified,
//                                 color: Colors.red,
//                                 size: 15,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
class RequestsCard extends StatelessWidget {
  const RequestsCard({
    super.key,
    required this.request,
    required this.formattedDate,
  });

  final BookingRequest request;
  final String formattedDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xffFFFFFF),
          border: Border.all(
            color: Color(0xffE0E0E0),
          )),
      // shadowColor: Colors.grey.withOpacity(0.5),
      // margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      // elevation: 8,
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: CachedNetworkImage(
              imageUrl:
                  "${getIpWithoutSlash()}${request.room!.accommodation!.image!}",
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
              alignment: Alignment.center,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error_outline),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(
                  "${getIpWithoutSlash()}${request.user!.image}",
                ),
                onBackgroundImageError: (error, stackTrace) =>
                    Image.asset('assets/logos/logo.png'),
              ),
              title: Text(
                request.user?.full_name ?? 'Unknown User',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              subtitle: request.room!.accommodation!.type == "hostel"
                  ? Text(
                      'Requested on: $formattedDate\nStatus: ${request.status}\nRoom: ${request.room!.seater_beds} seater beds',
                      style: TextStyle(fontSize: 12),
                    )
                  : Text(
                      'Requested on: $formattedDate\nStatus: ${request.status}',
                      style: TextStyle(fontSize: 12),
                    ),
              trailing: _getStatusIcon(request.status!),
            ),
          ),
          if (request.status == "pending") _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _getStatusIcon(String status) {
    IconData iconData;
    Color color;

    switch (status) {
      case "rejected":
        iconData = Icons.close;
        color = Colors.red;
        break;
      case "pending":
        iconData = Icons.hourglass_empty;
        color = Colors.orange;
        break;
      default: // assumed 'accepted'
        iconData = Icons.check_circle;
        color = Colors.green;
    }

    return Icon(iconData, color: color);
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildActionButton(
            BorderRadius.only(
              bottomLeft: Radius.circular(10),
            ),
            context,
            "Accept",
            Colors.green,
            true),
        _buildActionButton(
            BorderRadius.only(
              bottomRight: Radius.circular(10),
            ),
            context,
            "Reject",
            Colors.red,
            false),
      ],
    );
  }

  Widget _buildActionButton(BorderRadius radius, BuildContext context,
      String text, Color color, bool verify) {
    return InkWell(
      onTap: () => _handleAction(context, verify),
      child: Container(
        height: 40,
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width / 2.37,
        // padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        decoration: BoxDecoration(color: color, borderRadius: radius
            // borderRadius: BorderRadius.circular(20),
            ),
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
    );
  }

  void _handleAction(BuildContext context, bool verify) {
    // Implement your action handling logic here.
    // This is just a placeholder function.
    if (verify == true) {
      showExitPopup(
          context: context,
          message: "Are you sure you want to confirm ?",
          title: "Confirmation",
          noBtnFunction: () => Navigator.pop(context),
          yesBtnFunction: () {
            var state = context.read<LoginBloc>().state;
            if (state is LoginLoaded) {
              context.read<VerifyBookingRequestCubit>()
                ..verifyBookingRequest(
                    verify: true,
                    token: state.successModel.token!,
                    roomId: request.room!.id!,
                    bookRequestId: request.id!);
              Navigator.pop(context);
            }
          });
    }
    if (verify == false) {
      showExitPopup(
          context: context,
          message: "Are you sure you want to confirm ?",
          title: "Confirmation",
          noBtnFunction: () => Navigator.pop(context),
          yesBtnFunction: () {
            var state = context.read<LoginBloc>().state;
            if (state is LoginLoaded) {
              context.read<VerifyBookingRequestCubit>()
                ..verifyBookingRequest(
                    verify: false,
                    token: state.successModel.token!,
                    roomId: request.room!.id!,
                    bookRequestId: request.id!);
              Navigator.pop(context);
            }
          });
    }
  }
}

class CurrentBookingsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Your logic for current bookings
    return BlocBuilder<FetchBookingRequestCubit, FetchBookingRequestState>(
      builder: (context, state) {
        // Implement your current bookings UI here
        return Container(); // Placeholder for your current bookings UI
      },
    );
  }
}

class BookingRequestsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Your logic for booking requests
    return BlocBuilder<FetchBookingRequestCubit, FetchBookingRequestState>(
      builder: (context, state) {
        // Implement your booking requests UI here
        return Container(); // Placeholder for your booking requests UI
      },
    );
  }
}

class PastBookingsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Your logic for past bookings
    return BlocBuilder<FetchBookingRequestCubit, FetchBookingRequestState>(
      builder: (context, state) {
        // Implement your past bookings UI here
        return Container(); // Placeholder for your past bookings UI
      },
    );
  }
}
