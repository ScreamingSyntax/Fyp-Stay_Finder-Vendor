// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stayfinder_vendor/constants/constants_exports.dart';
import 'package:stayfinder_vendor/constants/ip.dart';
import 'package:stayfinder_vendor/data/api/api_exports.dart';
import 'package:stayfinder_vendor/data/model/model_exports.dart';
import 'package:stayfinder_vendor/logic/blocs/accommodation_addition/accommodation_addition_bloc.dart';
import 'package:stayfinder_vendor/logic/blocs/bloc_exports.dart';
import 'package:stayfinder_vendor/logic/cubits/fetch_hostel/fetch_hostel_details_cubit.dart';
import 'package:stayfinder_vendor/logic/cubits/fetch_hotel_without_tier/fetch_hotel_without_tier_cubit.dart';
import 'package:stayfinder_vendor/logic/cubits/update_hotel_without_tier/update_hotel_without_tier_cubit.dart';
import 'package:stayfinder_vendor/presentation/config/image_helper.dart';
import 'package:stayfinder_vendor/presentation/widgets/widgets_exports.dart';

import '../../../../../logic/cubits/cubit_exports.dart';
import 'hotel_without_tiers_room_view.dart';

class HotelWithoutTierView extends StatelessWidget {
  Map data;

  HotelWithoutTierView({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ImageHelperCubit()..imageHelperAccess(imageHelper: ImageHelper()),
      child: Builder(builder: (context) {
        return BlocListener<UpdateHotelWithoutTierCubit,
            UpdateHotelWithoutTierState>(
          listener: (context, state) async {
            if (state is UpdateHotelWithoutTierSuccess) {
              await Future.delayed(Duration(seconds: 1));
              await callHotelWithoutTierApis(
                  context: context,
                  token: data['token'],
                  accommodationID: data['id']);
              customScaffold(
                  context: context,
                  title: "Success",
                  message: state.message,
                  contentType: ContentType.success);
            }
            if (state is UpdateHotelWithoutTierError) {
              // await callHotelWithoutTierApis(
              //     context: context,
              //     token: data['token'],
              //     accommodationID: data['id']);
              customScaffold(
                  context: context,
                  title: "Error",
                  message: state.message,
                  contentType: ContentType.failure);
            }
            if (state is UpdateHotelWithoutTierLoading) {
              // await callHotelWithoutTierApis(
              //     context: context,
              //     token: data['token'],
              //     accommodationID: data['id']);
              customScaffold(
                  context: context,
                  title: "Loading",
                  message: "Please Wait ...",
                  contentType: ContentType.warning);
            }
            // TODO: implement listener
          },
          child: Scaffold(
            backgroundColor: Color(0xffe5e5e5),
            body: BlocBuilder<FetchHotelWithoutTierCubit,
                FetchHotelWithoutTierState>(
              builder: (context, state) {
                if (state is FetchHotelWithoutTierError) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(state.message),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(50.0),
                          child: CustomMaterialButton(
                              onPressed: () {
                                context.read<FetchHotelWithoutTierCubit>()
                                  ..FetchHotel(
                                      accommodationId: data['id'],
                                      token: data['token']);
                              },
                              child: Text("Retr"),
                              backgroundColor: Color(0xff514f53),
                              textColor: Colors.white,
                              height: 45),
                        )
                      ],
                    ),
                  );
                }
                if (state is FetchHotelWithoutTierSuccess) {
                  return SafeArea(
                    child: HotelWithoutTierSuccessPage(
                      data: data,
                      fetchHostelWithoutTierSuccess: state,
                    ),
                  );
                }
                if (state is FetchHostelDetailLoading) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [CircularProgressIndicator()],
                    ),
                  );
                }
                return Builder(builder: (context) {
                  context.read<FetchHotelWithoutTierCubit>()
                    ..FetchHotel(
                        accommodationId: data['id'], token: data['token']);
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [CircularProgressIndicator()],
                    ),
                  );
                });
              },
            ),
          ),
        );
      }),
    );
  }
}

