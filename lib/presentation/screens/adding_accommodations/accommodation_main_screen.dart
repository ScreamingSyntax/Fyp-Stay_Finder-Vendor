import 'dart:io';

import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:stayfinder_vendor/data/model/accommodation_model.dart';
import 'package:stayfinder_vendor/data/model/bloc_form_model.dart';
import 'package:stayfinder_vendor/data/model/room_model.dart';
import 'package:stayfinder_vendor/logic/blocs/accommodation_addition/accommodation_addition_bloc.dart';
import 'package:stayfinder_vendor/logic/blocs/add_rental_room/add_rental_room_bloc.dart';
import 'package:stayfinder_vendor/logic/blocs/bloc_exports.dart';
import 'package:stayfinder_vendor/logic/cubits/cubit_exports.dart';
import 'package:stayfinder_vendor/logic/cubits/store_images/store_images_cubit.dart';
import 'package:stayfinder_vendor/presentation/config/image_helper.dart';
import 'package:stayfinder_vendor/presentation/widgets/widgets_exports.dart';
import 'package:stayfinder_vendor/constants/extensions.dart';
import 'package:flutter_map/flutter_map.dart';
import '../../../constants/constants_exports.dart';
import '../../../logic/blocs/hostel_addition/hostel_addition_bloc.dart';
import 'package:latlong2/latlong.dart';

void navigateToAccommodation(
    DropDownValueState state, BuildContext context, FormsState formState) {
  var locationStorage = context.read<SaveLocationCubit>().state;
  if (state.value == "rent_room") {
    // context.read<DropDownValueCubit>().clearDropDownValue();
    var state = context.read<AddRentalRoomBloc>().state;
    print("This is room ${state.room}");
    print(state.roomImage1);
    print(state.roomImage2);
    print(state.roomImage3);
    if (state.room != null) {
      context
          .read<AddRentalRoomBloc>()
          .add(ClearRentalRoomAdditionStateEvent());
    }
    context.read<AddRentalRoomBloc>().add(
        InitializeRentalRoomAccommodationEvent(
            room: Room(
              fan_availability: false,
              bed_availability: false,
              sofa_availability: false,
              mat_availability: false,
              carpet_availability: false,
              dustbin_availability: false,
            ),
            accommodationImage:
                context.read<AccommodationAdditionBloc>().state.image,
            accommodation: Accommodation(
                longitude: locationStorage.longitude,
                latitude: locationStorage.latitude,
                parking_availability: false,
                trash_dispose_availability: false,
                address: formState.address.value,
                name: formState.name.value,
                city: formState.city.value,
                type: context.read<DropDownValueCubit>().state.value)));
    context.read<DropDownValueCubit>().instantiateDropDownValue(
        items: ['Excellent', 'Average', 'Adjustable']);
    context.read<DropDownValueCubit>().changeDropDownValue('Excellent');
    Navigator.pushNamed(context, "/addRentalScreen");
  }
  if (state.value == "hotel") {
    Navigator.pushNamed(context, "/addHotelScreen");
    context.read<AccommodationAdditionBloc>().add(AccommodationAdditionHitEvent(
        image: context.read<AccommodationAdditionBloc>().state.image,
        accommodation: Accommodation(
            parking_availability: false,
            swimming_pool_availability: false,
            has_tier: false,
            longitude: locationStorage.longitude,
            latitude: locationStorage.latitude,
            gym_availability: false,
            trash_dispose_availability: false,
            address: formState.address.value,
            name: formState.name.value,
            city: formState.city.value,
            type: context.read<DropDownValueCubit>().state.value)));
    context.read<DropDownValueCubit>().instantiateDropDownValue(
        items: ['Excellent', 'Average', 'Adjustable']);

    context.read<DropDownValueCubit>().changeDropDownValue('Excellent');
    Navigator.pushNamed(context, "/hotelLandingScren");
  }
  if (state.value == "hostel") {
    context.read<HostelAdditionBloc>()
      ..add(HostelAddtionHitEvent(
          accommodationImage:
              context.read<AccommodationAdditionBloc>().state.image,
          accommodation: Accommodation(
              parking_availability: false,
              trash_dispose_availability: false,
              address: formState.address.value,
              name: formState.name.value,
              longitude: locationStorage.longitude,
              latitude: locationStorage.latitude,
              city: formState.city.value,
              type: context.read<DropDownValueCubit>().state.value)));
    context.read<DropDownValueCubit>().instantiateDropDownValue(
        items: ['Excellent', 'Average', 'Adjustable']);
    context.read<HostelAdditionBloc>()..add(ClearRoomsEvent());
    context.read<DropDownValueCubit>().changeDropDownValue('Excellent');
    Navigator.pushNamed(context, "/addHostelScreen");
  }
}

