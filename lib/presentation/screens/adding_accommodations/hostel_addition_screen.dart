import 'dart:io';

import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:stayfinder_vendor/constants/constants_exports.dart';
import 'package:stayfinder_vendor/data/model/bloc_form_model.dart';
import 'package:stayfinder_vendor/data/repository/repository_exports.dart';
import 'package:stayfinder_vendor/logic/blocs/accommodation_addition/accommodation_addition_bloc.dart';
import 'package:stayfinder_vendor/logic/blocs/add_hostel_api_call/add_hostel_api_call_bloc.dart';
import 'package:stayfinder_vendor/logic/blocs/add_rental_room/add_rental_room_bloc.dart';
import 'package:stayfinder_vendor/logic/blocs/bloc_exports.dart';
import 'package:stayfinder_vendor/logic/blocs/hostel_addition/hostel_addition_bloc.dart';
import 'package:stayfinder_vendor/logic/cubits/cubit_exports.dart';
import 'package:stayfinder_vendor/logic/cubits/room_addition/room_addition_cubit.dart';
import 'package:stayfinder_vendor/presentation/config/image_helper.dart';
import 'package:stayfinder_vendor/presentation/widgets/widgets_exports.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

import '../../../data/model/model_exports.dart';
import '../../../data/model/room_model.dart';
import '../../../logic/cubits/store_images/store_images_cubit.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class HostelAdditionScreen extends StatelessWidget {
  Widget customRoomCard({required BuildContext context, required int index}) {
    return BlocBuilder<HostelAdditionBloc, HostelAdditionState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Slidable(
            closeOnScroll: true,
            endActionPane: ActionPane(
              extentRatio: 1,
              motion: ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    Room room =
                        context.read<HostelAdditionBloc>().state.room![index]!;
                    roomDetailsUpdateSheet(
                        rate: room.monthly_rate!,
                        index: index + 1,
                        beds: room.seater_beds!,
                        fanAvailable: room.fan_availability!,
                        washroom: room.washroom_status!,
                        context: context);
                  },
                  foregroundColor: Color(0xff878e92),
                  icon: Icons.edit,
                  label: 'Edit',
                ),
                SlidableAction(
                  onPressed: (context) {
                    Room? room =
                        context.read<HostelAdditionBloc>().state.room![index];
                    context.read<HostelAdditionBloc>()
                      ..add(ClearHostelAdditionEvent(room: room!));
                  },
                  foregroundColor: Color(0xff514f53),
                  icon: Icons.delete,
                  label: 'Delete',
                ),
                SlidableAction(
                  onPressed: (context) async {
                    Room? room =
                        context.read<HostelAdditionBloc>().state.room![index];
                    roomImageChanger(context, room!);
                  },
                  foregroundColor: Color(0xff514f53),
                  icon: Icons.image,
                  label: 'Change',
                ),
              ],
            ),
            child: Card(
              color: Color(0xffe5e5e5).withOpacity(0.9),
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            RoomImageContainer(
                                image: state.roomImages?[context
                                    .watch<HostelAdditionBloc>()
                                    .state
                                    .room![index]!
                                    .id]![0]),
                            RoomImageContainer(
                                image: state.roomImages?[context
                                    .watch<HostelAdditionBloc>()
                                    .state
                                    .room![index]!
                                    .id]![1]),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomRoomLabel(
                              text: "Washroom: ",
                              value: state.room![index]!.washroom_status
                                  .toString(),
                            ),
                            CustomRoomLabel(
                              text: "Fan Available : ",
                              value: state.room![index]!.fan_availability
                                  .toString()
                                  .toUpperCase(),
                            ),
                            CustomRoomLabel(
                              text: "Beds :",
                              value: state.room![index]!.seater_beds
                                  .toString()
                                  .toUpperCase(),
                            ),
                            CustomRoomLabel(
                              text: "Rate :",
                              value:
                                  "${state.room![index]!.monthly_rate.toString().toUpperCase()} rupees",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget roomViewLogin({required BuildContext context}) {
    return BlocBuilder<HostelAdditionBloc, HostelAdditionState>(
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

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ImageHelperCubit(),
        ),
        BlocProvider(
          create: (context) => FormBloc()..add(InitEvent()),
        ),
        BlocProvider(
          create: (context) => AccommodationAdditionBloc(),
        ),
        BlocProvider(
          create: (context) =>
              AddHostelApiCallBloc(repo: AccommodationAdditionRepository()),
        )
      ],
      child: Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: Builder(builder: (context) {
            return Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: CustomMaterialButton(
                      onPressed: () {
                        if (!(context
                            .read<FormBloc>()
                            .state
                            .formKey!
                            .currentState!
                            .validate())) {
                          customScaffold(
                              context: context,
                              title: "Empty Fields",
                              message: "Please enteer the above details first",
                              contentType: ContentType.warning);
                        } else {
                          return customHostelRoomAddition(context);
                        }
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.add,
                            size: 12,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              child: Text(
                            "Add Rooms",
                            style: TextStyle(fontSize: 12),
                          ))
                        ],
                      ),
                      backgroundColor: Color(0xff32454D),
                      textColor: Colors.white,
                      height: 50),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child:
                      BlocConsumer<AddHostelApiCallBloc, AddHostelApiCallState>(
                    listener: (context, state) async {
                      if (state is AddHostelApiCallError) {
                        customScaffold(
                            context: context,
                            title: "Error",
                            message: state.message,
                            contentType: ContentType.failure);
                      }
                      if (state is AddHostelApiCallSuccess) {
                        int count = 0;
                        Navigator.of(context).popUntil((_) => count++ >= 3);
                        customScaffold(
                            context: context,
                            title: "Success",
                            message: state.message,
                            contentType: ContentType.success);
                        await Future.delayed(Duration(seconds: 1));
                        context.read<DropDownValueCubit>().clearDropDownValue();
                        context
                            .read<AddRentalRoomBloc>()
                            .add(ClearRentalRoomAdditionStateEvent());
                      }
                    },
                    builder: (context, state) {
                      if (state is AddHostelApiCallLoading) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [CircularProgressIndicator()],
                          ),
                        );
                      }
                      return CustomMaterialButton(
                          onPressed: () {
                            if (context
                                .read<FormBloc>()
                                .state
                                .formKey!
                                .currentState!
                                .validate()) {
                              // print("object");
                              if (context
                                      .read<HostelAdditionBloc>()
                                      .state
                                      .room!
                                      .length ==
                                  0) {
                                customScaffold(
                                    context: context,
                                    title: "Room Missing",
                                    message: "Please add some rooms first",
                                    contentType: ContentType.warning);
                              } else {
                                Accommodation accommodation = context
                                    .read<HostelAdditionBloc>()
                                    .state
                                    .accommodation!;
                                String mealsPerDay = context
                                    .read<FormBloc>()
                                    .state
                                    .mealsPerDay
                                    .value;
                                String washRoomCount = context
                                    .read<FormBloc>()
                                    .state
                                    .washRoomCount
                                    .value;
                                String nonVegMealsPerWeek = context
                                    .read<FormBloc>()
                                    .state
                                    .nonVegMealsPerDay
                                    .value;
                                String rate =
                                    context.read<FormBloc>().state.rate.value;
                                String laundaryCycles = context
                                    .read<FormBloc>()
                                    .state
                                    .weeklyLaundaryCycles
                                    .value;
                                accommodation.meals_per_day =
                                    int.parse(mealsPerDay);
                                accommodation.number_of_washroom =
                                    int.parse(washRoomCount);
                                accommodation.weekly_non_veg_meals =
                                    int.parse(nonVegMealsPerWeek);
                                accommodation.monthly_rate = rate;
                                accommodation.weekly_laundry_cycles =
                                    int.parse(laundaryCycles);
                                // context.read<()
                                List<Room?> room = context
                                    .read<HostelAdditionBloc>()
                                    .state
                                    .room!;
                                Map<int, List> roomImages = context
                                    .read<HostelAdditionBloc>()
                                    .state
                                    .roomImages!;
                                File accommodationImage = context
                                    .read<HostelAdditionBloc>()
                                    .state
                                    .accommodationImage!;
                                var state = context.read<LoginBloc>().state;
                                if (state is LoginLoaded) {
                                  context.read<AddHostelApiCallBloc>().add(
                                      AddHostelApiAddEvent(
                                          accommodation: accommodation,
                                          accommodationImage:
                                              accommodationImage,
                                          room: room,
                                          token: state.successModel.token!,
                                          roomImages: roomImages));
                                }
                              }
                            }
                          },
                          child: Text(
                            "Confirm Addition",
                            style: TextStyle(fontSize: 12),
                          ),
                          backgroundColor: Color(0xff32454D),
                          textColor: Colors.white,
                          height: 50);
                    },
                  ),
                ),
              ],
            );
          }),
        ),
        body: SingleChildScrollView(
          child: WillPopScope(
            onWillPop: () => showExitPopup(
                context: context,
                message: "Do you really want to go back?",
                title: "Confirmation",
                yesBtnFunction: () {
                  context.read<DropDownValueCubit>().clearDropDownValue();
                  int count = 0;
                  Navigator.of(context).popUntil((_) => count++ >= 4);
                  context
                      .read<AddRentalRoomBloc>()
                      .add(ClearRentalRoomAdditionStateEvent());
                },
                noBtnFunction: () {
                  Navigator.pop(context);
                }),
            child: Builder(builder: (context) {
              return Form(
                key: context.read<FormBloc>().state.formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      context
                                  .watch<HostelAdditionBloc>()
                                  .state
                                  .room
                                  .toString() ==
                              '[]'
                          ? Arc(
                              height: 50,
                              arcType: ArcType.CONVEX,
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height / 2.5,
                                decoration: BoxDecoration(
                                    color: Color(0xff32454D),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/rental_house.png"))),
                              ),
                            )
                          : SizedBox(),
                      SizedBox(
                        height: 30,
                      ),
                      CustomPoppinsText(
                        text: "We require some more details",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff514f53),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8.0),
                        child: Column(
                          children: [
                            CustomFormField(
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
                              keyboardType: TextInputType.number,
                              onTapOutside: (p0) =>
                                  FocusScope.of(context).unfocus(),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              onChange: (p0) => context.read<FormBloc>().add(
                                  MealsPerDayChangedEvent(
                                      mealsPerDay:
                                          BlocFormItem(value: p0.toString()))),
                              labelText: "Meals per day",
                              prefixIcon: Icon(Boxicons.bx_coffee_togo),
                            ),
                            CustomFormField(
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
                              keyboardType: TextInputType.number,
                              onChange: (p0) => context.read<FormBloc>().add(
                                  WashRoomCountChangedEvent(
                                      washRoomCount:
                                          BlocFormItem(value: p0.toString()))),
                              onTapOutside: (p0) =>
                                  FocusScope.of(context).unfocus(),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              prefixIcon: Icon(Icons.wash_rounded),
                              labelText: "Washroom Count",
                            ),
                            CustomFormField(
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
                              onChange: (p0) => context.read<FormBloc>().add(
                                  NonMealsPerDayChangedEvent(
                                      nonVegMealsPerDay:
                                          BlocFormItem(value: p0.toString()))),
                              keyboardType: TextInputType.number,
                              onTapOutside: (p0) =>
                                  FocusScope.of(context).unfocus(),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              labelText: "Non Veg Meals per week",
                              prefixIcon: Icon(Boxicons.bxs_food_menu),
                            ),
                            CustomFormField(
                              onChange: (p0) => context.read<FormBloc>().add(
                                  WeeklyLaundaryCyclesChangedEvent(
                                      weeklyLaundaryCycles:
                                          BlocFormItem(value: p0.toString()))),
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
                              keyboardType: TextInputType.number,
                              onTapOutside: (p0) =>
                                  FocusScope.of(context).unfocus(),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              labelText: "Weekly Laundry Cycles",
                              prefixIcon: Icon(Boxicons.bxs_washer),
                            ),
                            CustomFormField(
                              onChange: (p0) => context.read<FormBloc>().add(
                                  RateChangedEvent(
                                      rate:
                                          BlocFormItem(value: p0.toString()))),
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
                              keyboardType: TextInputType.number,
                              onTapOutside: (p0) =>
                                  FocusScope.of(context).unfocus(),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              labelText: "Admission Rate",
                              prefixIcon: Icon(Boxicons.bx_dollar),
                            ),
                          ]
                              .map<Widget>((e) => Column(
                                    children: [
                                      e,
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ))
                              .toList(),
                        ),
                      ),
                      // Text("aaaaa")
                      roomViewLogin(context: context)
                    ]),
              );
            }),
          ),
        ),
      ),
    );
  }

  Future<dynamic> roomImageChanger(BuildContext context, Room room) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return BlocProvider(
          create: (context) => StoreImagesCubit(),
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
                          context.read<ImageHelperCubit>()
                            ..imageHelperAccess(imageHelper: ImageHelper());
                          List<XFile> files = await context
                              .read<ImageHelperCubit>()
                              .state
                              .imageHelper!
                              .pickImage(multiple: true);

                          List<File> convertedImages = [];
                          if (files.length == 2) {
                            files.forEach((element) {
                              convertedImages.add(File(element.path));
                            });
                            context.read<HostelAdditionBloc>().add(
                                HostelChangePictureHitEvent(
                                    image1: convertedImages[0],
                                    image2: convertedImages[1],
                                    index: room.id!));
                            Navigator.pop(context);
                            customScaffold(
                                context: context,
                                title: "Success",
                                message: "Successfully Changed",
                                contentType: ContentType.success);
                          }
                          print(files.length);
                          if (files.length != 2) {
                            Navigator.pop(context);
                            customScaffold(
                                context: context,
                                title: "Provide Image",
                                message: "Provide two images",
                                contentType: ContentType.help);
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

  Future<dynamic> customHostelRoomAddition(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
            height: MediaQuery.of(context).size.height,
            child: MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => FormBloc()..add(InitEvent()),
                  ),
                  BlocProvider(
                    create: (context) => StoreImagesCubit(),
                  ),
                  BlocProvider(
                    create: (context) => RoomAdditionCubit(),
                  ),
                ],
                child: Builder(
                  builder: (context) {
                    return Form(
                      key: context.read<FormBloc>().state.formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          CustomPoppinsText(
                            text: "Add your room data",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff514f53),
                          ),
                          BlocBuilder<DropDownValueCubit, DropDownValueState>(
                            builder: (context, state) {
                              return Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      context
                                                  .watch<StoreImagesCubit>()
                                                  .state
                                                  .images
                                                  .length ==
                                              2
                                          ? SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                            height: 100,
                                                            width: 100,
                                                            decoration:
                                                                BoxDecoration(
                                                              image: DecorationImage(
                                                                  image: FileImage(context
                                                                      .read<
                                                                          StoreImagesCubit>()
                                                                      .state
                                                                      .images[0])),
                                                            )),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Container(
                                                            height: 100,
                                                            width: 100,
                                                            decoration:
                                                                BoxDecoration(
                                                              image: DecorationImage(
                                                                  image: FileImage(context
                                                                      .read<
                                                                          StoreImagesCubit>()
                                                                      .state
                                                                      .images[1])),
                                                            ))
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: CustomPoppinsText(
                                                    text:
                                                        "Please add two images",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ],
                                            ),
                                      Text(""),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      CustomPoppinsText(
                                          color: Color(0xff514f53),
                                          text: "Washroom Status",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
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
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 13.0),
                                                child: CustomDropDownButton(
                                                  state: state,
                                                  items: state.items!
                                                      .map<
                                                              DropdownMenuItem<
                                                                  String>>(
                                                          (value) =>
                                                              DropdownMenuItem(
                                                                child: Text(
                                                                    value!),
                                                                value: value,
                                                              ))
                                                      .toList(),
                                                  onChanged: (p0) {
                                                    context
                                                        .read<
                                                            DropDownValueCubit>()
                                                        .changeDropDownValue(
                                                            p0!);
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20.0),
                                              child: BlocBuilder<
                                                  ImageHelperCubit,
                                                  ImageHelperState>(
                                                builder: (context, state) {
                                                  return CustomMaterialButton(
                                                      onPressed: () async {
                                                        context.read<
                                                            ImageHelperCubit>()
                                                          ..imageHelperAccess(
                                                              imageHelper:
                                                                  ImageHelper());
                                                        ImageHelper?
                                                            imageHelper =
                                                            context
                                                                .read<
                                                                    ImageHelperCubit>()
                                                                .state
                                                                .imageHelper;
                                                        List<XFile> files = [];
                                                        List<File>
                                                            convertedImages =
                                                            [];
                                                        files =
                                                            await imageHelper!
                                                                .pickImage(
                                                                    multiple:
                                                                        true);
                                                        if (files.length == 2) {
                                                          files.forEach(
                                                              (element) {
                                                            convertedImages.add(
                                                                File(element
                                                                    .path));
                                                          });
                                                          context.read<
                                                              StoreImagesCubit>()
                                                            ..addImages(
                                                                convertedImages);
                                                        }
                                                      },
                                                      child: Text(
                                                        "Add Images",
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                      backgroundColor:
                                                          Color(0xff514f53),
                                                      textColor: Colors.white,
                                                      height: 47);
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 50.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    BlocBuilder<RoomAdditionCubit,
                                        RoomAdditionState>(
                                      builder: (context, state) {
                                        return CustomCheckBoxTile(
                                            title: "Fan",
                                            onChanged: (p0) {
                                              if (state.room != null) {
                                                context
                                                    .read<RoomAdditionCubit>()
                                                    .RoomUpdate(Room(
                                                        fan_availability: !(state
                                                            .room!
                                                            .fan_availability!)));
                                              }
                                            },
                                            value:
                                                state.room!.fan_availability!,
                                            icon: Icons.cached);
                                      },
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.5,
                                        child: CustomFormField(
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          prefixIcon:
                                              Icon(CupertinoIcons.money_dollar),
                                          labelText: "Rate",
                                          keyboardType: TextInputType.number,
                                          validatior: (p0) {
                                            // return null;
                                            if (p0 == null) {
                                              return "Rate cannot be empty";
                                            }
                                            if (!(p0.isValidNumber)) {
                                              return "Please enter valid number";
                                            }
                                            if (int.parse(p0) <= 0) {
                                              return "Please enter valid number";
                                            }
                                            if ((int.parse(p0) < 500)) {
                                              return "More than 500 allowed";
                                            }
                                            return null;
                                          },
                                          onTapOutside: (p0) =>
                                              FocusScope.of(context).unfocus(),
                                          onChange: (p0) {
                                            context.read<FormBloc>()
                                              ..add(RateChangedEvent(
                                                  rate: BlocFormItem(
                                                      value: p0!)));
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                CustomFormField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  labelText: "Seater Beds",
                                  keyboardType: TextInputType.number,
                                  validatior: (p0) {
                                    // return null;
                                    if (p0 == null) {
                                      return "Beds cannot be empty";
                                    }
                                    if (!(p0.isValidNumber)) {
                                      return "Please enter valid number";
                                    }
                                    if (int.parse(p0) <= 0) {
                                      return "Enter valid beds";
                                    }
                                    if ((int.parse(p0) > 7)) {
                                      return "Can't be greater than 7";
                                    }
                                    return null;
                                  },
                                  onTapOutside: (p0) =>
                                      FocusScope.of(context).unfocus(),
                                  onChange: (p0) {
                                    context.read<FormBloc>()
                                      ..add(WashRoomCountChangedEvent(
                                          washRoomCount:
                                              BlocFormItem(value: p0!)));
                                  },
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
                                        print(
                                            "The image is here ${context.read<HostelAdditionBloc>().state.roomImages}");
                                        print(
                                            'This is the accommodation ${context.read<HostelAdditionBloc>().state.accommodation}');
                                        if (context
                                                .read<StoreImagesCubit>()
                                                .state
                                                .images
                                                .length ==
                                            2) {
                                          List<Room?>? room = context
                                              .read<HostelAdditionBloc>()
                                              .state
                                              .room;
                                          // List<Room?>? roomAdded = context.read<()

                                          if (room != null) {
                                            room.forEach((element) {
                                              print(element!.id);
                                            });
                                          }

                                          String washRoomStatus = context
                                              .read<DropDownValueCubit>()
                                              .state
                                              .value!;
                                          bool fan_availability = context
                                              .read<RoomAdditionCubit>()
                                              .state
                                              .room!
                                              .fan_availability!;

                                          List<File> images = context
                                              .read<StoreImagesCubit>()
                                              .state
                                              .images;
                                          String rate = context
                                              .read<FormBloc>()
                                              .state
                                              .rate
                                              .value;
                                          String seaterBeds = context
                                              .read<FormBloc>()
                                              .state
                                              .washRoomCount
                                              .value;
                                          if (room != null) {
                                            bool exists = room.any((element) =>
                                                element!.seater_beds
                                                    .toString() ==
                                                seaterBeds);
                                            if (exists) {
                                              Navigator.pop(context);
                                              customScaffold(
                                                  context: context,
                                                  title: "Already Exists",
                                                  message:
                                                      "The room with ${seaterBeds} beds already exists",
                                                  contentType:
                                                      ContentType.help);
                                              return;
                                            }
                                          }
                                          context.read<HostelAdditionBloc>()
                                            ..add(HostelAddtionHitEvent(
                                                images: context
                                                    .read<StoreImagesCubit>()
                                                    .state
                                                    .images,
                                                room: Room(
                                                  fan_availability:
                                                      fan_availability,
                                                  washroom_status:
                                                      washRoomStatus,
                                                  seater_beds:
                                                      int.parse(seaterBeds),
                                                  monthly_rate: int.parse(rate),
                                                )));
                                          Navigator.pop(context);
                                        }
                                      }
                                    },
                                    child: Text("Confirm Addition"),
                                    backgroundColor: Color(0xff32454D),
                                    textColor: Colors.white,
                                    height: 50),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )));
      },
    );
  }
}

