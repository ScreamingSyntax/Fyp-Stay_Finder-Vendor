import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stayfinder_vendor/constants/extensions.dart';
import 'package:stayfinder_vendor/data/repository/login_repository.dart';
import 'package:stayfinder_vendor/logic/cubits/update_hostel/update_hostel_cubit.dart';
import 'package:stayfinder_vendor/presentation/config/image_helper.dart';
import 'package:stayfinder_vendor/presentation/widgets/widgets_exports.dart';

import '../../../../../constants/ip.dart';
import '../../../../../data/api/api_exports.dart';
import '../../../../../data/model/model_exports.dart';
import '../../../../../logic/blocs/accommodation_addition/accommodation_addition_bloc.dart';
import '../../../../../logic/blocs/bloc_exports.dart';
import '../../../../../logic/blocs/hostel_addition/hostel_addition_bloc.dart';
import '../../../../../logic/cubits/cubit_exports.dart';
import '../../../../../logic/cubits/fetch_hostel/fetch_hostel_details_cubit.dart';
import '../../../../../logic/cubits/room_addition/room_addition_cubit.dart';
import '../../../../../logic/cubits/update_rental_accommodation/update_accommodation_image_cubit.dart';
import 'hostel_room_view.dart';

class HostelViewScreen extends StatelessWidget {
  final Object arguments;

  const HostelViewScreen({super.key, required this.arguments});
  Future<void> callHostelApis(
      Map<dynamic, dynamic> args, BuildContext context) async {
    String token = args['token'];
    int accommodationID = args['id'];
    context.read<FetchHostelDetailsCubit>().fetchHostelAccommodation(
        accommodationId: accommodationID, token: token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe5e5e5),
      body: BlocBuilder<FetchHostelDetailsCubit, FetchHostelDetailsState>(
        builder: (context, state) {
          if (state is FetchHostelDetailLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is FetchHostelDetailError) {
            return HostelRetryScreen(
              state: state,
              data: arguments as Map,
            );
          }
          if (state is FetchHostelDetailSuccess) {
            var loginState = context.read<LoginBloc>().state;
            if (loginState is LoginLoaded) {
              return HostelSuccessScreen(
                data: arguments as Map,
                fetchHostelDetailSuccess: state,
                token: loginState.successModel.token!,
              );
            }
          }
          return SizedBox();
        },
      ),
    );
  }
}