class HotelWithoutTierSuccessPage extends StatelessWidget {
  final Map data;
  final FetchHotelWithoutTierSuccess fetchHostelWithoutTierSuccess;
  const HotelWithoutTierSuccessPage({
    required this.fetchHostelWithoutTierSuccess,
    required this.data,
    super.key,
  });
  Future<dynamic> editAccommodaiton(
      {required Accommodation accommodation, required BuildContext context}) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AccommodationAdditionBloc()
                ..add(AccommodationAdditionHitEvent(
                    accommodation: accommodation)),
            ),
            BlocProvider(
              create: (context) => FormBloc()..add(InitEvent()),
            ),
          ],
          child: Builder(builder: (context) {
            return SingleChildScrollView(
              child: Form(
                key: context.read<FormBloc>().state.formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    CustomPoppinsText(
                        text: "Edit Accommodations",
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: CustomFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.singleLineFormatter
                        ],
                        prefixIcon: Icon(
                          Icons.location_city,
                          color: Colors.orange,
                        ),
                        keyboardType: TextInputType.name,
                        labelText: "Enter Hotel Name",
                        onTapOutside: (p) => FocusScope.of(context).unfocus(),
                        validatior: (p0) {
                          if (p0!.isEmpty) {
                            return "Can't be null";
                          }
                          return null;
                        },
                        onChange: (p0) {
                          context.read<FormBloc>()
                            ..add(NameChangedEvent(
                                name: BlocFormItem(value: p0!)));
                        },
                        initialValue: accommodation.name,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: CustomFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.singleLineFormatter
                        ],
                        prefixIcon: Icon(
                          Icons.location_city,
                          color: Colors.orange,
                        ),
                        keyboardType: TextInputType.name,
                        labelText: "Enter City",
                        onTapOutside: (p) => FocusScope.of(context).unfocus(),
                        validatior: (p0) {
                          if (p0!.isEmpty) {
                            return "Can't be null";
                          }
                          return null;
                        },
                        onChange: (p0) {
                          context.read<FormBloc>()
                            ..add(CityChangedEvent(
                                city: BlocFormItem(value: p0!)));
                        },
                        initialValue: accommodation.city,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: CustomFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.singleLineFormatter
                        ],
                        prefixIcon: Icon(
                          Icons.map,
                          color: Colors.red,
                        ),
                        keyboardType: TextInputType.name,
                        labelText: "Enter Address",
                        onTapOutside: (p) => FocusScope.of(context).unfocus(),
                        validatior: (p0) {
                          if (p0!.isEmpty) {
                            return "Can't be null";
                          }
                          return null;
                        },
                        onChange: (p0) {
                          context.read<FormBloc>()
                            ..add(AddressChangedEvent(
                                address: BlocFormItem(value: p0!)));
                        },
                        initialValue: accommodation.address,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<AccommodationAdditionBloc,
                        AccommodationAdditionState>(
                      builder: (context, accommodationState) {
                        if (context
                                .read<AccommodationAdditionBloc>()
                                .state
                                .accommodation !=
                            null) {
                          accommodation = context
                              .read<AccommodationAdditionBloc>()
                              .state
                              .accommodation!;
                        }

                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.3,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    CustomCheckBoxTile(
                                        title: "Parking",
                                        onChanged: (p0) {
                                          // if()
                                          if (accommodationState
                                                  .accommodation !=
                                              null) {
                                            context.read<
                                                AccommodationAdditionBloc>()
                                              ..add(AccommodationAdditionUpdateHitEvent(
                                                  accommodation:
                                                      accommodation.copyWith(
                                                          parking_availability:
                                                              p0)));
                                          }
                                        },
                                        value:
                                            accommodation.parking_availability!,
                                        icon: FontAwesomeIcons.parking),
                                    CustomCheckBoxTile(
                                        title: "Gym",
                                        onChanged: (p0) {
                                          // if()
                                          if (accommodationState
                                                  .accommodation !=
                                              null) {
                                            context.read<
                                                AccommodationAdditionBloc>()
                                              ..add(
                                                  AccommodationAdditionUpdateHitEvent(
                                                      accommodation:
                                                          accommodation.copyWith(
                                                              gym_availability:
                                                                  p0)));
                                          }
                                        },
                                        value: accommodation.gym_availability!,
                                        icon: FontAwesomeIcons.dumbbell)
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomCheckBoxTile(
                                      title: "Swimming pool",
                                      onChanged: (p0) {
                                        if (accommodationState.accommodation !=
                                            null) {
                                          context
                                              .read<AccommodationAdditionBloc>()
                                            ..add(AccommodationAdditionUpdateHitEvent(
                                                accommodation:
                                                    accommodation.copyWith(
                                                        swimming_pool_availability:
                                                            p0)));
                                        }
                                      },
                                      value: accommodation
                                          .swimming_pool_availability!,
                                      icon: FontAwesomeIcons.parking),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: CustomMaterialButton(
                          onPressed: () async {
                            if (context
                                .read<FormBloc>()
                                .state
                                .formKey!
                                .currentState!
                                .validate()) {
                              // print("This is valid");
                              var stateAccommodation = context
                                  .read<AccommodationAdditionBloc>()
                                  .state
                                  .accommodation!;
                              var formData = context.read<FormBloc>().state;
                              Map updateData = {
                                'id': data['id'].toString(),
                                'name': formData.name.value != ''
                                    ? formData.name.value.toString()
                                    : stateAccommodation.name.toString(),
                                'city': formData.city.value != ''
                                    ? formData.city.value.toString()
                                    : stateAccommodation.city.toString(),
                                'address': formData.address.value != ''
                                    ? formData.address.value.toString()
                                    : stateAccommodation.address.toString(),
                                'parking_availability': stateAccommodation
                                    .parking_availability
                                    .toString(),
                                'gym_availability': stateAccommodation
                                    .gym_availability
                                    .toString(),
                                'swimming_pool_availability': stateAccommodation
                                    .swimming_pool_availability
                                    .toString()
                              };
                              print("The data is ${updateData}");
                              await context.read<UpdateHotelWithoutTierCubit>()
                                ..updateAccommodationDetails(
                                    data: updateData,
                                    id: data['id'],
                                    token: data['token']);
                              Navigator.pop(context);
                            }
                          },
                          child: Text("Confirm Edit"),
                          backgroundColor: Color(0xff514f53),
                          textColor: Colors.white,
                          height: 45),
                    ),
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 270,
            child: Stack(
              children: [
                CustomMainImageVIew(
                    imageLink:
                        "${getIpWithoutSlash()}${fetchHostelWithoutTierSuccess.accommodation.image}"),
                Positioned(
                    right: 20,
                    top: 20,
                    child: EditDeleteButtonWidget(
                      deleteOnTap: () async {},
                      editOnTap: () async {
                        var imageHelper =
                            context.read<ImageHelperCubit>().state.imageHelper!;
                        final files = await imageHelper.pickImage();
                        if (files.isNotEmpty) {
                          final croppedFile = await imageHelper.crop(
                              file: files.first,
                              cropStyle: CropStyle.rectangle);
                          print("This is cropped file ");
                          if (croppedFile != null) {
                            var loginState = context.read<LoginBloc>().state;
                            print("The file is ${File(croppedFile.path)}");
                            File file = File(croppedFile.path);
                            if (loginState is LoginLoaded) {
                              await context.read<UpdateHotelWithoutTierCubit>()
                                ..updateAccommodationImage(
                                    token: loginState.successModel.token!,
                                    image: file,
                                    id: data['id']);
                              await callHotelWithoutTierApis(
                                  accommodationID: data['id'],
                                  context: context,
                                  token: data['token']);
                            }
                          }
                        }
                      },
                    )),
                Positioned(
                    left: 1,
                    bottom: -1,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (fetchHostelWithoutTierSuccess
                              .accommodation.is_pending!)
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
                          if (fetchHostelWithoutTierSuccess
                              .accommodation.is_verified!)
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
                          if (fetchHostelWithoutTierSuccess
                              .accommodation.is_rejected!)
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
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
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
                                text: fetchHostelWithoutTierSuccess
                                    .accommodation.name!,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () async {
                            await editAccommodaiton(
                                accommodation:
                                    fetchHostelWithoutTierSuccess.accommodation,
                                context: context);
                            // updateRentalAccommodation(
                            //     accommodation:
                            //         fetchHostelWithoutTierSuccess.accommodation!,
                            //     context: context);
                            // roomDetailsUpdateSheet(beds: fetchHostelWithoutTierSuccess.accommodation.)
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
                                "${fetchHostelWithoutTierSuccess.accommodation.city}, ${fetchHostelWithoutTierSuccess.accommodation.address}",
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                      value: fetchHostelWithoutTierSuccess
                                          .accommodation.parking_availability!)
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
                                      value: fetchHostelWithoutTierSuccess
                                          .accommodation.gym_availability!)
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
                                      value: fetchHostelWithoutTierSuccess
                                          .accommodation
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
            padding: EdgeInsets.all(15),
            child: Container(
              // height: 50,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
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
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            height: 50,
                            child: Row(
                              children: [
                                Row(
                                  // mainAxisAlignment: Main,
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) =>
                                      HotelWithoutTierRoomViewScreen(
                                          data: data)));
                              // Navigator.of(context)
                              //     .push(MaterialPageRoute(
                              //         builder: (_) => HostelRoomView(
                              //               data: data,
                              //             )));
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
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: fetchHostelWithoutTierSuccess.room.length,
                          itemBuilder: (context, index) {
                            int room_id =
                                fetchHostelWithoutTierSuccess.room[index].id!;
                            late String imageLink;
                            fetchHostelWithoutTierSuccess.image.forEach(
                              (element) {
                                print("The room id is ${room_id}");
                                print("The elements are ${element}");
                                // print("The images are ${element}");
                                if (element.room == room_id) {
                                  // print("It does exist");

                                  imageLink = element.images!;
                                }
                              },
                            );
                            print("The room id is ${room_id}");
                            return Container(
                              padding: EdgeInsets.all(10),
                              child: ListTile(
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  child: CachedNetworkImage(
                                      imageBuilder: (context, imageProvider) {
                                        return Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: imageProvider)),
                                        );
                                      },
                                      imageUrl:
                                          "${getIpWithoutSlash()}$imageLink"),
                                ),
                                title: Text(
                                  "Room ${index + 1}",
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                subtitle: Text(
                                  "This room has ${fetchHostelWithoutTierSuccess.room[index].seater_beds} beds for Rs ${fetchHostelWithoutTierSuccess.room[index].per_day_rent}",
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
          )
        ],
      ),
    );
  }
}

Future<void> callHotelWithoutTierApis(
    {required BuildContext context,
    required String token,
    required int accommodationID}) async {
  await context.read<FetchHotelWithoutTierCubit>()
    ..FetchHotel(accommodationId: accommodationID, token: token);
}
