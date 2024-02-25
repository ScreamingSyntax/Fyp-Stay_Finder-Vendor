import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stayfinder_vendor/constants/ip.dart';
import 'package:stayfinder_vendor/data/model/model_exports.dart';
import 'package:stayfinder_vendor/logic/blocs/accommodation_addition/accommodation_addition_bloc.dart';
import 'package:stayfinder_vendor/logic/blocs/bloc_exports.dart';
import 'package:stayfinder_vendor/logic/cubits/FetchRentalRoom/fetch_rental_room_cubit.dart';
import 'package:stayfinder_vendor/logic/cubits/update_rental_accommodation/update_accommodation_image_cubit.dart';
import 'package:stayfinder_vendor/presentation/widgets/widgets_exports.dart';

import '../../../../logic/blocs/add_rental_room/add_rental_room_bloc.dart';
import '../../../../logic/cubits/cubit_exports.dart';
import '../../../config/config_exports.dart';

class RentalRoomViewScreen extends StatelessWidget {
  final Object arguments;

  const RentalRoomViewScreen({super.key, required this.arguments});

  Future<dynamic> updateRoomDetails({
    required String token,
    required Room room,
    required BuildContext context,
  }) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AddRentalRoomBloc()
                ..add(InitializeRentalRoomAccommodationEvent(room: room)),
            ),
          ],
          child: Builder(builder: (context) {
            // if()
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  CustomPoppinsText(
                      text: "Click on the image you want to update ",
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                  SizedBox(
                    height: 10,
                  ),
                  BlocBuilder<AddRentalRoomBloc, AddRentalRoomState>(
                    builder: (context, state) {
                      if (state.room != null) {
                        return GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 25,
                          mainAxisSpacing: 15,
                          padding: EdgeInsets.all(30),
                          primary: false,
                          childAspectRatio: 3,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: <Widget>[
                            CustomCheckBoxTile(
                              onChanged: (p0) => {
                                context.read<AddRentalRoomBloc>().add(
                                      UpdateAccommodationEvent(
                                        room: state.room!.copyWith(
                                          fan_availability:
                                              !(state.room!.fan_availability!),
                                        ),
                                      ),
                                    )
                              },
                              title: "Fan ",
                              value: context
                                  .watch<AddRentalRoomBloc>()
                                  .state
                                  .room!
                                  .fan_availability!,
                              icon: Icons.cached,
                            ),
                            CustomCheckBoxTile(
                              onChanged: (p0) => {
                                context.read<AddRentalRoomBloc>().add(
                                      UpdateAccommodationEvent(
                                        room: state.room!.copyWith(
                                          bed_availability:
                                              !(state.room!.bed_availability!),
                                        ),
                                      ),
                                    )
                              },
                              title: "Bed ",
                              icon: Icons.bed,
                              value: context
                                  .watch<AddRentalRoomBloc>()
                                  .state
                                  .room!
                                  .bed_availability!,
                            ),
                            CustomCheckBoxTile(
                              onChanged: (p0) => {
                                context.read<AddRentalRoomBloc>().add(
                                      UpdateAccommodationEvent(
                                        room: state.room!.copyWith(
                                          sofa_availability:
                                              !(state.room!.sofa_availability!),
                                        ),
                                      ),
                                    )
                              },
                              title: "Sofa",
                              icon: Boxicons.bx_chair,
                              value: context
                                  .watch<AddRentalRoomBloc>()
                                  .state
                                  .room!
                                  .sofa_availability!,
                            ),
                            CustomCheckBoxTile(
                              onChanged: (p0) => {
                                context.read<AddRentalRoomBloc>().add(
                                      UpdateAccommodationEvent(
                                        room: state.room!.copyWith(
                                          mat_availability:
                                              !(state.room!.mat_availability!),
                                        ),
                                      ),
                                    )
                              },
                              title: "Mat",
                              value: context
                                  .watch<AddRentalRoomBloc>()
                                  .state
                                  .room!
                                  .mat_availability!,
                              icon: Boxicons.bxs_barcode,
                            ),
                            CustomCheckBoxTile(
                              onChanged: (p0) => {
                                context.read<AddRentalRoomBloc>().add(
                                      UpdateAccommodationEvent(
                                        room: state.room!.copyWith(
                                          carpet_availability: !(state
                                              .room!.carpet_availability!),
                                        ),
                                      ),
                                    )
                              },
                              title: "Carpet",
                              value: context
                                  .watch<AddRentalRoomBloc>()
                                  .state
                                  .room!
                                  .carpet_availability!,
                              icon: Boxicons.bx_align_justify,
                            ),
                            CustomCheckBoxTile(
                              onChanged: (p0) => {
                                context.read<AddRentalRoomBloc>().add(
                                      UpdateAccommodationEvent(
                                        room: state.room!.copyWith(
                                          dustbin_availability: !(state
                                              .room!.dustbin_availability!),
                                        ),
                                      ),
                                    )
                              },
                              title: "Dustbin",
                              value: context
                                  .watch<AddRentalRoomBloc>()
                                  .state
                                  .room!
                                  .dustbin_availability!,
                              icon: Boxicons.bxs_trash,
                            ),
                          ],
                        );
                      }
                      return SizedBox();
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomPoppinsText(
                      text: "Washroom Status",
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                  SizedBox(
                    height: 10,
                  ),
                  BlocBuilder<DropDownValueCubit, DropDownValueState>(
                    builder: (context, state) {
                      return Container(
                        height: 47,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color(0xff878e92), width: 1.3),
                            color: Color(0xffe5e5e5),
                            borderRadius: BorderRadius.circular(5)),
                        child: DropdownButtonHideUnderline(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 13.0),
                            child: CustomDropDownButton(
                              state: state,
                              items: state.items!
                                  .map<DropdownMenuItem<String>>(
                                      (value) => DropdownMenuItem(
                                            child: Text(value!),
                                            value: value,
                                          ))
                                  .toList(),
                              onChanged: (p0) {
                                context
                                    .read<DropDownValueCubit>()
                                    .changeDropDownValue(p0!);
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35.0),
                    child: CustomMaterialButton(
                        onPressed: () {
                          Room room =
                              context.read<AddRentalRoomBloc>().state.room!;
                          Map roomData = {
                            'room_id': room.id,
                            "fan_availability": room.fan_availability,
                            "bed_availability": room.bed_availability,
                            "sofa_availability": room.sofa_availability,
                            "mat_availability": room.mat_availability,
                            "carpet_availability": room.carpet_availability,
                            "washroom_status":
                                context.read<DropDownValueCubit>().state.value,
                            "dustbin_availability": room.dustbin_availability
                          };
                          context.read<UpdateRentalAccommodationCubit>()
                            ..updateRoomDetails(token: token, data: roomData);
                          Navigator.pop(context);
                        },
                        child: Text("Confirm Update"),
                        backgroundColor: Color(0xff4C4C4C),
                        textColor: Colors.white,
                        height: 45),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }

  Future<dynamic> updateRoomImage(
      {required BuildContext context, required FetchRentalRoomSuccess state}) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return BlocProvider(
          create: (context) =>
              ImageHelperCubit()..imageHelperAccess(imageHelper: ImageHelper()),
          child: Builder(builder: (context) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  // Text("Click on the image you want to update")
                  CustomPoppinsText(
                      text: "Click on the image you want to update ",
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.roomImages.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6.0, horizontal: 10),
                          child: InkWell(
                            onTap: () async {
                              var imageHelper = context
                                  .read<ImageHelperCubit>()
                                  .state
                                  .imageHelper!;
                              final files = await imageHelper.pickImage();
                              if (files.isNotEmpty) {
                                final croppedFile = await imageHelper.crop(
                                    file: files.first,
                                    cropStyle: CropStyle.rectangle);
                                print("This is cropped file ${croppedFile}");
                                if (croppedFile != null) {
                                  var loginState =
                                      context.read<LoginBloc>().state;
                                  print(
                                      "The file is ${File(croppedFile.path)}");
                                  File file = File(croppedFile.path);
                                  if (loginState is LoginLoaded) {
                                    await context
                                        .read<UpdateRentalAccommodationCubit>()
                                      ..updateRoomImage(
                                          room_image_id: state
                                              .roomImages[index].id
                                              .toString(),
                                          room_id: state.roomImages[index].room
                                              .toString(),
                                          token: loginState.successModel.token
                                              .toString(),
                                          image: file);
                                    Navigator.pop(context);
                                  }
                                }
                              }
                              // context.read<UpdateRentalAccommodationCubit>()..updateRoomImage(room_id: state.roomImages[index].id.toString(), room_image_id: state.roomImages[index].room.toString(), token: token, image: state.roomImages)
                            },
                            child: Row(
                              children: [
                                RoomImageRental(
                                    image: NetworkImage(
                                        "${getIpWithoutSlash()}${state.roomImages[index].images}")),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
        );
      },
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
                          Icons.hotel,
                          color: Color(0xff4C4C4C),
                        ),
                        labelText: "Name",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomFormField(
                        initialValue: accommodation.monthly_rate.toString(),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validatior: (p0) {
                          if (p0!.isEmpty) {
                            return "Can't be null";
                          }
                          return null;
                        },
                        onChange: (p0) {
                          context.read<FormBloc>()
                            ..add(RateChangedEvent(
                                rate: BlocFormItem(value: p0!)));
                        },
                        prefixIcon: Icon(
                          Icons.hotel,
                          color: Color(0xff4C4C4C),
                        ),
                        labelText: "Monthly Rate",
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
                                    if (p0!.isEmpty) {
                                      return "Can't be null";
                                    }
                                    if (int.parse(p0) < 1) {
                                      return "Can't have 0 washroom";
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
                              prefixIcon: Icon(Icons.location_city),
                            ),
                          )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
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
                          Icons.hotel,
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
                                width: 20,
                              ),
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
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CustomCheckBoxTile(
                                      title: "Trash Dispose",
                                      onChanged: (p0) {
                                        if (accommodationState.accommodation !=
                                            null) {
                                          context
                                              .read<AccommodationAdditionBloc>()
                                            ..add(AccommodationAdditionUpdateHitEvent(
                                                accommodation: accommodationState
                                                    .accommodation!
                                                    .copyWith(
                                                        trash_dispose_availability:
                                                            p0)));
                                        }
                                      },
                                      value: accommodationState.accommodation !=
                                              null
                                          ? accommodationState.accommodation!
                                              .trash_dispose_availability!
                                          : false,
                                      icon: Boxicons.bxs_parking),
                                ),
                              ),
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
                                          'accommodation[id]': accommodation.id,
                                          'accommodation[name]':
                                              formState.name.value != ''
                                                  ? formState.name.value
                                                  : accommodation.name,
                                          'accommodation[number_of_washroom]':
                                              formState.washRoomCount
                                                          .value !=
                                                      ''
                                                  ? formState
                                                      .washRoomCount.value
                                                  : accommodation
                                                      .number_of_washroom,
                                          'accommodation[city]':
                                              formState.city.value != ''
                                                  ? formState.city.value
                                                  : accommodation.city,
                                          'accommodation[address]':
                                              formState.address.value != ''
                                                  ? formState.address.value
                                                  : accommodation.address,
                                          'accommodation[parking_availability]':
                                              context
                                                  .read<
                                                      AccommodationAdditionBloc>()
                                                  .state
                                                  .accommodation!
                                                  .parking_availability!,
                                          'accommodation[trash_dispose_availability]':
                                              context
                                                  .read<
                                                      AccommodationAdditionBloc>()
                                                  .state
                                                  .accommodation!
                                                  .trash_dispose_availability!,
                                          'accommodation[monthly_rate]':
                                              formState.rate.value != ''
                                                  ? formState.rate.value
                                                  : accommodation.monthly_rate,
                                        };
                                        var loginState =
                                            context.read<LoginBloc>().state;
                                        if (loginState is LoginLoaded) {
                                          context
                                              .read<
                                                  UpdateRentalAccommodationCubit>()
                                              .updateAccommodationDetail(
                                                  token: loginState
                                                      .successModel.token!,
                                                  accommodations:
                                                      itemsFromState);
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

  @override
  Widget build(BuildContext context) {
    Map args = arguments as Map;
    callRentalRoomApis(args, context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ImageHelperCubit()..imageHelperAccess(imageHelper: ImageHelper()),
        ),
      ],
      child: Builder(builder: (context) {
        return RefreshIndicator(
          onRefresh: () {
            return callRentalRoomApis(args, context);
          },
          child: MultiBlocListener(
            listeners: [
              BlocListener<UpdateRentalAccommodationCubit, UpdateRentalState>(
                listener: (context, state) {
                  if (state is UpdateRentalLoading) {
                    return customScaffold(
                        context: context,
                        title: "Loading",
                        message: "Please wait",
                        contentType: ContentType.warning);
                  }
                  if (state is UpdateRentalError) {
                    return customScaffold(
                        context: context,
                        title: "Error",
                        message: state.message,
                        contentType: ContentType.failure);
                  }
                  if (state is UpdateRentalSuccess) {
                    return customScaffold(
                        context: context,
                        title: "Success",
                        message: state.message,
                        contentType: ContentType.success);
                  }
                  // TODO: implement listener
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
                    callRentalRoomApis(args, context);
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
            child: Scaffold(
              backgroundColor: Color(0xffe5e5e5),
              body: BlocBuilder<FetchRentalRoomCubit, FetchRentalRoomState>(
                builder: (context, state) {
                  if (state is FetchRentalRoomInitial) {
                    callRentalRoomApis(args, context);
                  }
                  if (state is FetchRentalRoomLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is FetchRentalRoomError) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(state.message),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            child: CustomMaterialButton(
                                onPressed: () {
                                  callRentalRoomApis(args, context);
                                },
                                child: Text("Retry"),
                                backgroundColor: Color(0xff32454D),
                                textColor: Colors.white,
                                height: 45),
                          )
                        ],
                      ),
                    );
                  }
                  if (state is FetchRentalRoomSuccess) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: 270,
                            child: Stack(
                              children: [
                                CustomMainImageVIew(
                                  imageLink:
                                      "${getIpWithoutSlash()}${state.accommodation.image}",
                                ),
                                if (state.accommodation.is_verified! ||
                                    state.accommodation.is_rejected!)
                                  Positioned(
                                      right: 30,
                                      top: 50,
                                      child: EditDeleteButtonWidget(
                                        editOnTap: () async {
                                          var imageHelper = context
                                              .read<ImageHelperCubit>()
                                              .state
                                              .imageHelper!;
                                          final files =
                                              await imageHelper.pickImage();
                                          if (files.isNotEmpty) {
                                            final croppedFile =
                                                await imageHelper.crop(
                                                    file: files.first,
                                                    cropStyle:
                                                        CropStyle.rectangle);
                                            print("This is cropped file ");
                                            if (croppedFile != null) {
                                              var loginState = context
                                                  .read<LoginBloc>()
                                                  .state;
                                              print(
                                                  "The file is ${File(croppedFile.path)}");
                                              File file =
                                                  File(croppedFile.path);
                                              if (loginState is LoginLoaded) {
                                                // print(
                                                //     "The file is ${state.accommodation}");
                                                // print(
                                                //     "The file is ${loginState.successModel.token}");
                                                await context.read<
                                                    UpdateRentalAccommodationCubit>()
                                                  ..updateAccommodationImage(
                                                      image: file,
                                                      token: loginState
                                                          .successModel.token!,
                                                      accommodationId: state
                                                          .accommodation.id!);
                                              }
                                            }
                                          }
                                        },
                                        deleteOnTap: () {},
                                      )),
                                // Positioned(child: child),
                                Positioned(
                                    top: 80,
                                    left: 30,
                                    child: InkWell(
                                      onTap: () {
                                        showExitPopup(
                                          context: context,
                                          message:
                                              "Do you really want to go back?",
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          if (state.accommodation.is_pending!)
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
                                          if (state.accommodation.is_verified!)
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
                                          if (state.accommodation.is_rejected!)
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
                                    )),
                                // Positioned(
                                //     // left: 1,
                                //     right: 20,
                                //     top: 20,
                                //     child: Container(
                                //       width: MediaQuery.of(context).size.width,
                                //       height: 50,
                                //       child: Icon(Icons.location_on_outlined),
                                //     ))
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            CustomPoppinsText(
                                                text: state.accommodation.name!,
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
                                                    fontWeight:
                                                        FontWeight.w700),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                CustomPoppinsText(
                                                    text: state.accommodation
                                                        .monthly_rate!
                                                        .toString(),
                                                    fontSize: 23,
                                                    color: Color(0xff4c4c4c),
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (state.accommodation.is_rejected! ||
                                          state.accommodation.is_verified!)
                                        InkWell(
                                          onTap: () {
                                            updateRentalAccommodation(
                                                context: context,
                                                accommodation:
                                                    state.accommodation);
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                              "${state.accommodation.city}, ${state.accommodation.address}",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                              text: state.accommodation
                                                  .number_of_washroom
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
                                              value: state.accommodation
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
                                              value: state.accommodation
                                                  .parking_availability!)
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
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomPoppinsText(
                                          text: "Room Images",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                      if (state.accommodation.is_verified! ||
                                          state.accommodation.is_rejected!)
                                        InkWell(
                                          onTap: () {
                                            updateRoomImage(
                                                context: context, state: state);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Icon(
                                              Icons.edit,
                                              color: Colors.red,
                                            ),
                                          ),
                                        )
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: state.roomImages.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(6.0),
                                                child: Row(
                                                  children: [
                                                    RoomImageRental(
                                                        image: NetworkImage(
                                                            "${getIpWithoutSlash()}${state.roomImages[index].images}")),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomPoppinsText(
                                          text: "Room Details",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                      if (state.accommodation.is_verified! ||
                                          state.accommodation.is_rejected!)
                                        InkWell(
                                          onTap: () async {
                                            var loginState =
                                                context.read<LoginBloc>().state;
                                            if (loginState is LoginLoaded) {
                                              await context
                                                  .read<DropDownValueCubit>()
                                                ..instantiateDropDownValue(
                                                    items: [
                                                      "Average",
                                                      "Excellent",
                                                      "Adjustable"
                                                    ]);
                                              await context
                                                  .read<DropDownValueCubit>()
                                                  .changeDropDownValue(state
                                                      .room.washroom_status
                                                      .toString());
                                              return updateRoomDetails(
                                                  context: context,
                                                  room: state.room,
                                                  token: loginState
                                                      .successModel.token!
                                                      .toString());
                                            }
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Icon(
                                              Icons.edit,
                                              color: Colors.red,
                                            ),
                                          ),
                                        )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  RoomDetailWidgetRental(
                                    text: "Bed",
                                    value: state.room.bed_availability!,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  RoomDetailWidgetRental(
                                    text: "Fan",
                                    value: state.room.fan_availability!,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  RoomDetailWidgetRental(
                                    text: "Sofa",
                                    value: state.room.sofa_availability!,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  RoomDetailWidgetRental(
                                    text: "Mat",
                                    value: state.room.mat_availability!,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  RoomDetailWidgetRental(
                                    text: "Carpet",
                                    value: state.room.carpet_availability!,
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
                                          text: state.room.washroom_status!,
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
                                    value: state.room.dustbin_availability!,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  RoomDetailWidgetRental(
                                    text: "Trash Disposable",
                                    value: state.accommodation
                                        .trash_dispose_availability!,
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
                          if (state.accommodation.is_rejected!)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10),
                              child: Column(
                                children: [
                                  BlocBuilder<
                                      ResumbitAccommodationVerificationCubit,
                                      ResumbitAccommodationVerificationState>(
                                    builder: (context, resubState) {
                                      if (resubState
                                          is ResubmitAccommodationVerificationLoading) {
                                        return SizedBox();
                                      }
                                      return CustomMaterialButton(
                                          onPressed: () {
                                            var loginState =
                                                context.read<LoginBloc>().state;
                                            if (loginState is LoginLoaded) {
                                              context.read<
                                                  ResumbitAccommodationVerificationCubit>()
                                                ..resubmitForVerification(
                                                    token: loginState
                                                        .successModel.token!,
                                                    accommodationId: state
                                                        .accommodation.id!);
                                            }
                                          },
                                          child:
                                              Text("Resubmit for Verification"),
                                          backgroundColor: Color(0xff29383f),
                                          textColor: Colors.white,
                                          height: 45);
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
                    );
                  }
                  return SizedBox();
                },
              ),
            ),
          ),
        );
      }),
    );
  }

  Future<void> callRentalRoomApis(
      Map<dynamic, dynamic> args, BuildContext context) async {
    String token = args['token'];
    int accommodationID = args['id'];
    context
        .read<FetchRentalRoomCubit>()
        .fetchRentalRoom(accommodationId: accommodationID, token: token);
  }
}

class RoomImageRental extends StatelessWidget {
  const RoomImageRental({super.key, required this.image});
  final ImageProvider<Object> image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
          border: Border.all(
              color: Color(0xff29383F).withOpacity(0.8),
              width: 2,
              style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(fit: BoxFit.cover, image: image)),
    );
  }
}
