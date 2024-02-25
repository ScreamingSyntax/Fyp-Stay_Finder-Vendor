import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stayfinder_vendor/constants/extensions.dart';
import 'package:stayfinder_vendor/logic/blocs/add_hotel_with_tier/add_hotel_with_tier_bloc_bloc.dart';
import 'package:stayfinder_vendor/logic/blocs/bloc_exports.dart';
import 'package:stayfinder_vendor/logic/cubits/room_addition/room_addition_cubit.dart';
import 'package:stayfinder_vendor/logic/cubits/store_images/store_images_cubit.dart';
import 'package:stayfinder_vendor/logic/cubits/store_rooms/store_rooms_cubit.dart';
import 'package:stayfinder_vendor/presentation/widgets/widgets_exports.dart';

import '../../../data/api/api_exports.dart';
import '../../../data/model/model_exports.dart';
import '../../../logic/cubits/cubit_exports.dart';
import '../../config/config_exports.dart';

class AddTierScreen extends StatelessWidget {
  Future<dynamic> updateTierHotelRooms(
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
                    coffee_powder_availability: room.coffee_powder_availability,
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
                      BlocBuilder<StoreRoomsCubit, StoreRoomsState>(
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
                                  initialValue: state.rooms![index].seater_beds
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
                                  initialValue: state.rooms![index].monthly_rate
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
                                                        .RoomUpdate(state.room!
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
                                                        .RoomUpdate(state.room!
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
                                                        .RoomUpdate(state.room!
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
                                                        .RoomUpdate(state.room!
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
                                                        .read<
                                                            RoomAdditionCubit>()
                                                        .RoomUpdate(state.room!
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
                                                        .RoomUpdate(state.room!
                                                            .copyWith(
                                                                hair_dryer_availability:
                                                                    value));
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
                                                        .read<
                                                            RoomAdditionCubit>()
                                                        .RoomUpdate(state.room!
                                                            .copyWith(
                                                                kettle_availability:
                                                                    value));
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
                                                        .read<
                                                            RoomAdditionCubit>()
                                                        .RoomUpdate(state.room!
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
                                                      .read<RoomAdditionCubit>()
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
                                                  Map<String, String> items = {
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
                                                  if (!(items['rate'] == "")) {
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
                                                  context
                                                      .read<StoreRoomsCubit>()
                                                    ..edit(index, room);
                                                  Navigator.pop(context);
                                                  customScaffold(
                                                      context: context,
                                                      title: "Success",
                                                      message:
                                                          "Successfully Updated",
                                                      contentType:
                                                          ContentType.success);
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

  Future<dynamic> addTierHotelRooms(BuildContext context) {
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 1.0),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
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
                                            value: state.room!.ac_availability!,
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
                                            value: state
                                                .room!.steam_iron_availability!,
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
                                            icon: FontAwesomeIcons.bottleWater),
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
                                                      .read<RoomAdditionCubit>()
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
                                                      .read<RoomAdditionCubit>()
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
                                            value: state.room!.tv_availability!,
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
                                            value: state
                                                .room!.hair_dryer_availability!,
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
                                child: CustomMaterialButton(
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
                                        Room room = context
                                            .read<RoomAdditionCubit>()
                                            .state
                                            .room!;
                                        room.seater_beds =
                                            int.parse(seaterBeds);
                                        room.monthly_rate = int.parse(rate);
                                        context
                                            .read<StoreRoomsCubit>()
                                            .addRooms(room);
                                        Navigator.pop(context);
                                        customScaffold(
                                            context: context,
                                            title: "Success",
                                            message: "Successfully Added Room",
                                            contentType: ContentType.success);
                                      }
                                      // }
                                    },
                                    child: Text("Confirm Addition"),
                                    backgroundColor: Color(0xff32454D),
                                    textColor: Colors.white,
                                    height: 45)),
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

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FormBloc()..add(InitEvent()),
        ),
        BlocProvider(
          create: (context) => StoreImagesCubit(),
        ),
        BlocProvider(
          create: (context) =>
              ImageHelperCubit()..imageHelperAccess(imageHelper: ImageHelper()),
        ),
      ],
      child: Builder(builder: (context) {
        return Form(
          key: context.watch<FormBloc>().state.formKey,
          child: Scaffold(
            bottomNavigationBar: SizedBox(
              height: 90,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: SizedBox(
                  height: 60,
                  child: CustomMaterialButton(
                      onPressed: () {
                        List<Room>? rooms =
                            context.read<StoreRoomsCubit>().state.rooms;
                        List<File?>? tierImage =
                            context.read<StoreImagesCubit>().state.images;
                        String tierName =
                            context.read<FormBloc>().state.name.value;
                        String city = context.read<FormBloc>().state.city.value;
                        if (rooms == null || rooms.isEmpty) {
                          customScaffold(
                              context: context,
                              title: "Warning",
                              message: "Add some rooms first",
                              contentType: ContentType.warning);
                          return;
                        }
                        if (tierImage.isEmpty) {
                          customScaffold(
                              context: context,
                              title: "Warning",
                              message: "Add tier image first",
                              contentType: ContentType.warning);
                          return;
                        }
                        ;

                        // Navigator.pop(context);
                        showExitPopup(
                          context: context,
                          message:
                              "Are you sure you've checked all the added tier data",
                          title: "Confirmation",
                          noBtnFunction: () {
                            Navigator.pop(context);
                          },
                          yesBtnFunction: () {
                            int count = 0;
                            context.read<AddHotelWithTierBlocBloc>()
                              ..add(AddHotelTierWithTierEvent(
                                  tier: Tier(name: tierName, description: city),
                                  rooms: rooms,
                                  tierImage: tierImage[0]!));
                            Navigator.of(context).popUntil((_) => count++ >= 2);
                          },
                        );
                      },
                      child: Text("Confirm Addition"),
                      backgroundColor: Color(0xff32454D),
                      textColor: Colors.white,
                      height: 45),
                ),
              ),
            ),
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  context.watch<StoreImagesCubit>().state.images.isNotEmpty
                      ? Column(
                          children: [
                            topImageLogic(
                                context,
                                context
                                    .watch<StoreImagesCubit>()
                                    .state
                                    .images[0]),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        )
                      : SizedBox(
                          height: 40,
                        ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
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
                              color: Colors.black,
                            ),
                          ),
                          CustomPoppinsText(
                              text: "Add Tier and It's Room",
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                          SizedBox(
                            width: 2,
                          )
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        CustomFormField(
                          onTapOutside: (p0) =>
                              FocusScope.of(context).unfocus(),
                          validatior: (p0) {
                            print("The value of p is ${p0}");
                            if (p0!.isEmpty) {
                              return "Tier name can't be null";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                          inputFormatters: [
                            FilteringTextInputFormatter.singleLineFormatter
                          ],
                          prefixIcon: Icon(Boxicons.bx_star),
                          labelText: "Tier Name",
                          onChange: (p0) => context.read<FormBloc>()
                            ..add(NameChangedEvent(
                                name: BlocFormItem(value: p0!))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomFormField(
                          onTapOutside: (p0) =>
                              FocusScope.of(context).unfocus(),
                          validatior: (p0) {
                            if (p0!.isEmpty) {
                              return "Description can't be null";
                            }
                            String p1 = p0.trim();
                            print("The value of p1 is ${p1.length}");
                            if (p1.length < 6) {
                              return "Description is too less";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                          inputFormatters: [
                            FilteringTextInputFormatter.singleLineFormatter
                          ],
                          onChange: (p0) => context.read<FormBloc>()
                            ..add(CityChangedEvent(
                                city: BlocFormItem(value: p0!))),
                          prefixIcon: Icon(Boxicons.bx_star),
                          labelText: "Description",
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2.9,
                                child: CustomMaterialButton(
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
                                                cropStyle: CropStyle.rectangle);
                                        print(
                                            "This is cropped file ${croppedFile}");
                                        if (croppedFile != null) {
                                          context.read<StoreImagesCubit>()
                                            ..addImages(
                                                [File(croppedFile.path)]);
                                        }
                                      }
                                    },
                                    child: Text("Add Image"),
                                    backgroundColor:
                                        Color(0xff32454D).withOpacity(0.6),
                                    textColor: Colors.white,
                                    height: 45),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: CustomMaterialButton(
                                    onPressed: () {
                                      var formKey = context
                                          .read<FormBloc>()
                                          .state
                                          .formKey;
                                      print("The form key is ${formKey}");
                                      if (formKey!.currentState!.validate()) {
                                        addTierHotelRooms(context);
                                      } else {
                                        customScaffold(
                                            context: context,
                                            title: "Warning",
                                            message:
                                                "Please fill the upper details first",
                                            contentType: ContentType.warning);
                                      }
                                    },
                                    child: Text("Add room"),
                                    backgroundColor:
                                        Color(0xff32454D).withOpacity(0.6),
                                    textColor: Colors.white,
                                    height: 45),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Text(data)
                  context.watch<StoreRoomsCubit>().state.rooms!.isNotEmpty
                      ? showTierRooms(context)
                      : SizedBox(),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget topImageLogic(BuildContext context, File image) {
    return Arc(
      height: 50,
      arcType: ArcType.CONVEX,
      child: Container(
        height: MediaQuery.of(context).size.height / 2.5,
        decoration: BoxDecoration(
            color: Color(0xff32454D),
            image: DecorationImage(image: FileImage(image), fit: BoxFit.cover)),
      ),
    );
  }

  Widget showTierRooms(BuildContext context) {
    print("One");
    return Column(
      children: [
        BlocBuilder<StoreRoomsCubit, StoreRoomsState>(
          builder: (context, state) {
            return Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 30,
                ),
                CustomPoppinsText(
                    text: "Added Rooms",
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
                ListView.builder(
                  itemCount: state.rooms!.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return customRoomCard(context: context, index: index);
                  },
                ),
              ],
            );
          },
        )
      ],
    );
  }

  Widget customRoomCard({required BuildContext context, required int index}) {
    Room room = context.watch<StoreRoomsCubit>().state.rooms![index];
    return Slidable(
      closeOnScroll: true,
      endActionPane: ActionPane(
        extentRatio: 1,
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) async {
              updateTierHotelRooms(context, index, room);
              // await updateNonTierHotelRooms(
              //     context, index, state.room![index]!);
            },
            foregroundColor: Color(0xff878e92),
            icon: Icons.edit,
            label: 'Edit',
          ),
          SlidableAction(
            onPressed: (context) {
              context.read<StoreRoomsCubit>()..deleteRoom(room);
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
        ],
      ),
      child: Container(
          padding: EdgeInsets.all(10),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              title: ListTile(
                subtitle: CustomPoppinsText(
                    text:
                        "This room has ${room.seater_beds} beds and costs ${room.monthly_rate} ruppess",
                    fontSize: 11,
                    fontWeight: FontWeight.w400),
                title: CustomPoppinsText(
                    text: "Room ${index + 1} ",
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
                            value: room.fan_availability!,
                          ),
                          CustomCheckBoxDetailTile(
                            icon: Icons.ac_unit,
                            text: "A.C",
                            value: room.ac_availability!,
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
                            value: room.milk_powder_availability!,
                          ),
                          CustomCheckBoxDetailTile(
                            icon: FontAwesomeIcons.jar,
                            text: "Kettle",
                            value: room.kettle_availability!,
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
                            value: room.steam_iron_availability!,
                          ),
                          CustomCheckBoxDetailTile(
                            icon: Icons.hot_tub,
                            text: "Tea",
                            value: room.tea_powder_availability!,
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
                            value: room.water_bottle_availability!,
                          ),
                          CustomCheckBoxDetailTile(
                            icon: Icons.coffee,
                            text: "Coffee",
                            value: room.coffee_powder_availability!,
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
                            value: room.hair_dryer_availability!,
                          ),
                          CustomCheckBoxDetailTile(
                              icon: Icons.tv,
                              text: "T.V",
                              value: room.tv_availability!)
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
