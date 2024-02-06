import 'package:stayfinder_vendor/constants/constants_exports.dart';
import 'package:stayfinder_vendor/data/model/booked_model.dart';
import 'package:stayfinder_vendor/logic/blocs/bloc_exports.dart';
import 'package:stayfinder_vendor/presentation/widgets/widgets_exports.dart';
import 'package:intl/intl.dart';
import '../../data/model/model_exports.dart';
import '../../logic/cubits/cubit_exports.dart';

class BookingScreen extends StatelessWidget {
  void fetchRequests(BuildContext context, String token) {
    context.read<FetchBookingRequestCubit>().fetchBookingRequests(token: token);
  }

  @override
  Widget build(BuildContext context) {
    String token = "";
    var state = context.read<LoginBloc>().state;
    if (state is LoginLoaded) {
      token = state.successModel.token!;
    }
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child:
              BlocBuilder<FetchBookingRequestCubit, FetchBookingRequestState>(
            builder: (context, state) {
              if (state is FetchBookingRequestInitial) {
                fetchRequests(context, token);
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
                              fetchRequests(context, token);
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
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomPoppinsText(
                          text: "Current Bookings",
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.bookingRequests.length,
                        itemBuilder: (BuildContext context, int index) {
                          BookingRequest request = state.bookingRequests[index];
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
                                    imageBuilder: (context, imageProvider) =>
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
                                ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: CachedNetworkImageProvider(
                                      "${getIpWithoutSlash()}${request.user!.image}",
                                    ),
                                    onBackgroundImageError: (error,
                                            stackTrace) =>
                                        Image.asset('assets/logos/logo.png'),
                                  ),
                                  title: Text(
                                      request.user?.full_name ?? 'Unknown User',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12)),
                                  subtitle: Text(
                                    'Requested on: ${formattedDate}\nStatus: ${request.status}',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  trailing: Icon(
                                      request.status == "pending"
                                          ? Icons.hourglass_empty
                                          : Icons.check_circle,
                                      color: request.status == "pending"
                                          ? Colors.orange
                                          : Colors.green),
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
                          text: "Requests",
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                      SizedBox(
                        height: 20,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.bookedCustomers.length,
                        itemBuilder: (BuildContext context, int index) {
                          Booked booked = state.bookedCustomers[index];

                          return Card(
                            clipBehavior: Clip
                                .antiAlias, // Adds a smooth border radius effect to the image
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            margin: EdgeInsets.all(10),
                            elevation: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                        booked.room!.accommodation!.name ??
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
                          );
                        },
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
    );
  }
}
