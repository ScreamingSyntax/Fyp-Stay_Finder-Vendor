import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stayfinder_vendor/logic/cubits/fetch_hotel_without_tier/fetch_hotel_without_tier_cubit.dart';
import 'package:stayfinder_vendor/logic/cubits/update_hotel_without_tier/update_hotel_without_tier_cubit.dart';
import 'package:stayfinder_vendor/presentation/screens/adding_accommodations/view_accommoation_screen.dart/hotel_without_tier.dart/hotel_without_tier_view.dart';
import 'package:stayfinder_vendor/presentation/widgets/widgets_exports.dart';

import '../../../../../constants/constants_exports.dart';
import '../../../../../data/api/api_exports.dart';
import '../../../../../data/model/model_exports.dart';
import '../../../../../logic/blocs/bloc_exports.dart';
import '../../../../../logic/cubits/cubit_exports.dart';
import '../../../../../logic/cubits/room_addition/room_addition_cubit.dart';
import '../../../../../logic/cubits/store_images/store_images_cubit.dart';
import '../../../../config/config_exports.dart';

class HotelWithoutTierRoomViewScreen extends StatelessWidget {
  final Map data;

  const HotelWithoutTierRoomViewScreen({super.key, required this.data});
  Future<void> callHotelApis(
      Map<dynamic, dynamic> args, BuildContext context) async {
    String token = args['token'];
    int accommodationID = args['id'];
    context
        .read<FetchHotelWithoutTierCubit>()
        .FetchHotel(accommodationId: accommodationID, token: token);
  }