Future<dynamic> roomDetailsUpdateSheet(
    {required BuildContext context,
    required int index,
    required String washroom,
    required bool fanAvailable,
    required int beds,
    required int rate}) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => FormBloc()..add(InitEvent()),
              ),
              BlocProvider(
                  create: (context) => RoomAdditionCubit()
                    ..RoomUpdate(Room(fan_availability: fanAvailable))),
            ],
            child: Builder(builder: (context) {
              return Form(
                key: context.read<FormBloc>().state.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomPoppinsText(
                        text: "Update Room Details",
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: CustomFormField(
                              initialValue: beds.toString(),
                              labelText: "Beds",
                              prefixIcon: Icon(Icons.bed),
                              onTapOutside: (p0) =>
                                  FocusScope.of(context).unfocus(),
                              onChange: (p0) {
                                context.read<FormBloc>()
                                  ..add(WashRoomCountChangedEvent(
                                      washRoomCount:
                                          BlocFormItem(value: p0.toString())));
                              },
                              keyboardType: TextInputType.number,
                              validatior: (p0) {
                                if (p0!.isEmpty) {
                                  return "Can't be empty";
                                }
                                if (!(p0.isValidNumber)) {
                                  return "Invalid Number";
                                }
                                if (!(p0.isValidNumber)) {
                                  return "Can't be 0";
                                }
                                if (int.parse(p0) > 7) {
                                  return "7 or less allowed";
                                }
                                return null;
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: CustomFormField(
                              initialValue: rate.toString(),
                              labelText: "Rate",
                              prefixIcon: Icon(Icons.money),
                              onTapOutside: (p0) =>
                                  FocusScope.of(context).unfocus(),
                              keyboardType: TextInputType.number,
                              onChange: (p0) {
                                context.read<FormBloc>()
                                  ..add(RateChangedEvent(
                                      rate:
                                          BlocFormItem(value: p0.toString())));
                              },
                              validatior: (p0) {
                                if (p0!.isEmpty) {
                                  return "Can't be empty";
                                }
                                if (!(p0.isValidNumber)) {
                                  return "Invalid Number";
                                }
                                if (int.parse(p0) < 500) {
                                  return "Atleast 500 allowed";
                                }
                                return null;
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomPoppinsText(
                          text: "Washroom Status",
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff514f53),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
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
                                state:
                                    context.watch<DropDownValueCubit>().state,
                                items: context
                                    .read<DropDownValueCubit>()
                                    .state
                                    .items!
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
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 57.0),
                      child: Column(
                        children: [
                          BlocBuilder<RoomAdditionCubit, RoomAdditionState>(
                            builder: (context, state) {
                              return CustomCheckBoxTile(
                                title: "Fan",
                                onChanged: (p0) {
                                  context.read<RoomAdditionCubit>().RoomUpdate(
                                      Room(
                                          fan_availability: !(state
                                              .room!.fan_availability!)));
                                },
                                value: state.room!.fan_availability!,
                                icon: Icons.cached,
                              );
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomMaterialButton(
                              onPressed: () {
                                FormsState state =
                                    context.read<FormBloc>().state;
                                if (state.formKey!.currentState!.validate()) {
                                  Map textFields = {
                                    "beds": state.washRoomCount.value,
                                    "rate": state.rate.value
                                  };
                                  Map validatedFields = {};
                                  textFields.forEach(
                                    (key, value) {
                                      print(key);
                                      print(value.toString());
                                      if (value != "") {
                                        validatedFields[key] = int.parse(value);
                                      }
                                    },
                                  );
                                  late bool contains;
                                  context
                                      .read<HostelAdditionBloc>()
                                      .state
                                      .room!
                                      .forEach((element) {
                                    if (element!.seater_beds.toString() ==
                                        state.washRoomCount.value) {
                                      customScaffold(
                                          context: context,
                                          title: "Already Exists",
                                          message:
                                              "Room with ${state.washRoomCount} beds already exists",
                                          contentType: ContentType.help);
                                      contains = true;
                                      Navigator.pop(context);
                                      return;
                                    }
                                  });
                                  if (contains == false) {
                                    Room stateRoom = context
                                        .read<HostelAdditionBloc>()
                                        .state
                                        .room![index - 1]!;

                                    Room room = Room(
                                      id: stateRoom.id,
                                      fan_availability: context
                                          .read<RoomAdditionCubit>()
                                          .state
                                          .room!
                                          .fan_availability,
                                      monthly_rate:
                                          validatedFields['rate'] ?? rate,
                                      seater_beds:
                                          validatedFields['beds'] ?? beds,
                                      washroom_status: context
                                          .read<DropDownValueCubit>()
                                          .state
                                          .value,
                                    );
                                    print(room);

                                    context.read<HostelAdditionBloc>()
                                      ..add(HostelUpdateRoomDetailsHitEvent(
                                          room: room, index: index - 1));
                                    Navigator.pop(context);
                                  }
                                }
                              },
                              child: Text("Update Details"),
                              backgroundColor: Color(0xff514f53),
                              textColor: Colors.white,
                              height: 50),
                        ],
                      ),
                    )
                  ],
                ),
              );
            })),
      );
    },
  );
}

class CustomRoomLabel extends StatelessWidget {
  const CustomRoomLabel({
    Key? key,
    required this.text,
    required this.value,
  }) : super(key: key);

  final String text;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomPoppinsText(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          text: text,
          color: Color(0xff514f53),
        ),
        SizedBox(
          width: 12,
        ),
        CustomPoppinsText(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          text: value,
          color: Color(0xff514f53),
        ),
      ],
    );
  }
}

class RoomImageContainer extends StatelessWidget {
  const RoomImageContainer({Key? key, required this.image}) : super(key: key);

  final File image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: FileImage(image),
        ),
      ),
    );
  }
}
