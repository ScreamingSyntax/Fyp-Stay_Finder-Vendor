import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stayfinder_vendor/constants/extensions.dart';
import 'package:stayfinder_vendor/logic/cubits/fetch_hotel_with_tier/fetch_hotel_with_tier_cubit.dart';
import 'package:stayfinder_vendor/logic/cubits/update_hotel_with_tier/update_hotel_with_tier_cubit.dart';

import '../../../../../data/model/model_exports.dart';
import '../../../../../logic/blocs/bloc_exports.dart';
import '../../../../../logic/cubits/cubit_exports.dart';
import '../../../../../logic/cubits/fetch_hotel_without_tier/fetch_hotel_without_tier_cubit.dart';
import '../../../../../logic/cubits/room_addition/room_addition_cubit.dart';
import '../../../../../logic/cubits/store_images/store_images_cubit.dart';
import '../../../../../logic/cubits/store_rooms/store_rooms_cubit.dart';
import '../../../../widgets/widgets_exports.dart';
import 'api_call.dart';

class HotelWithTierRoomsView extends StatelessWidget {
  final Map data;

  const HotelWithTierRoomsView({super.key, required this.data});

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
                                        print(rate);
                                        Room room = context
                                            .read<RoomAdditionCubit>()
                                            .state
                                            .room!;
                                        room.seater_beds =
                                            int.parse(seaterBeds);
                                        room.monthly_rate = int.parse(rate);
                                        // print("This is hotel tier ${data}")
                                        Map dataL = {
                                          'hoteltier_id':
                                              data['tier'].toString(),
                                          'ac_availability':
                                              room.ac_availability.toString(),
                                          'water_bottle_availability': room
                                              .water_bottle_availability
                                              .toString(),
                                          'steam_iron_availability': room
                                              .steam_iron_availability
                                              .toString(),
                                          'seater_beds':
                                              room.seater_beds.toString(),
                                          'per_day_rent': rate,
                                          'fan_availability':
                                              room.fan_availability.toString(),
                                          'dustbin_availability': room
                                              .dustbin_availability
                                              .toString(),
                                          'kettle_availability': room
                                              .kettle_availability
                                              .toString(),
                                          'coffee_powder_availability': room
                                              .coffee_powder_availability
                                              .toString(),
                                          'milk_powder_availability': room
                                              .milk_powder_availability
                                              .toString(),
                                          'tea_powder_availability': room
                                              .tea_powder_availability
                                              .toString(),
                                          'hair_dryer_availability': room
                                              .hair_dryer_availability
                                              .toString(),
                                          'tv_availability':
                                              room.tv_availability.toString(),
                                        };
                                        print(dataL);
                                        context.read<UpdateHotelWithTierCubit>()
                                          ..addTierRooms(
                                              data: dataL,
                                              token: data['token']);
                                        Navigator.pop(context);
                                        // context
                                        //     .read<StoreRoomsCubit>()
                                        //     .addRooms(room);
                                        // Navigator.pop(context);
                                        // customScaffold(
                                        //     context: context,
                                        //     title: "Success",
                                        //     message: "Successfully Added Room",
                                        //     contentType: ContentType.success);
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
                    id: room.id,
                    per_day_rent: room.per_day_rent,
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
                                  initialValue: room.seater_beds.toString(),
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
                                  initialValue: room.per_day_rent.toString(),
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
                                CustomFormField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  initialValue: room.room_count.toString(),
                                  prefixIcon: Icon(Icons.bed),
                                  keyboardType: TextInputType.number,
                                  onChange: (p0) {
                                    context.read<FormBloc>()
                                      ..add(MealsPerDayChangedEvent(
                                          mealsPerDay:
                                              BlocFormItem(value: p0!)));
                                  },
                                  onTapOutside: (p0) =>
                                      FocusScope.of(context).unfocus(),
                                  validatior: (p0) {
                                    if (p0!.isEmpty || p0 == "") {
                                      return "Room Count cannot be null";
                                    }
                                    if (!(p0.isValidNumber)) {
                                      return "Invalid Number";
                                    }
                                    if (int.parse(p0) < 0) {
                                      return "Invalid Room Count";
                                    }
                                    return null;
                                  },
                                  labelText: "Room Count",
                                ),
                                SizedBox(
                                  height: 20,
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
                                                  String room_count = context
                                                      .read<FormBloc>()
                                                      .state
                                                      .mealsPerDay
                                                      .value;
                                                  Map<String, String> items = {
                                                    "seaterBeds": seaterBeds,
                                                    "rate": rate,
                                                    "room_count": room_count
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
                                                    room.per_day_rent =
                                                        int.parse(
                                                            items['rate']!);
                                                  }
                                                  if (items['rate'] == "") {
                                                    room.per_day_rent =
                                                        room.per_day_rent!;
                                                  }
                                                  if (!(items['room_count'] ==
                                                      "")) {
                                                    room.room_count = int.parse(
                                                        items['room_count']!);
                                                  }
                                                  if (items['room_count'] ==
                                                      "") {
                                                    room.room_count =
                                                        room.room_count!;
                                                  }
                                                  Map dataL = {
                                                    'room_id': room.id,
                                                    'ac_availability': room
                                                        .ac_availability
                                                        .toString(),
                                                    'water_bottle_availability':
                                                        room.water_bottle_availability
                                                            .toString(),
                                                    'steam_iron_availability': room
                                                        .steam_iron_availability
                                                        .toString(),
                                                    'seater_beds': room
                                                        .seater_beds
                                                        .toString(),
                                                    'per_day_rent': room
                                                        .per_day_rent
                                                        .toString(),
                                                    'fan_availability': room
                                                        .fan_availability
                                                        .toString(),
                                                    'dustbin_availability': room
                                                        .dustbin_availability
                                                        .toString(),
                                                    'kettle_availability': room
                                                        .kettle_availability
                                                        .toString(),
                                                    'coffee_powder_availability':
                                                        room.coffee_powder_availability
                                                            .toString(),
                                                    'milk_powder_availability': room
                                                        .milk_powder_availability
                                                        .toString(),
                                                    'tea_powder_availability': room
                                                        .tea_powder_availability
                                                        .toString(),
                                                    'hair_dryer_availability': room
                                                        .hair_dryer_availability
                                                        .toString(),
                                                    'tv_availability': room
                                                        .tv_availability
                                                        .toString(),
                                                    'room_count': room
                                                        .room_count
                                                        .toString()
                                                  };
                                                  // print(items);
                                                  print(dataL);
                                                  context.read<
                                                      UpdateHotelWithTierCubit>()
                                                    ..updateHotelWithTierTierRoom(
                                                        token: data['token'],
                                                        data: dataL);
                                                  // context
                                                  //     .read<StoreRoomsCubit>()
                                                  //   ..edit(index, room);
                                                  Navigator.pop(context);
                                                  // customScaffold(
                                                  //     context: context,
                                                  //     title: "Success",
                                                  //     message:
                                                  //         "Successfully Updated",
                                                  //     contentType:
                                                  //         ContentType.success);
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

  Widget customRoomCard(
      {required BuildContext context, required Room room, required int index}) {
    return Slidable(
      closeOnScroll: true,
      endActionPane: ActionPane(
        extentRatio: 1,
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) async {
              // await updateTierHotelRooms(context, index, room);
              // print(room);
              updateTierHotelRooms(context, index, room);
              // await updateNonTierHotelRooms(
              // context, index, state.room![index]!);
            },
            foregroundColor: Color(0xff878e92),
            icon: Icons.edit,
            label: 'Edit',
          ),
          SlidableAction(
            onPressed: (context) {
              context.read<UpdateHotelWithTierCubit>()
                ..deleteRoom(token: data['token'], roomID: room.id.toString());
              // context.read<StoreRoomsCubit>()..deleteRoom(room);
              // customScaffold(
              //     context: context,
              //     title: "Success",
              //     message: "Successfully Deleted",
              //     contentType: ContentType.success);
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
                        "This room has ${room.seater_beds} beds and costs ${room.per_day_rent} ruppess",
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
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CustomPoppinsText(
                            text: "Room Count ${room.room_count}",
                            fontSize: 11,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 10,
                      ),
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffe5e5e5),
        body: RefreshIndicator(
          onRefresh: () async {
            CallHotelWithTierAPi.fetchHotelWithTierApis(
                context: context,
                accommodationID: data['id'],
                token: data['token']);
          },
          child: SingleChildScrollView(
            child:
                BlocBuilder<FetchHotelWithTierCubit, FetchHotelWithTierState>(
              builder: (context, hotelWithoutTierState) {
                if (hotelWithoutTierState is FetchHotelTierLoading) {
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [CircularProgressIndicator()],
                    ),
                  );
                }
                if (hotelWithoutTierState is FetchHotelTierSuccess) {
                  // print(hotelWithoutTierState.room[0].)
                  // List<Room> TierRooms = List<Room>.from(
                  //         hotelWithoutTierState.room)
                  //     .where((element) => element.hotel_tier == data['tier'])
                  //     .toList();
                  List<Room> tierRooms =
                      List<Room>.from(hotelWithoutTierState.room)
                          .where(
                            (element) => element.hotel_tier == data['tier'],
                          )
                          .toList();
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(Icons.arrow_back)),
                            InkWell(
                                onTap: () {
                                  addTierHotelRooms(context);
                                },
                                child: Icon(Icons.add))
                          ],
                        ),
                      ),
                      BlocBuilder<FetchHotelWithoutTierCubit,
                          FetchHotelWithoutTierState>(
                        builder: (context, state) {
                          return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: tierRooms.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              // Room room = TierRooms[index];

                              // String image = "";
                              // hotelWithoutTierState.image.forEach((roomImage) {
                              //   if (roomImage.room == room.id) {
                              //     image = roomImage.images!;
                              //   }
                              return customRoomCard(
                                  context: context,
                                  index: index,
                                  room: tierRooms[index]);

                              // });
                              // return Padding(
                              //     padding: const EdgeInsets.all(8.0),
                              //     child: customRoomCard(
                              //         context: context,
                              //         index: index + 1,
                              //         room: room,
                              //         image: image));
                            },
                          );
                        },
                      ),
                    ],
                  );
                }
                if (hotelWithoutTierState is FetchHotelWithTierError) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          hotelWithoutTierState.message,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
                          child: CustomMaterialButton(
                              onPressed: () {
                                CallHotelWithTierAPi.fetchHotelWithTierApis(
                                    context: context,
                                    token: data['token'],
                                    accommodationID: data['id']);
                                // callHotelWithoutTierApis(
                                //     context: context,
                                //     token: data['token'],
                                //     accommodationID: data['id']);
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
                return Builder(builder: (context) {
                  // callHotelWithoutTierApis(
                  //     context: context,
                  //     token: data['token'],
                  //     accommodationID: data['id']);
                  return SizedBox();
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