class AccommodationMainScreen extends StatefulWidget {
  @override
  State<AccommodationMainScreen> createState() =>
      _AccommodationMainScreenState();
}

class _AccommodationMainScreenState extends State<AccommodationMainScreen>
    with SingleTickerProviderStateMixin {
  final MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => FormBloc(),
        ),
        BlocProvider(
          create: (context) =>
              ImageHelperCubit()..imageHelperAccess(imageHelper: ImageHelper()),
        ),
      ],
      child: Builder(builder: (context) {
        return WillPopScope(
          onWillPop: () => showExitPopup(
            context: context,
            message: "Do you really want to go back?",
            title: "Confirmation",
            noBtnFunction: () {
              Navigator.pop(context);
            },
            yesBtnFunction: () {
              int count = 0;
              Navigator.of(context).popUntil((_) => count++ >= 2);
              context
                  .read<AddRentalRoomBloc>()
                  .add(ClearRentalRoomAdditionStateEvent());
            },
          ),
          child: Scaffold(
            bottomNavigationBar: BlocBuilder<FormBloc, FormsState>(
              builder: (context, formState) {
                return SizedBox(
                  // color: Colors.black,
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: CustomMaterialButton(
                            onPressed: () async {
                              bool locationPermission = await LocationHandler
                                  .handleLocationPermission(context);
                              print(locationPermission);
                              customScaffold(
                                  context: context,
                                  title: "Please Wait",
                                  message:
                                      "We are getting your current location",
                                  contentType: ContentType.warning);
                              if (locationPermission) {
                                // Map(context);
                                Position position =
                                    await Geolocator.getCurrentPosition(
                                        desiredAccuracy: LocationAccuracy.high);
                                Map(
                                    context: context,
                                    latitude: position.latitude,
                                    longitude: position.longitude);
                              }
                              // else{

                              // }
                            },
                            child: Text("Add Location"),
                            backgroundColor: Color(0xff48444e),
                            textColor: Colors.white,
                            height: 45),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: CustomMaterialButton(
                            onPressed: () {
                              var loginState = context.read<LoginBloc>().state;
                              if (loginState is LoginLoaded) {
                                bool checkStatus =
                                    checkLimit(context, loginState);
                                if (checkStatus == false) {
                                  int count = 0;
                                  Navigator.of(context)
                                      .popUntil((_) => count++ >= 1);
                                  context
                                      .read<AddRentalRoomBloc>()
                                      .add(ClearRentalRoomAdditionStateEvent());
                                }
                              }
                              if (formState.formKey!.currentState!.validate()) {
                                if (context
                                        .read<AccommodationAdditionBloc>()
                                        .state
                                        .image ==
                                    null) {
                                  return customScaffold(
                                      context: context,
                                      title: "Image Error",
                                      message:
                                          "Please provide accommodation image",
                                      contentType: ContentType.failure);
                                }
                                if (context
                                        .read<DropDownValueCubit>()
                                        .state
                                        .value ==
                                    null) {
                                  return customScaffold(
                                      context: context,
                                      title: "Type Error",
                                      message:
                                          "Please provide the type of accommodation",
                                      contentType: ContentType.failure);
                                }
                                if (context
                                        .read<SaveLocationCubit>()
                                        .state
                                        .latitude ==
                                    null) {
                                  return customScaffold(
                                      context: context,
                                      title: "Add Location",
                                      message:
                                          "Please add the accommodation location",
                                      contentType: ContentType.failure);
                                }
                                showExitPopup(
                                    context: context,
                                    message:
                                        'Are you sure you want sure you want to choose ${context.read<DropDownValueCubit>().state.value} as your accommodation',
                                    title: "Confirmation",
                                    noBtnFunction: () => Navigator.pop(context),
                                    yesBtnFunction: () {
                                      navigateToAccommodation(
                                          context
                                              .read<DropDownValueCubit>()
                                              .state,
                                          context,
                                          formState);
                                    });
                              }
                            },
                            child: Text("Continue"),
                            backgroundColor: Color(0xff32454D),
                            textColor: Colors.white,
                            height: 50),
                      ),
                    ],
                  ),
                );
              },
            ),
            body: BlocBuilder<FormBloc, FormsState>(
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Form(
                    key: context.read<FormBloc>().state.formKey,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Arc(
                              height: 50,
                              arcType: ArcType.CONVEX,
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height / 2.5,
                                decoration: BoxDecoration(
                                    color: Color(0xff32454D),
                                    image: context
                                                .watch<
                                                    AccommodationAdditionBloc>()
                                                .state
                                                .image ==
                                            null
                                        ? DecorationImage(
                                            image: AssetImage(
                                                "assets/images/Building-bro.png"))
                                        : DecorationImage(
                                            fit: BoxFit.cover,
                                            image: FileImage(context
                                                .watch<
                                                    AccommodationAdditionBloc>()
                                                .state
                                                .image!))),
                              ),
                            ),
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
                                        context.read<AddRentalRoomBloc>().add(
                                            ClearRentalRoomAdditionStateEvent());
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
                        SizedBox(
                          height: 30,
                        ),
                        CustomPoppinsText(
                          text: "Add Accommodation",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff514f53),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              CustomFormField(
                                validatior: (p0) {
                                  if (p0!.isEmpty) {
                                    return "Name cannot be empty";
                                  }
                                  if (!p0.isValidName) {
                                    return "The name is invalid";
                                  }
                                  return null;
                                },
                                onChange: (p0) => context.read<FormBloc>().add(
                                    NameChangedEvent(
                                        name: BlocFormItem(value: p0!))),
                                inputFormatters: [],
                                labelText: "Name",
                                prefixIcon:
                                    Icon(CupertinoIcons.building_2_fill),
                                onTapOutside: (p0) =>
                                    FocusScope.of(context).unfocus(),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomFormField(
                                validatior: (p0) {
                                  if (p0!.isEmpty) {
                                    return "City cannot be empty";
                                  }
                                  return null;
                                },
                                onChange: (p0) => context.read<FormBloc>().add(
                                    CityChangedEvent(
                                        city: BlocFormItem(value: p0!))),
                                inputFormatters: [],
                                labelText: "City",
                                prefixIcon: Icon(CupertinoIcons.placemark),
                                onTapOutside: (p0) =>
                                    FocusScope.of(context).unfocus(),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomFormField(
                                onChange: (p0) => context.read<FormBloc>().add(
                                    AddressChangedEvent(
                                        address: BlocFormItem(value: p0!))),
                                validatior: (p0) {
                                  if (p0!.isEmpty) {
                                    return "Address cannot be empty";
                                  }
                                  return null;
                                },
                                inputFormatters: [],
                                labelText: "Address",
                                prefixIcon: Icon(CupertinoIcons.tag_solid),
                                onTapOutside: (p0) =>
                                    FocusScope.of(context).unfocus(),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              BlocBuilder<DropDownValueCubit,
                                  DropDownValueState>(
                                builder: (context, state) {
                                  return Row(
                                    children: [
                                      Icon(
                                        Icons.location_city,
                                        color: Color(0xff48444e),
                                      ),
                                      SizedBox(
                                        width: 13,
                                      ),
                                      Container(
                                        height: 47,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Color(0xff878e92),
                                                width: 1.3),
                                            color: Color(0xffe5e5e5),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: DropdownButtonHideUnderline(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 13.0),
                                            child: CustomDropDownButton(
                                              state: state,
                                              items: state.items!
                                                  .map<
                                                      DropdownMenuItem<
                                                          String>>((value) =>
                                                      DropdownMenuItem(
                                                        child: Text(value!),
                                                        value: value,
                                                      ))
                                                  .toList(),
                                              onChanged: (p0) => context
                                                  .read<DropDownValueCubit>()
                                                  .changeDropDownValue(p0!),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 50,
                                      ),
                                      Expanded(
                                          child: CustomMaterialButton(
                                              onPressed: () async {
                                                var imageHelper = context
                                                    .read<ImageHelperCubit>()
                                                    .state
                                                    .imageHelper!;
                                                final files = await imageHelper
                                                    .pickImage();
                                                if (files.isNotEmpty) {
                                                  final croppedFile =
                                                      await imageHelper.crop(
                                                          file: files.first,
                                                          cropStyle: CropStyle
                                                              .rectangle);
                                                  print(
                                                      "This is cropped file ${croppedFile}");
                                                  if (croppedFile != null) {
                                                    context.read<
                                                        AccommodationAdditionBloc>()
                                                      ..add(
                                                          AccommodationAdditionHitEvent(
                                                              image: File(
                                                                  croppedFile
                                                                      .path)));
                                                  }
                                                }
                                              },
                                              child: Text("Select Image"),
                                              backgroundColor:
                                                  Color(0xff514f53),
                                              textColor: Colors.white,
                                              height: 50)),
                                    ],
                                  );
                                },
                              )
                            ],
                          ),
                        ),

                        // CustomFormField(inputFormatters: []),
                        // CustomFormField(inputFormatters: []),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }),
    );
  }

  Future<dynamic> Map(
      {required BuildContext context,
      required double latitude,
      required double longitude}) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Stack(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: FlutterMap(
                      mapController: _mapController,
                      options: MapOptions(
                        onMapEvent: (p0) {
                          // p0.
                        },
                        maxZoom: 20,
                        initialCenter: LatLng(latitude, longitude),
                        initialZoom: 15,
                        onLongPress: (tapPosition, point) {
                          context.read<SaveLocationCubit>()
                            ..storeLocation(
                                longitude: point.longitude.toString(),
                                latitude: point.latitude.toString());
                        },
                      ),
                      children: [
                        TileLayer(
                            urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName:
                                "com.example.stayfinder_vendor"),
                        BlocBuilder<SaveLocationCubit, SaveLocationState>(
                          builder: (context, state) {
                            if (state.latitude != null) {
                              // print("Change");
                              return MarkerLayer(
                                  alignment: Alignment.center,
                                  markers: [
                                    Marker(
                                        point: LatLng(
                                            double.parse(state.latitude!),
                                            double.parse(state.longitude!)),
                                        child: Icon(
                                          Icons.location_on,
                                          color: Colors.red,
                                          size: 30,
                                        ))
                                  ]);
                            }
                            return SizedBox();
                          },
                        ),
                        MarkerLayer(alignment: Alignment.center, markers: [
                          Marker(
                              point: LatLng(latitude, longitude),
                              child: Icon(
                                Icons.emoji_people,
                                color: Colors.red,
                                size: 20,
                              ))
                        ]),
                        RichAttributionWidget(
                          attributions: [
                            TextSourceAttribution('OpenStreetMap contributors',
                                onTap: () {}),
                          ],
                        ),
                      ]),
                ),

                Positioned(
                    top: 50,
                    left: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xff455A64),
                            borderRadius: BorderRadius.circular(15)),
                        padding: const EdgeInsets.all(10.0),
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    _mapController.dispose();
                                    // Navigator.pop(context);
                                    // _mapControlle
                                  },
                                  child: Icon(
                                    size: 15,
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Text(
                                    "Longpress the accommodation address",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )),
                Positioned(
                    bottom: 20,
                    left: 30,
                    child: InkWell(
                      onTap: () =>
                          _mapController.move(LatLng(latitude, longitude), 17),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.all(10),
                            child: Icon(
                              Icons.location_searching_rounded,
                              size: 30,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          BlocBuilder<SaveLocationCubit, SaveLocationState>(
                            builder: (context, state) {
                              if (state.latitude != null) {
                                return SizedBox(
                                  width: MediaQuery.of(context).size.width / 3,
                                  child: CustomMaterialButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text("Confirm"),
                                      backgroundColor: Color(0xff514f53),
                                      textColor: Colors.white,
                                      height: 45),
                                );
                              }
                              return SizedBox();
                            },
                          )
                        ],
                      ),
                    )),
                // Positioned(
                //     bottom: 20,
                //     left: 100,
                //     child:
                //     ),
                // Positioned(child: Ico)
              ],
            ),
          );
        });
  }
}