  Future<dynamic> updateNonTierHotelRooms(
      BuildContext context, Room room, String token) {
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
                      // BlocBuilder<AddHotelWithoutTierBloc,
                      //     AddHotelWithoutTierState>(
                      //   builder: (context, state) {
                      Padding(
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
                                      bedChanged: BlocFormItem(value: p0!)));
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
                                                                value));
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
                                                                value));
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
                                                                value));
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
                                                                value));
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
                                                      .read<RoomAdditionCubit>()
                                                      .RoomUpdate(state.room!
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
                                                    .read<RoomAdditionCubit>()
                                                    .RoomUpdate(state.room!
                                                        .copyWith(
                                                            tv_availability:
                                                                value));
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
                                                                value));
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
                                                    .read<RoomAdditionCubit>()
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
                                              print("The rate is ${rate}");

                                              Map<String, String> items = {
                                                "seaterBeds": seaterBeds,
                                                "rate": rate
                                              };
                                              print(items);
                                              // print(
                                              //     'ITems ${items['rate'] == ""}');
                                              if (!(items['seaterBeds'] ==
                                                  "")) {
                                                room.seater_beds = int.parse(
                                                    items['seaterBeds']!);
                                              }
                                              if (items['seaterBeds'] == "") {
                                                room.seater_beds =
                                                    room.seater_beds;
                                              }
                                              if (!(items['rate'] == "")) {
                                                room.per_day_rent =
                                                    int.parse(items['rate']!);
                                              }
                                              // print(room)
                                              if (items['rate'] == "") {
                                                room.per_day_rent =
                                                    room.per_day_rent!;
                                              }
                                              print(items);
                                              print(room);
                                              [
                                                'ac_availability',
                                                'seater_beds',
                                                'per_day_rent',
                                                'fan_availability',
                                                'kettle_availability',
                                                'coffee_powder_availability',
                                                'milk_powder_availability',
                                                'tea_powder_availability',
                                                'hair_dryer_availability',
                                                'tv_availability',
                                                'images',
                                                'steam_iron_availability',
                                                'water_bottle_availability'
                                              ];
                                              Map items_data = {
                                                'room_id': room.id.toString(),
                                                'ac_availability': room
                                                    .ac_availability
                                                    .toString(),
                                                'seater_beds':
                                                    room.seater_beds.toString(),
                                                'per_day_rent': room
                                                    .per_day_rent
                                                    .toString(),
                                                'fan_availability': room
                                                    .fan_availability
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
                                                'tv_availability': room
                                                    .tv_availability
                                                    .toString(),
                                                'steam_iron_availability': room
                                                    .steam_iron_availability
                                                    .toString(),
                                                'water_bottle_availability': room
                                                    .water_bottle_availability
                                                    .toString()
                                              };
                                              context.read<
                                                  UpdateHotelWithoutTierCubit>()
                                                ..updateRoomDetails(
                                                    token: token,
                                                    data: items_data);
                                              // context.read<
                                              //     AddHotelWithoutTierBloc>()
                                              //   ..add(
                                              //       UpdateHotelRoomWithoutTierHitEvent(
                                              //           index: index + 1,
                                              //           room: room));
                                              Navigator.pop(context);
                                            }
                                          },
                                          child: Text("Update"),
                                          backgroundColor: Color(0xff514f53),
                                          textColor: Colors.white,
                                          height: 45)
                                    ],
                                  );
                                },
                              ),
                            )
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

  Future<dynamic> roomImageChanger(
      BuildContext context, Room room, String token) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return BlocProvider(
          create: (context) =>
              ImageHelperCubit()..imageHelperAccess(imageHelper: ImageHelper()),
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
                            context.read<UpdateHotelWithoutTierCubit>()
                              ..updateRoomImage(
                                  image: File(croppedFile!.path),
                                  token: token,
                                  roomId: room.id!);
                            Navigator.pop(context);
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

  Future<dynamic> addNonTierHotelRooms(
      {required BuildContext context,
      required String token,
      required int accommodationId}) {
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
                                    height: MediaQuery.of(context).size.height /
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
                                      print("Form Changeed ${p0}");
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
                                      onPressed: () async {
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
                                            room.per_day_rent = int.parse(rate);
                                            await context.read<
                                                UpdateHotelWithoutTierCubit>()
                                              ..addRoomDetails(
                                                  token: token,
                                                  room: room,
                                                  roomImage: roomImage,
                                                  accommodationId:
                                                      accommodationId
                                                          .toString());

                                            Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffe5e5e5),
        body: RefreshIndicator(
          onRefresh: () async {
            await callHotelWithoutTierApis(
                context: context,
                accommodationID: data['id'],
                token: data['token']);
          },
          child: SingleChildScrollView(
            child: BlocBuilder<FetchHotelWithoutTierCubit,
                FetchHotelWithoutTierState>(
              builder: (context, hotelWithoutTierState) {
                if (hotelWithoutTierState is FetchHotelWithoutTierLoading) {
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
                if (hotelWithoutTierState is FetchHotelWithoutTierSuccess) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                                onTap: () => Navigator.pop(context),
                                child: Icon(Icons.arrow_back)),
                            InkWell(
                                onTap: () {
                                  context.read<DropDownValueCubit>()
                                    ..changeDropDownValue("Average");
                                  addNonTierHotelRooms(
                                      context: context,
                                      accommodationId: data['id'],
                                      token: data['token']);
                                  // customHostelRoomAddition(context, data['id']);
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
                            itemCount: hotelWithoutTierState.room.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              Room room = hotelWithoutTierState.room[index];
                              String image = "";
                              hotelWithoutTierState.image.forEach((roomImage) {
                                if (roomImage.room == room.id) {
                                  image = roomImage.images!;
                                }
                              });
                              return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: customRoomCard(
                                      context: context,
                                      index: index + 1,
                                      room: room,
                                      image: image));
                            },
                          );
                        },
                      ),
                    ],
                  );
                }
                if (hotelWithoutTierState is FetchHotelWithoutTierError) {
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
                                callHotelWithoutTierApis(
                                    context: context,
                                    token: data['token'],
                                    accommodationID: data['id']);
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

  Widget customRoomCard(
      {required BuildContext context,
      required int index,
      required Room room,
      required String image}) {
    return BlocProvider(
      create: (context) =>
          ImageHelperCubit()..imageHelperAccess(imageHelper: ImageHelper()),
      child: Builder(builder: (context) {
        return Slidable(
          closeOnScroll: true,
          endActionPane: ActionPane(
            extentRatio: 1,
            motion: ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) async {
                  await updateNonTierHotelRooms(context, room, data['token']);
                  // await updateNonTierHotelRooms(
                  //     context, index, state.room![index]!);
                },
                foregroundColor: Color(0xff878e92),
                icon: Icons.edit,
                label: 'Edit',
              ),
              SlidableAction(
                onPressed: (context) {
                  context.read<UpdateHotelWithoutTierCubit>()
                    ..deleteRoom(token: data['token'], roomId: room.id!);
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
              SlidableAction(
                onPressed: (context) async {
                  roomImageChanger(context, room, data['token']);
                },
                foregroundColor: Color(0xff514f53),
                icon: Icons.image,
                label: 'Change',
              ),
            ],
          ),
          child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  title: ListTile(
                    leading: Container(
                      height: 50,
                      width: 50,
                      child: CachedNetworkImage(
                        imageUrl: "${getIpWithoutSlash()}${image}",
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(5)),
                          );
                        },
                      ),
                    )
                    // Image.file(state.roomImages?[context
                    //     .watch<AddHotelWithoutTierBloc>()
                    //     .state
                    //     .room![index]!
                    //     .id]![0])
                    ,
                    subtitle: CustomPoppinsText(
                        text:
                            "This room has ${room.seater_beds!} beds at ${room.per_day_rent} ruppess",
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
                                value: room.tv_availability!,
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
      }),
    );
  }
}
