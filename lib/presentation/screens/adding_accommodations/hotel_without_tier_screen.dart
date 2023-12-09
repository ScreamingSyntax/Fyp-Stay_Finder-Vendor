import 'dart:io';

import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stayfinder_vendor/constants/constants_exports.dart';
import 'package:stayfinder_vendor/logic/blocs/hostel_addition/hostel_addition_bloc.dart';
import 'package:stayfinder_vendor/logic/blocs/hotel_without_tier_addition/add_hotel_without_tier_bloc.dart';
import 'package:stayfinder_vendor/logic/cubits/room_addition/room_addition_cubit.dart';
import 'package:stayfinder_vendor/logic/cubits/store_images/store_images_cubit.dart';
import 'package:stayfinder_vendor/presentation/widgets/widgets_exports.dart';

import '../../../data/model/model_exports.dart';
import '../../../logic/blocs/bloc_exports.dart';
import '../../../logic/cubits/cubit_exports.dart';
import '../../config/config_exports.dart';

class HostelWithoutTierScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<dynamic> updateNonTierHotelRooms(
        BuildContext context, int index, Room room) {
      return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => FormBloc()..add(InitEvent()),
              ),
              BlocProvider(
                create: (context) => RoomAdditionCubit()
                  ..RoomUpdate(Room(
                      ac_availability: room.ac_availability,
                      coffee_powder_availability:
                          room.coffee_powder_availability,
                      fan_availability: room.fan_availability,
                      kettle_availability: room.kettle_availability,
                      monthly_rate: room.monthly_rate,
                      hair_dryer_availability: room.hair_dryer_availability,
                      steam_iron_availability: room.steam_iron_availability,
                      milk_powder_availability: room.milk_powder_availability,
                      tv_availability: room.tv_availability,
                      tea_powder_availability: room.tea_powder_availability,
                      water_bottle_availability: room.water_bottle_availability,
                      seater_beds: room.seater_beds)),
              ),
            ],
            child: Builder(builder: (context) {
              return Container(
                child: Form(
                  key: context.read<FormBloc>().state.formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        CustomPoppinsText(
                            text: "Room Details",
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                        SizedBox(
                          height: 20,
                        ),
                        BlocBuilder<AddHotelWithoutTierBloc,
                            AddHotelWithoutTierState>(
                          builder: (context, state) {
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  CustomFormField(
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    initialValue: state
                                        .room![index]!.seater_beds
                                        .toString(),
                                    prefixIcon: Icon(Icons.bed),
                                    keyboardType: TextInputType.number,
                                    onChange: (p0) {
                                      context.read<FormBloc>()
                                        ..add(BedChangedEvent(
                                            bedChanged:
                                                BlocFormItem(value: p0!)));
                                    },
                                    onTapOutside: (p0) =>
                                        FocusScope.of(context).unfocus(),
                                    validatior: (p0) {
                                      if (p0!.isEmpty || p0 == "") {
                                        return "Seater Beds cannot be null";
                                      }
                                      if (!(p0.isValidNumber)) {
                                        return "Invalid Number";
                                      }
                                      if (int.parse(p0) <= 0) {
                                        return "Invalid Beds";
                                      }
                                      if (int.parse(p0) > 5) {
                                        return "Cannot have more than 5 beds";
                                      }
                                      return null;
                                    },
                                    labelText: "Seater Beds",
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  CustomFormField(
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    initialValue: state
                                        .room![index]!.monthly_rate
                                        .toString(),
                                    prefixIcon: Icon(Icons.bed),
                                    keyboardType: TextInputType.number,
                                    onChange: (p0) {
                                      context.read<FormBloc>()
                                        ..add(RateChangedEvent(
                                            rate: BlocFormItem(value: p0!)));
                                    },
                                    onTapOutside: (p0) =>
                                        FocusScope.of(context).unfocus(),
                                    validatior: (p0) {
                                      if (p0!.isEmpty || p0 == "") {
                                        return "Per Day Rent cannot be null";
                                      }
                                      if (!(p0.isValidNumber)) {
                                        return "Invalid Number";
                                      }
                                      if (int.parse(p0) <= 1000) {
                                        return "Rent can't be lesser than 1000";
                                      }
                                      return null;
                                    },
                                    labelText: "Per Day Rent",
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: BlocBuilder<RoomAdditionCubit,
                                        RoomAdditionState>(
                                      builder: (context, state) {
                                        return Column(
                                          children: [
                                            CustomWidgetRow(
                                              widget1: CustomCheckBoxTile(
                                                  title: "A.C",
                                                  onChanged: (value) {
                                                    if (state.room != null) {
                                                      context
                                                          .read<
                                                              RoomAdditionCubit>()
                                                          .RoomUpdate(state
                                                              .room!
                                                              .copyWith(
                                                                  ac_availability:
                                                                      value));
                                                    }
                                                  },
                                                  value: state
                                                      .room!.ac_availability!,
                                                  icon: Icons.ac_unit),
                                              widget2: CustomCheckBoxTile(
                                                  title: "Steam Iron",
                                                  onChanged: (value) {
                                                    if (state.room != null) {
                                                      context
                                                          .read<
                                                              RoomAdditionCubit>()
                                                          .RoomUpdate(state
                                                              .room!
                                                              .copyWith(
                                                                  steam_iron_availability:
                                                                      value));
                                                    }
                                                  },
                                                  value: state.room!
                                                      .steam_iron_availability!,
                                                  icon: Icons.iron),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            CustomWidgetRow(
                                              widget1: CustomCheckBoxTile(
                                                  title: "Water Bottle",
                                                  onChanged: (value) {
                                                    if (state.room != null) {
                                                      context
                                                          .read<
                                                              RoomAdditionCubit>()
                                                          .RoomUpdate(state
                                                              .room!
                                                              .copyWith(
                                                                  water_bottle_availability:
                                                                      value));
                                                    }
                                                  },
                                                  value: state.room!
                                                      .water_bottle_availability!,
                                                  icon: FontAwesomeIcons
                                                      .bottleWater),
                                              widget2: CustomCheckBoxTile(
                                                  title: "Fan",
                                                  onChanged: (value) {
                                                    if (state.room != null) {
                                                      context
                                                          .read<
                                                              RoomAdditionCubit>()
                                                          .RoomUpdate(state
                                                              .room!
                                                              .copyWith(
                                                                  fan_availability:
                                                                      value));
                                                    }
                                                  },
                                                  value: state
                                                      .room!.fan_availability!,
                                                  icon: FontAwesomeIcons.fan),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            CustomWidgetRow(
                                                widget1: CustomCheckBoxTile(
                                                    title: "Coffee Powder",
                                                    onChanged: (value) {
                                                      if (state.room != null) {
                                                        context
                                                            .read<
                                                                RoomAdditionCubit>()
                                                            .RoomUpdate(state
                                                                .room!
                                                                .copyWith(
                                                                    coffee_powder_availability:
                                                                        value));
                                                      }
                                                    },
                                                    value: state.room!
                                                        .coffee_powder_availability!,
                                                    icon: Icons.coffee),
                                                widget2: CustomCheckBoxTile(
                                                    title: "Tea Powder",
                                                    onChanged: (value) {
                                                      if (state.room != null) {
                                                        context
                                                            .read<
                                                                RoomAdditionCubit>()
                                                            .RoomUpdate(state
                                                                .room!
                                                                .copyWith(
                                                                    tea_powder_availability:
                                                                        value));
                                                      }
                                                    },
                                                    value: state.room!
                                                        .tea_powder_availability!,
                                                    icon:
                                                        CupertinoIcons.ticket)),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            CustomWidgetRow(
                                              widget1: CustomCheckBoxTile(
                                                  title: "Tv",
                                                  onChanged: (value) {
                                                    if (state.room != null) {
                                                      context
                                                          .read<
                                                              RoomAdditionCubit>()
                                                          .RoomUpdate(state
                                                              .room!
                                                              .copyWith(
                                                                  tv_availability:
                                                                      value));
                                                    }
                                                  },
                                                  value: state
                                                      .room!.tv_availability!,
                                                  icon: Icons.tv),
                                              widget2: CustomCheckBoxTile(
                                                  title: "Hair Dryer",
                                                  onChanged: (value) {
                                                    if (state.room != null) {
                                                      context
                                                          .read<
                                                              RoomAdditionCubit>()
                                                          .RoomUpdate(state
                                                              .room!
                                                              .copyWith(
                                                                  hair_dryer_availability:
                                                                      value));
                                                    }
                                                  },
                                                  value: state.room!
                                                      .hair_dryer_availability!,
                                                  icon:
                                                      FontAwesomeIcons.hotjar),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            CustomWidgetRow(
                                              widget1: CustomCheckBoxTile(
                                                  title: "Water Kettle",
                                                  onChanged: (value) {
                                                    if (state.room != null) {
                                                      context
                                                          .read<
                                                              RoomAdditionCubit>()
                                                          .RoomUpdate(state
                                                              .room!
                                                              .copyWith(
                                                                  kettle_availability:
                                                                      value));
                                                    }
                                                  },
                                                  value: state.room!
                                                      .kettle_availability!,
                                                  icon: Icons.hot_tub),
                                              widget2: CustomCheckBoxTile(
                                                  title: "Milk powder",
                                                  onChanged: (value) {
                                                    if (state.room != null) {
                                                      context
                                                          .read<
                                                              RoomAdditionCubit>()
                                                          .RoomUpdate(state
                                                              .room!
                                                              .copyWith(
                                                                  milk_powder_availability:
                                                                      value));
                                                    }
                                                  },
                                                  value: state.room!
                                                      .milk_powder_availability!,
                                                  icon: Icons.water),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            CustomMaterialButton(
                                                onPressed: () {
                                                  if (context
                                                      .read<FormBloc>()
                                                      .state
                                                      .formKey!
                                                      .currentState!
                                                      .validate()) {
                                                    Room room = context
                                                        .read<
                                                            RoomAdditionCubit>()
                                                        .state
                                                        .room!;
                                                    String seaterBeds = context
                                                        .read<FormBloc>()
                                                        .state
                                                        .bedCount
                                                        .value;
                                                    String rate = context
                                                        .read<FormBloc>()
                                                        .state
                                                        .rate
                                                        .value;
                                                    Map<String, String> items =
                                                        {
                                                      "seaterBeds": seaterBeds,
                                                      "rate": rate
                                                    };
                                                    print(items);
                                                    // print(
                                                    //     'ITems ${items['rate'] == ""}');
                                                    if (!(items['seaterBeds'] ==
                                                        "")) {
                                                      room.seater_beds =
                                                          int.parse(items[
                                                              'seaterBeds']!);
                                                    }
                                                    if (items['seaterBeds'] ==
                                                        "") {
                                                      room.seater_beds =
                                                          room.seater_beds;
                                                    }
                                                    if (!(items['rate'] ==
                                                        "")) {
                                                      room.monthly_rate =
                                                          int.parse(
                                                              items['rate']!);
                                                    }
                                                    if (items['rate'] == "") {
                                                      room.monthly_rate =
                                                          room.monthly_rate!;
                                                    }
                                                    print(items);
                                                    print(room);
                                                    context.read<
                                                        AddHotelWithoutTierBloc>()
                                                      ..add(
                                                          UpdateHotelRoomWithoutTierHitEvent(
                                                              index: index + 1,
                                                              room: room));
                                                    Navigator.pop(context);
                                                    customScaffold(
                                                        context: context,
                                                        title: "Success",
                                                        message:
                                                            "Successfully Updated",
                                                        contentType: ContentType
                                                            .success);
                                                  }
                                                },
                                                child: Text("Update"),
                                                backgroundColor:
                                                    Color(0xff514f53),
                                                textColor: Colors.white,
                                                height: 45)
                                          ],
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          );
        },
      );
    }

    Future<dynamic> roomImageChanger(BuildContext context, Room room) {
      return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return BlocProvider(
            create: (context) => ImageHelperCubit()
              ..imageHelperAccess(imageHelper: ImageHelper()),
            child: Builder(builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(40),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomPoppinsText(
                        text: "Add your room data",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff514f53),
                      ),
                      CustomMaterialButton(
                          onPressed: () async {
                            var imageHelper = await context
                                .read<ImageHelperCubit>()
                                .state
                                .imageHelper!;
                            final files = await imageHelper.pickImage();
                            if (files.isNotEmpty) {
                              final croppedFile = await imageHelper.crop(
                                  file: files.first,
                                  cropStyle: CropStyle.rectangle);
                              context.read<AddHotelWithoutTierBloc>()
                                ..add(HostelWithoutTierChangePictureHitEvent(
                                    index: room.id!,
                                    roomImage: File(croppedFile!.path)));
                              Navigator.pop(context);
                              customScaffold(
                                  context: context,
                                  title: "Success",
                                  message: "Successfully Changed Image",
                                  contentType: ContentType.success);
                            }
                          },
                          child: Text("Add Images"),
                          backgroundColor: Color(0xff514f53),
                          textColor: Colors.white,
                          height: 47)
                    ],
                  ),
                ),
              );
            }),
          );
        },
      );
    }

    Widget customRoomCard({required BuildContext context, required int index}) {
      return BlocBuilder<AddHotelWithoutTierBloc, AddHotelWithoutTierState>(
        builder: (context, state) {
          Room room = state.room![index]!;
          return Slidable(
            closeOnScroll: true,
            endActionPane: ActionPane(
              extentRatio: 1,
              motion: ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) async {
                    await updateNonTierHotelRooms(
                        context, index, state.room![index]!);
                  },
                  foregroundColor: Color(0xff878e92),
                  icon: Icons.edit,
                  label: 'Edit',
                ),
                SlidableAction(
                  onPressed: (context) {
                    context.read<AddHotelWithoutTierBloc>()
                      ..add(ClearHotelWithoutTierAdditionEvent(room: room));
                    // Navigator.pop(context)
                    customScaffold(
                        context: context,
                        title: "Success",
                        message: "Successfully Deleted",
                        contentType: ContentType.success);
                  },
                  foregroundColor: Color(0xff514f53),
                  icon: Icons.delete,
                  label: 'Delete',
                ),
                BlocProvider(
                  create: (context) => ImageHelperCubit()
                    ..imageHelperAccess(imageHelper: ImageHelper()),
                  child: Builder(builder: (context) {
                    return SlidableAction(
                      onPressed: (context) async {
                        roomImageChanger(context, room);
                      },
                      foregroundColor: Color(0xff514f53),
                      icon: Icons.image,
                      label: 'Change',
                    );
                  }),
                ),
              ],
            ),
            child: Container(
                padding: EdgeInsets.all(10),
                child: Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    title: ListTile(
                      leading: Image.file(state.roomImages?[context
                          .watch<AddHotelWithoutTierBloc>()
                          .state
                          .room![index]!
                          .id]![0]),
                      subtitle: CustomPoppinsText(
                          text:
                              "This room has ${room.seater_beds!} at ${room.monthly_rate} ruppess",
                          fontSize: 11,
                          fontWeight: FontWeight.w400),
                      title: CustomPoppinsText(
                          text: "Room ${index}",
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomCheckBoxDetailTile(
                                  icon: FontAwesomeIcons.fan,
                                  text: "Fan",
                                  value: state.room![index]!.fan_availability!,
                                ),
                                CustomCheckBoxDetailTile(
                                  icon: Icons.ac_unit,
                                  text: "A.C",
                                  value: state.room![index]!.ac_availability!,
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
                                  value: state
                                      .room![index]!.milk_powder_availability!,
                                ),
                                CustomCheckBoxDetailTile(
                                  icon: FontAwesomeIcons.jar,
                                  text: "Kettle",
                                  value:
                                      state.room![index]!.kettle_availability!,
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
                                  value: state
                                      .room![index]!.steam_iron_availability!,
                                ),
                                CustomCheckBoxDetailTile(
                                  icon: Icons.hot_tub,
                                  text: "Tea",
                                  value: state
                                      .room![index]!.tea_powder_availability!,
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
                                  value: state
                                      .room![index]!.water_bottle_availability!,
                                ),
                                CustomCheckBoxDetailTile(
                                  icon: Icons.coffee,
                                  text: "Coffee",
                                  value: state.room![index]!
                                      .coffee_powder_availability!,
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
                                  value: state
                                      .room![index]!.hair_dryer_availability!,
                                ),
                                CustomCheckBoxDetailTile(
                                  icon: Icons.tv,
                                  text: "T.V",
                                  value: state.room![index]!.tv_availability!,
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          );
        },
      );
    }

    Widget roomViewLogin({required BuildContext context}) {
      return BlocBuilder<AddHotelWithoutTierBloc, AddHotelWithoutTierState>(
        builder: (context, state) {
          if (state.room != null) {
            return Column(
              children: [
                CustomPoppinsText(
                    text: "Added Rooms",
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.room!.length,
                  itemBuilder: (context, index) {
                    return customRoomCard(index: index, context: context);
                  },
                ),
              ],
            );
          }
          return Column(
            children: [],
          );
        },
      );
    }

    Future<dynamic> addNonTierHotelRooms(BuildContext context) {
      return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => FormBloc()..add(InitEvent()),
              ),
              BlocProvider(
                create: (context) => ImageHelperCubit()
                  ..imageHelperAccess(imageHelper: ImageHelper()),
              ),
              BlocProvider(
                create: (context) => RoomAdditionCubit(),
              ),
              BlocProvider(
                create: (context) => StoreImagesCubit(),
              ),
            ],
            child: Builder(builder: (context) {
              return Form(
                key: context.read<FormBloc>().state.formKey,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        context.watch<StoreImagesCubit>().state.images.isEmpty
                            ? Column(
                                children: [
                                  CustomPoppinsText(
                                      text: "Room Details",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CustomPoppinsText(
                                      text:
                                          "Note : You need to add a image of the room",
                                      fontSize: 12,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ],
                              )
                            : Column(
                                children: [
                                  Arc(
                                    height: 50,
                                    arcType: ArcType.CONVEX,
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2.5,
                                      decoration: BoxDecoration(
                                          color: Color(0xff32454D),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: FileImage(context
                                                  .watch<StoreImagesCubit>()
                                                  .state
                                                  .images[0]))),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  CustomPoppinsText(
                                      text: "Room Details",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ],
                              ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 1.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Column(
                                  children: [
                                    CustomFormField(
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      prefixIcon: Icon(Icons.bed),
                                      keyboardType: TextInputType.number,
                                      onChange: (p0) {
                                        context.read<FormBloc>()
                                          ..add(BedChangedEvent(
                                              bedChanged:
                                                  BlocFormItem(value: p0!)));
                                      },
                                      onTapOutside: (p0) =>
                                          FocusScope.of(context).unfocus(),
                                      validatior: (p0) {
                                        if (p0!.isEmpty || p0 == "") {
                                          return "Seater Beds cannot be null";
                                        }
                                        if (!(p0.isValidNumber)) {
                                          return "Invalid Number";
                                        }
                                        if (int.parse(p0) <= 0) {
                                          return "Invalid Beds";
                                        }
                                        if (int.parse(p0) > 5) {
                                          return "Cannot have more than 5 beds";
                                        }
                                        return null;
                                      },
                                      labelText: "Seater Beds",
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    CustomFormField(
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      prefixIcon: Icon(Icons.bed),
                                      keyboardType: TextInputType.number,
                                      onChange: (p0) {
                                        context.read<FormBloc>()
                                          ..add(RateChangedEvent(
                                              rate: BlocFormItem(value: p0!)));
                                      },
                                      onTapOutside: (p0) =>
                                          FocusScope.of(context).unfocus(),
                                      validatior: (p0) {
                                        if (p0!.isEmpty || p0 == "") {
                                          return "Per Day Rent cannot be null";
                                        }
                                        if (!(p0.isValidNumber)) {
                                          return "Invalid Number";
                                        }
                                        if (int.parse(p0) <= 1000) {
                                          return "Rent can't be lesser than 1000";
                                        }
                                        return null;
                                      },
                                      labelText: "Per Day Rent",
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              CustomPoppinsText(
                                  text:
                                      "Note : Select the available features for the room",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: BlocBuilder<RoomAdditionCubit,
                                    RoomAdditionState>(
                                  builder: (context, state) {
                                    return Column(
                                      children: [
                                        CustomWidgetRow(
                                          widget1: CustomCheckBoxTile(
                                              title: "A.C",
                                              onChanged: (value) {
                                                if (state.room != null) {
                                                  context
                                                      .read<RoomAdditionCubit>()
                                                      .RoomUpdate(state.room!
                                                          .copyWith(
                                                              ac_availability:
                                                                  (value!)));
                                                }
                                              },
                                              value:
                                                  state.room!.ac_availability!,
                                              icon: Icons.ac_unit),
                                          widget2: CustomCheckBoxTile(
                                              title: "Steam Iron",
                                              onChanged: (value) {
                                                if (state.room != null) {
                                                  context
                                                      .read<RoomAdditionCubit>()
                                                      .RoomUpdate(state.room!
                                                          .copyWith(
                                                              steam_iron_availability:
                                                                  (value!)));
                                                }
                                              },
                                              value: state.room!
                                                  .steam_iron_availability!,
                                              icon: Icons.iron),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        CustomWidgetRow(
                                          widget1: CustomCheckBoxTile(
                                              title: "Water Bottle",
                                              onChanged: (value) {
                                                if (state.room != null) {
                                                  context
                                                      .read<RoomAdditionCubit>()
                                                      .RoomUpdate(state.room!
                                                          .copyWith(
                                                              water_bottle_availability:
                                                                  (value!)));
                                                }
                                              },
                                              value: state.room!
                                                  .water_bottle_availability!,
                                              icon:
                                                  FontAwesomeIcons.bottleWater),
                                          widget2: CustomCheckBoxTile(
                                              title: "Fan",
                                              onChanged: (value) {
                                                if (state.room != null) {
                                                  context
                                                      .read<RoomAdditionCubit>()
                                                      .RoomUpdate(state.room!
                                                          .copyWith(
                                                              fan_availability:
                                                                  (value!)));
                                                }
                                              },
                                              value:
                                                  state.room!.fan_availability!,
                                              icon: FontAwesomeIcons.fan),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        CustomWidgetRow(
                                            widget1: CustomCheckBoxTile(
                                                title: "Coffee Powder",
                                                onChanged: (value) {
                                                  if (state.room != null) {
                                                    context
                                                        .read<
                                                            RoomAdditionCubit>()
                                                        .RoomUpdate(state.room!
                                                            .copyWith(
                                                                coffee_powder_availability:
                                                                    (value!)));
                                                  }
                                                },
                                                value: state.room!
                                                    .coffee_powder_availability!,
                                                icon: Icons.coffee),
                                            widget2: CustomCheckBoxTile(
                                                title: "Tea Powder",
                                                onChanged: (value) {
                                                  if (state.room != null) {
                                                    context
                                                        .read<
                                                            RoomAdditionCubit>()
                                                        .RoomUpdate(state.room!
                                                            .copyWith(
                                                                tea_powder_availability:
                                                                    (value!)));
                                                  }
                                                },
                                                value: state.room!
                                                    .tea_powder_availability!,
                                                icon: CupertinoIcons.ticket)),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        CustomWidgetRow(
                                          widget1: CustomCheckBoxTile(
                                              title: "Tv",
                                              onChanged: (value) {
                                                if (state.room != null) {
                                                  context
                                                      .read<RoomAdditionCubit>()
                                                      .RoomUpdate(state.room!
                                                          .copyWith(
                                                              tv_availability:
                                                                  (value!)));
                                                }
                                              },
                                              value:
                                                  state.room!.tv_availability!,
                                              icon: Icons.tv),
                                          widget2: CustomCheckBoxTile(
                                              title: "Hair Dryer",
                                              onChanged: (value) {
                                                if (state.room != null) {
                                                  context
                                                      .read<RoomAdditionCubit>()
                                                      .RoomUpdate(state.room!
                                                          .copyWith(
                                                              hair_dryer_availability:
                                                                  (value!)));
                                                }
                                              },
                                              value: state.room!
                                                  .hair_dryer_availability!,
                                              icon: FontAwesomeIcons.hotjar),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        CustomWidgetRow(
                                          widget1: CustomCheckBoxTile(
                                              title: "Water Kettle",
                                              onChanged: (value) {
                                                if (state.room != null) {
                                                  context
                                                      .read<RoomAdditionCubit>()
                                                      .RoomUpdate(state.room!
                                                          .copyWith(
                                                              kettle_availability:
                                                                  (value!)));
                                                }
                                              },
                                              value: state
                                                  .room!.kettle_availability!,
                                              icon: Icons.hot_tub),
                                          widget2: CustomCheckBoxTile(
                                              title: "Milk powder",
                                              onChanged: (value) {
                                                if (state.room != null) {
                                                  context
                                                      .read<RoomAdditionCubit>()
                                                      .RoomUpdate(state.room!
                                                          .copyWith(
                                                              milk_powder_availability:
                                                                  (value!)));
                                                }
                                              },
                                              value: state.room!
                                                  .milk_powder_availability!,
                                              icon: Icons.water),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomWidgetRow(
                                    widget1: CustomMaterialButton(
                                        onPressed: () async {
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
                                            print(
                                                "This is cropped file ${croppedFile}");
                                            if (croppedFile != null) {
                                              context.read<StoreImagesCubit>()
                                                ..clearImages();
                                              context.read<StoreImagesCubit>()
                                                ..addImages(
                                                    [File(croppedFile.path)]);
                                            }
                                          }
                                        },
                                        child: Text("Add Image"),
                                        backgroundColor: Color(0xff32454D),
                                        textColor: Colors.white,
                                        height: 45),
                                    widget2: CustomMaterialButton(
                                        onPressed: () {
                                          var key = context
                                              .read<FormBloc>()
                                              .state
                                              .formKey;
                                          if (key!.currentState!.validate()) {
                                            String seaterBeds = context
                                                .read<FormBloc>()
                                                .state
                                                .bedCount
                                                .value;
                                            String rate = context
                                                .read<FormBloc>()
                                                .state
                                                .rate
                                                .value;
                                            List<File> roomImages = context
                                                .read<StoreImagesCubit>()
                                                .state
                                                .images;
                                            if (!(roomImages.isEmpty)) {
                                              File roomImage = roomImages[0];
                                              Room room = context
                                                  .read<RoomAdditionCubit>()
                                                  .state
                                                  .room!;
                                              room.seater_beds =
                                                  int.parse(seaterBeds);
                                              room.monthly_rate =
                                                  int.parse(rate);
                                              context
                                                  .read<
                                                      AddHotelWithoutTierBloc>()
                                                  .add(
                                                      AddHotelWithoutTierHitEvent(
                                                          room: room,
                                                          roomImage:
                                                              roomImage));
                                              Navigator.pop(context);
                                              customScaffold(
                                                  context: context,
                                                  title: "Success",
                                                  message:
                                                      "Room successfully added",
                                                  contentType:
                                                      ContentType.success);
                                            }
                                          }
                                        },
                                        child: Text("Confirm Addition"),
                                        backgroundColor: Color(0xff32454D),
                                        textColor: Colors.white,
                                        height: 45)),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          );
        },
      );
    }

    return WillPopScope(
      onWillPop: () {
        int count = 0;
        return showExitPopup(
          context: context,
          message: "Are you sure you want to exit",
          noBtnFunction: () => Navigator.pop(context),
          title: "Confirmation",
          yesBtnFunction: () {
            Navigator.of(context).popUntil((_) => count++ >= 7);
          },
        );
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Arc(
                height: 50,
                arcType: ArcType.CONVEX,
                child: Container(
                  height: MediaQuery.of(context).size.height / 2.5,
                  decoration: BoxDecoration(
                      color: Color(0xff32454D),
                      image: DecorationImage(
                          image: AssetImage(
                              "assets/images/Hotel_Booking-bro.png"))),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CustomPoppinsText(
                  text: "Please add respective rooms of your hotel",
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
              SizedBox(
                height: 20,
              ),
              context.read<AddHotelWithoutTierBloc>().state.room == null ||
                      context.read<AddHotelWithoutTierBloc>().state.room == []
                  ? SizedBox()
                  : roomViewLogin(context: context),
              // ListView.builder(itemBuilder: )

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: CustomMaterialButton(
                    onPressed: () {
                      addNonTierHotelRooms(context);
                    },
                    child: Icon(Icons.add),
                    backgroundColor: Color(0xff32454D),
                    textColor: Colors.white,
                    height: 45),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomCheckBoxDetailTile extends StatelessWidget {
  const CustomCheckBoxDetailTile({
    super.key,
    required this.value,
    required this.text,
    required this.icon,
  });

  final bool value;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      // padding: ,
      child: Row(
        children: [
          Container(
            height: 50,
            width: 100,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: value
                  ? Colors.blue.withOpacity(0.1)
                  : Colors.blue.withOpacity(0.11),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: Colors.black.withOpacity(0.5),
                  size: 16,
                ),
                SizedBox(
                  width: 20,
                ),
                CustomPoppinsText(
                    text: text, fontSize: 12, fontWeight: FontWeight.w400),
              ],
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Icon(
            value ? Icons.verified : Icons.clear,
            color: value ? Colors.blue : Colors.red,
          )
        ],
      ),
    );
  }
}