class HostelSuccessScreen extends StatelessWidget {
  MapController _controller = new MapController();
  final String token;
  final Map data;
  final FetchHostelDetailSuccess fetchHostelDetailSuccess;
  HostelSuccessScreen({
    required this.fetchHostelDetailSuccess,
    super.key,
    required this.data,
    required this.token,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ImageHelperCubit()..imageHelperAccess(imageHelper: ImageHelper()),
        ),
      ],
      child: Builder(builder: (context) {
        return MultiBlocListener(
          listeners: [
            BlocListener<UpdateHostelCubit, UpdateHostelState>(
              listener: (context, state) {
                // var state
                // TODO: implement listener
                if (state is UpdateHostelLoading) {
                  customScaffold(
                      context: context,
                      title: "Updating..",
                      message: "Please wait, This is being updated",
                      contentType: ContentType.warning);
                }
                if (state is UpdateHostelSuccessState) {
                  context.read<FetchHostelDetailsCubit>()
                    ..fetchHostelAccommodation(
                        accommodationId: data['id'], token: token);
                  customScaffold(
                      context: context,
                      title: "Updated",
                      message: state.message,
                      contentType: ContentType.success);
                }
                if (state is UpdateHostelErrorState) {
                  customScaffold(
                      context: context,
                      title: "Error..",
                      message: state.message,
                      contentType: ContentType.failure);
                }
              },
            ),
            BlocListener<ResumbitAccommodationVerificationCubit,
                ResumbitAccommodationVerificationState>(
              listener: (context, state) {
                if (state is ResubmitAccommodationVerificationSuccess) {
                  customScaffold(
                      context: context,
                      title: "Success",
                      message: state.message,
                      contentType: ContentType.success);
                  context.read<FetchHostelDetailsCubit>()
                    ..fetchHostelAccommodation(
                        accommodationId: data['id'], token: token);
                }
                if (state is ResubmitAccommodationVerificationError) {
                  customScaffold(
                      context: context,
                      title: "Error",
                      message: state.message,
                      contentType: ContentType.failure);
                }
              },
            ),
          ],
          child: RefreshIndicator(
            onRefresh: () async {
              context.read<FetchHostelDetailsCubit>()
                ..fetchHostelAccommodation(
                    token: token, accommodationId: data['id']);
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 270,
                    child: Stack(
                      children: [
                        CustomMainImageVIew(
                            imageLink:
                                "${getIpWithoutSlash()}${fetchHostelDetailSuccess.accommodation!.image!}"),
                        if (fetchHostelDetailSuccess
                                .accommodation!.is_pending! ==
                            false)
                          Positioned(
                              right: 20,
                              top: 20,
                              child: EditDeleteButtonWidget(
                                controller: _controller,
                                accommodationId:
                                    fetchHostelDetailSuccess.accommodation!.id!,
                                latitude: double.tryParse(
                                        fetchHostelDetailSuccess
                                            .accommodation!.latitude!) ??
                                    0,
                                longitude: double.tryParse(
                                        fetchHostelDetailSuccess
                                            .accommodation!.longitude!) ??
                                    0,
                                deleteOnTap: () async {},
                                editOnTap: () async {
                                  var imageHelper = context
                                      .read<ImageHelperCubit>()
                                      .state
                                      .imageHelper!;
                                  final files = await imageHelper.pickImage();
                                  if (files.isNotEmpty) {
                                    final croppedFile = await imageHelper.crop(
                                        file: files.first,
                                        cropStyle: CropStyle.rectangle);
                                    print("This is cropped file ");
                                    if (croppedFile != null) {
                                      var loginState =
                                          context.read<LoginBloc>().state;
                                      print(
                                          "The file is ${File(croppedFile.path)}");
                                      File file = File(croppedFile.path);
                                      if (loginState is LoginLoaded &&
                                          fetchHostelDetailSuccess
                                                  .accommodation !=
                                              null) {
                                        context
                                            .read<UpdateHostelCubit>()
                                            .updateAccommodationImage(
                                                token: loginState
                                                    .successModel.token!,
                                                image: file,
                                                accommodationId: data['id']);
                                      }
                                    }
                                  }
                                },
                              )),
                        Positioned(
                            top: 80,
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
                                        .popUntil((_) => count++ >= 2);
                                  },
                                );
                              },
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            )),
                        Positioned(
                            left: 1,
                            bottom: -1,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (fetchHostelDetailSuccess
                                      .accommodation!.is_pending!)
                                    VerificationBadgeRentalRoom(
                                      w1: Icon(
                                        Icons.verified_outlined,
                                        color: Colors.white,
                                      ),
                                      w2: CustomPoppinsText(
                                        text: "Pending",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  if (fetchHostelDetailSuccess
                                      .accommodation!.is_verified!)
                                    VerificationBadgeRentalRoom(
                                      w1: Icon(
                                        Icons.verified,
                                        color: Colors.white,
                                      ),
                                      w2: CustomPoppinsText(
                                        text: "Verified",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  if (fetchHostelDetailSuccess
                                      .accommodation!.is_rejected!)
                                    VerificationBadgeRentalRoom(
                                      w1: Icon(
                                        Icons.cancel,
                                        color: Colors.white,
                                      ),
                                      w2: CustomPoppinsText(
                                        text: "Rejected",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                ],
                              ),
                            ))
                      ],
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
                              Expanded(
                                child: Column(
                                  children: [
                                    CustomPoppinsText(
                                        text: fetchHostelDetailSuccess
                                            .accommodation!.name!,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                    SizedBox(
                                      height: 15,
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
                                            text: fetchHostelDetailSuccess
                                                .accommodation!.admission_rate!
                                                .toString(),
                                            fontSize: 23,
                                            color: Color(0xff4c4c4c),
                                            fontWeight: FontWeight.w700),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // if (fetchHostelDetailSuccess
                              //         .accommodation!.is_rejected! ||
                              //     fetchHostelDetailSuccess
                              //         .accommodation!.is_verified!)
                              if (fetchHostelDetailSuccess
                                      .accommodation!.is_pending! ==
                                  false)
                                InkWell(
                                  onTap: () async {
                                    updateRentalAccommodation(
                                        accommodation: fetchHostelDetailSuccess
                                            .accommodation!,
                                        context: context);
                                    // roomDetailsUpdateSheet(beds: fetchHostelDetailSuccess.accommodation.)
                                    // updateRentalAccommodation(
                                    //     context: context,
                                    //     accommodation:
                                    //         state.accommodation);
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.red,
                                  ),
                                )
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
                                      "${fetchHostelDetailSuccess.accommodation!.city}, ${fetchHostelDetailSuccess.accommodation!.address}",
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
                                      text: fetchHostelDetailSuccess
                                          .accommodation!.number_of_washroom
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
                                      text: fetchHostelDetailSuccess
                                          .accommodation!.weekly_laundry_cycles
                                          .toString(),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                  // CustomVerifiedWidget(
                                  //     value: fetchHostelDetailSuccess
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
                                      value: fetchHostelDetailSuccess
                                          .accommodation!.parking_availability!)
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
                                      text: fetchHostelDetailSuccess
                                          .accommodation!.weekly_non_veg_meals
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
                                      text: fetchHostelDetailSuccess
                                          .accommodation!.meals_per_day
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
                  SizedBox(
                    height: 19,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: CustomReviewSection(
                      context: context,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Container(
                      // height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // ListTile(
                            //   onTap: () {},
                            //   dense: true,
                            //   leading:
                            //   trailing: InkWell(
                            //     onTap: () => Navigator.of(context).push(
                            //         MaterialPageRoute(
                            //             builder: (_) => HostelRoomView())),
                            //     child: Text(
                            //       "View Rooms >>",
                            //       style: TextStyle(
                            //           color: Colors.red,
                            //           fontWeight: FontWeight.w700),
                            //     ),
                            //   ),
                            // ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    height: 50,
                                    child: Row(
                                      children: [
                                        Row(
                                          // mainAxisAlignment: Main,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            CustomPoppinsText(
                                                text: "Rooms",
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400)
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      context.read<DropDownValueCubit>()
                                        ..instantiateDropDownValue(items: [
                                          "Average",
                                          "Excellent",
                                          "Adjustable"
                                        ]);
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (_) => HostelRoomView(
                                                    data: data,
                                                  )));
                                    },
                                    child: Text(
                                      "View Rooms >>",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.red,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                ListView.builder(
                                  padding: EdgeInsets.all(0),
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount:
                                      fetchHostelDetailSuccess.rooms!.length,
                                  itemBuilder: (context, index) {
                                    int room_id = fetchHostelDetailSuccess
                                        .rooms![index].id!;
                                    late String imageLink;
                                    fetchHostelDetailSuccess.images!.forEach(
                                      (element) {
                                        // print("The images are ");
                                        if (element.room == room_id) {
                                          print("It does exist");
                                          imageLink = element.images!;
                                        }
                                      },
                                    );
                                    print("The room id is ");
                                    return Container(
                                      padding: EdgeInsets.all(10),
                                      child: ListTile(
                                        leading: Container(
                                          height: 50,
                                          width: 50,
                                          child: CachedNetworkImage(
                                              imageBuilder:
                                                  (context, imageProvider) {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image:
                                                              imageProvider)),
                                                );
                                              },
                                              imageUrl:
                                                  "${getIpWithoutSlash()}${imageLink}"),
                                        ),
                                        title: Text(
                                          "Room 1",
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        subtitle: Text(
                                          "This room has ${fetchHostelDetailSuccess.rooms![index].seater_beds} seater beds",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 20),
                                  child: CustomPoppinsText(
                                    text: "View More ->",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff4c4c4c),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (fetchHostelDetailSuccess.accommodation!.is_rejected!)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: Column(
                        children: [
                          BlocBuilder<ResumbitAccommodationVerificationCubit,
                              ResumbitAccommodationVerificationState>(
                            builder: (context, resubState) {
                              if (resubState
                                  is ResubmitAccommodationVerificationLoading) {
                                return SizedBox();
                              }
                              return Column(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(10),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 2,
                                            blurRadius: 4,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white),
                                    child: Column(
                                      children: [
                                        Text(
                                          "Rejection Reason",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          fetchHostelDetailSuccess
                                              .accommodation!.rejected_message!,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  CustomMaterialButton(
                                      onPressed: () {
                                        var loginState =
                                            context.read<LoginBloc>().state;
                                        if (loginState is LoginLoaded) {
                                          context.read<
                                              ResumbitAccommodationVerificationCubit>()
                                            ..resubmitForVerification(
                                                token: loginState
                                                    .successModel.token!,
                                                accommodationId: data['id']);
                                        }
                                      },
                                      child: Text("Resubmit for Verification"),
                                      backgroundColor: Color(0xff29383f),
                                      textColor: Colors.white,
                                      height: 45),
                                ],
                              );
                            },
                          ),
                          SizedBox(
                            height: 30,
                          )
                        ],
                      ),
                    )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Future<dynamic> updateRentalAccommodation(
      {required BuildContext context, required Accommodation accommodation}) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => FormBloc()..add(InitEvent()),
            ),
            BlocProvider(
              create: (context) => AccommodationAdditionBloc()
                ..add(AccommodationAdditionUpdateHitEvent(
                    accommodation: accommodation)),
            ),
          ],
          child: Builder(builder: (context) {
            return Form(
              key: context.read<FormBloc>().state.formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    CustomPoppinsText(
                        text: "Update Accommodation",
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomFormField(
                        initialValue: accommodation.name,
                        inputFormatters: [
                          FilteringTextInputFormatter.singleLineFormatter
                        ],
                        validatior: (p0) {
                          if (p0!.isEmpty) {
                            return "Can't be null";
                          }
                          if (p0.length < 3) {
                            return "Can't have lesser than 3 character";
                          }
                          return null;
                        },
                        onChange: (p0) {
                          context.read<FormBloc>()
                            ..add(NameChangedEvent(
                                name: BlocFormItem(value: p0!)));
                        },
                        prefixIcon: Icon(
                          Boxicons.bx_hotel,
                          color: Color(0xff4C4C4C),
                        ),
                        labelText: "Name",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomFormField(
                        initialValue: accommodation.admission_rate.toString(),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validatior: (p0) {
                          if (p0!.isEmpty || p0 == Null) {
                            return "Admission Rate cannot be empty";
                          }
                          if (!(p0.isValidNumber)) {
                            return "Please enter a valid Number";
                          }
                          int p1 = int.parse(p0);
                          if (p1 <= 0) {
                            return "Please enter valid number";
                          }
                          if (p1 < 1000) {
                            return "Cannot be lesser than 1000";
                          }

                          return null;
                        },
                        onChange: (p0) {
                          context.read<FormBloc>()
                            ..add(RateChangedEvent(
                                rate: BlocFormItem(value: p0!)));
                        },
                        prefixIcon: Icon(
                          Icons.money_sharp,
                          color: Colors.green,
                        ),
                        labelText: "Admission Rate",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomFormField(
                                  initialValue: accommodation.number_of_washroom
                                      .toString(),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  labelText: "Washroom count",
                                  prefixIcon: Icon(
                                    FontAwesomeIcons.toilet,
                                    size: 14,
                                    color: Color(0xffFFAB1C),
                                  ),
                                  onChange: (p0) {
                                    context.read<FormBloc>()
                                      ..add(WashRoomCountChangedEvent(
                                          washRoomCount:
                                              BlocFormItem(value: p0!)));
                                  },
                                  validatior: (p0) {
                                    if (p0!.isEmpty || p0 == Null) {
                                      return "Washroom Count cannot be empty";
                                    }
                                    if (!(p0.isValidNumber)) {
                                      return "Please enter a valid Number";
                                    }
                                    int p1 = int.parse(p0);
                                    if (p1 <= 0) {
                                      return "Please enter valid number";
                                    }
                                    if (p1 >= 10) {
                                      return "Cannot be greater than 9";
                                    }
                                    return null;
                                  },
                                ),
                              )),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomFormField(
                              initialValue: accommodation.city,
                              onChange: (p0) {
                                context.read<FormBloc>()
                                  ..add(CityChangedEvent(
                                      city: BlocFormItem(value: p0!)));
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.singleLineFormatter
                              ],
                              // validatior: ,
                              validatior: (p0) {
                                if (p0!.isEmpty) {
                                  return "Can't be null";
                                }
                                if (p0.length < 3) {
                                  return "Can't have lesser than 3 characters ";
                                }
                                return null;
                              },
                              labelText: "City",
                              prefixIcon: Icon(
                                Icons.location_city,
                                color: Color(0xffFFAB1C),
                              ),
                            ),
                          )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomFormField(
                                  initialValue:
                                      accommodation.meals_per_day.toString(),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  labelText: "Meals / Day",
                                  prefixIcon: Icon(
                                    FontAwesomeIcons.bowlFood,
                                    size: 14,
                                    color: Colors.green,
                                  ),
                                  onChange: (p0) {
                                    print("This is ${p0} ");
                                    context.read<FormBloc>()
                                      ..add(MealsPerDayChangedEvent(
                                          mealsPerDay:
                                              BlocFormItem(value: p0!)));
                                  },
                                  validatior: (p0) {
                                    if (p0!.isEmpty || p0 == Null) {
                                      return "Meals Count cannot be empty";
                                    }
                                    if (!(p0.isValidNumber)) {
                                      return "Please enter a valid Number";
                                    }
                                    int p1 = int.parse(p0);
                                    if (p1 <= 0) {
                                      "Please enter valid number";
                                    }
                                    if (p1 >= 10) {
                                      "Cannot be greater than 9";
                                    }
                                    return null;
                                  },
                                ),
                              )),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomFormField(
                              initialValue: accommodation.weekly_laundry_cycles
                                  .toString(),
                              onChange: (p0) {
                                context.read<FormBloc>()
                                  ..add(WeeklyLaundaryCyclesChangedEvent(
                                      weeklyLaundaryCycles:
                                          BlocFormItem(value: p0!)));
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.singleLineFormatter
                              ],
                              // validatior: ,
                              validatior: (p0) {
                                if (p0!.isEmpty || p0 == Null) {
                                  return "Weekly Laundary Cycle cannot be empty";
                                }
                                if (!(p0.isValidNumber)) {
                                  return "Please enter a valid Number";
                                }
                                int p1 = int.parse(p0);
                                if (p1 >= 8) {
                                  return "Cannot be greater than 7";
                                }
                                return null;
                              },
                              labelText: "Laundry Cycles",
                              prefixIcon: Icon(
                                Boxicons.bxs_washer,
                                color: Colors.green,
                              ),
                            ),
                          )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: CustomFormField(
                        initialValue: accommodation.address,
                        validatior: (p0) {
                          if (p0!.isEmpty) {
                            return "Can't be null";
                          }
                          if (p0.length < 3) {
                            return "Can't have lesser than 3 characters ";
                          }
                          return null;
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.singleLineFormatter
                        ],
                        onChange: (p0) {
                          context.read<FormBloc>()
                            ..add(AddressChangedEvent(
                                address: BlocFormItem(value: p0!)));
                        },
                        prefixIcon: Icon(
                          Icons.place,
                          color: Color(0xff4C4C4C),
                        ),
                        labelText: "Address",
                      ),
                    ),
                    BlocBuilder<AccommodationAdditionBloc,
                        AccommodationAdditionState>(
                      builder: (context, accommodationState) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CustomFormField(
                                      initialValue: accommodation
                                          .weekly_non_veg_meals
                                          .toString(),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      labelText: "Non-Veg / Week",
                                      prefixIcon: Icon(
                                        Boxicons.bxs_food_menu,
                                        size: 14,
                                        color: Colors.red,
                                      ),
                                      onChange: (p0) {
                                        context.read<FormBloc>()
                                          ..add(NonMealsPerDayChangedEvent(
                                              nonVegMealsPerDay:
                                                  BlocFormItem(value: p0!)));
                                      },
                                      validatior: (p0) {
                                        if (p0!.isEmpty || p0 == Null) {
                                          return "Non Veg Meals Count cannot be empty";
                                        }
                                        if (!(p0.isValidNumber)) {
                                          return "Please enter a valid Number";
                                        }
                                        int p1 = int.parse(p0);
                                        if (p1 >= 8) {
                                          return "Cannot be greater than 7";
                                        }
                                        return null;
                                      },
                                    ),
                                  )),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2.6,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CustomCheckBoxTile(
                                      title: "Parking",
                                      onChanged: (p0) {
                                        // accommodationState.accommodation!
                                        //     .copyWith(parking_availability: p0);
                                        context
                                            .read<AccommodationAdditionBloc>()
                                          ..add(AccommodationAdditionUpdateHitEvent(
                                              accommodation: accommodationState
                                                  .accommodation!
                                                  .copyWith(
                                                      parking_availability:
                                                          p0)));
                                      },
                                      value: accommodationState.accommodation !=
                                              null
                                          ? accommodationState.accommodation!
                                              .parking_availability!
                                          : false,
                                      icon: Boxicons.bxs_parking),
                                ),
                              ),
                              // SizedBox(
                              //   width: MediaQuery.of(context).size.width / 2,
                              //   child: Padding(
                              //     padding: const EdgeInsets.all(8.0),
                              //     child: CustomCheckBoxTile(
                              //         title: "Trash Dispose",
                              //         onChanged: (p0) {
                              //           if (accommodationState.accommodation !=
                              //               null) {
                              //             context
                              //                 .read<AccommodationAdditionBloc>()
                              //               ..add(AccommodationAdditionUpdateHitEvent(
                              //                   accommodation: accommodationState
                              //                       .accommodation!
                              //                       .copyWith(
                              //                           trash_dispose_availability:
                              //                               p0)));
                              //           }
                              //         },
                              //         value: accommodationState.accommodation !=
                              //                 null
                              //             ? accommodationState.accommodation!
                              //                 .trash_dispose_availability!
                              //             : false,
                              //         icon: Boxicons.bxs_parking),
                              //   ),
                              // ),
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // CustomFormField(inputFormatters: [],)
                          BlocBuilder<FormBloc, FormsState>(
                            builder: (context, formState) {
                              return SizedBox(
                                width: MediaQuery.of(context).size.width / 2.6,
                                child: CustomMaterialButton(
                                    onPressed: () {
                                      if (formState.formKey!.currentState!
                                          .validate()) {
                                        Map<String, dynamic> itemsFromState = {
                                          'id': data['id'],
                                          'name': formState.name.value != ''
                                              ? formState.name.value
                                              : accommodation.name,
                                          'number_of_washroom': formState
                                                      .washRoomCount.value !=
                                                  ''
                                              ? formState.washRoomCount.value
                                              : accommodation
                                                  .number_of_washroom,
                                          'city': formState.city.value != ''
                                              ? formState.city.value
                                              : accommodation.city,
                                          'address':
                                              formState.address.value != ''
                                                  ? formState.address.value
                                                  : accommodation.address,
                                          'parking_availability': context
                                              .read<AccommodationAdditionBloc>()
                                              .state
                                              .accommodation!
                                              .parking_availability!,
                                          'meals_per_day':
                                              formState.mealsPerDay.value != ''
                                                  ? formState.mealsPerDay.value
                                                  : accommodation.meals_per_day,
                                          'weekly_non_veg_meals': formState
                                                      .nonVegMealsPerDay
                                                      .value !=
                                                  ''
                                              ? formState
                                                  .nonVegMealsPerDay.value
                                              : accommodation
                                                  .weekly_non_veg_meals
                                                  .toString(),
                                          'weekly_laundry_cycles': formState
                                                      .weeklyLaundaryCycles
                                                      .value !=
                                                  ''
                                              ? formState
                                                  .weeklyLaundaryCycles.value
                                              : accommodation
                                                  .weekly_laundry_cycles,
                                          'admission_rate':
                                              formState.rate.value != ''
                                                  ? formState.rate.value
                                                  : accommodation
                                                      .admission_rate,
                                        };
                                        print(
                                            "This is the state ${itemsFromState}");
                                        print(
                                            "This is the state ${formState.mealsPerDay.value}");

                                        var loginState =
                                            context.read<LoginBloc>().state;
                                        if (loginState is LoginLoaded) {
                                          context.read<UpdateHostelCubit>()
                                            ..updateAccommodationDetail(
                                                token: token,
                                                accommodation: itemsFromState);
                                          // context
                                          //     .read<
                                          //         UpdateRentalAccommodationCubit>()
                                          //     .updateAccommodationDetail(
                                          //         token: loginState
                                          //             .successModel.token!,
                                          //         accommodations:
                                          //             itemsFromState);
                                          Navigator.pop(context);
                                        }
                                      }
                                    },
                                    child: Text("Update"),
                                    backgroundColor: Color(0xff4C4C4C),
                                    textColor: Colors.white,
                                    height: 45),
                              );
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2.6,
                            child: CustomMaterialButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Cancel"),
                                backgroundColor:
                                    Color(0xff4C4C4C).withOpacity(0.5),
                                textColor: Colors.white,
                                height: 45),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

class HostelRetryScreen extends StatelessWidget {
  final FetchHostelDetailError state;
  final Map data;
  const HostelRetryScreen({super.key, required this.state, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(state.message.toString()),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 120.0),
          child: CustomMaterialButton(
              onPressed: () {
                context.read<FetchHostelDetailsCubit>()
                  ..fetchHostelAccommodation(
                      token: data['token'], accommodationId: data['id']);
              },
              child: Text("Retry"),
              backgroundColor: Color(0xff29383F).withOpacity(0.7),
              textColor: Colors.white,
              height: 45),
        )
      ],
    );
  }
}
