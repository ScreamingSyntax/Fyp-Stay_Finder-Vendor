import 'dart:io';

import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:stayfinder_vendor/constants/constants_exports.dart';
import 'package:stayfinder_vendor/data/model/bloc_form_model.dart';
import 'package:stayfinder_vendor/data/model/model_exports.dart';
import 'package:stayfinder_vendor/data/repository/accommodation_addition_repository.dart';
import 'package:stayfinder_vendor/logic/blocs/add_rental_room/add_rental_room_bloc.dart';
import 'package:stayfinder_vendor/logic/blocs/bloc_exports.dart';
import 'package:stayfinder_vendor/logic/cubits/cubit_exports.dart';
import 'package:stayfinder_vendor/presentation/config/image_helper.dart';
import 'package:stayfinder_vendor/presentation/screens/screen_exports.dart';
import 'package:stayfinder_vendor/presentation/widgets/widgets_exports.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

class RentalRoomAdditionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ImageHelperCubit()..imageHelperAccess(imageHelper: ImageHelper()),
        ),
        BlocProvider(
          create: (context) => FormBloc()..add(InitEvent()),
        ),
        BlocProvider(
          create: (context) =>
              AddRentalRoomApiCallBloc(repo: AccommodationAdditionRepository()),
        ),
      ],
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: Builder(builder: (context) {
            return BlocConsumer<AddRentalRoomApiCallBloc,
                AddRentalRoomApiCallState>(
              listener: (context, state) async {
                if (state is AddRentalRoomApiCallError) {
                  customScaffold(
                      context: context,
                      title: "Error",
                      message: state.message,
                      contentType: ContentType.failure);
                }
                if (state is AddRentalRoomApiCallSuccess) {
                  customScaffold(
                      context: context,
                      title: "Success",
                      message: state.message,
                      contentType: ContentType.success);
                  var loginState = context.read<LoginBloc>().state;
                  if (loginState is LoginLoaded) {
                    callApis(context, loginState);
                  }
                  int count = 0;
                  Navigator.of(context).popUntil((_) => count++ >= 3);
                  await Future.delayed(Duration(seconds: 1));
                  context.read<DropDownValueCubit>().clearDropDownValue();
                  context
                      .read<AddRentalRoomBloc>()
                      .add(ClearRentalRoomAdditionStateEvent());
                }
              },
              builder: (context, state) {
                if (state is AddRentalRoomApiCallLoading) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [CircularProgressIndicator()],
                    ),
                  );
                }
                return CustomMaterialButton(
                    onPressed: () async {
                      if (context
                          .read<FormBloc>()
                          .state
                          .formKey!
                          .currentState!
                          .validate()) {
                        if (context.read<DropDownValueCubit>().state.value ==
                            null) {
                          customScaffold(
                              context: context,
                              title: "Empty",
                              message: "Please select washroom status",
                              contentType: ContentType.failure);
                          return;
                        }
                        var state = context.read<AddRentalRoomBloc>().state;
                        if (state.roomImage1 == null &&
                            state.roomImage2 == null &&
                            state.roomImage3 == null) {
                          customScaffold(
                              context: context,
                              title: "Images",
                              message: "Please add images",
                              contentType: ContentType.failure);
                          return;
                        }

                        var formState = context.read<FormBloc>().state;
                        // if(accommodationState.)
                        await context.read<AddRentalRoomBloc>()
                          ..add(
                            UpdateAccommodationEvent(
                              accommodation: state.accommodation!.copyWith(
                                  monthly_rate: formState.rate.value,
                                  number_of_washroom:
                                      int.parse(formState.washRoomCount.value)),
                            ),
                          );
                        Accommodation accommodation = context
                            .read<AddRentalRoomBloc>()
                            .state
                            .accommodation!;
                        accommodation.monthly_rate = formState.rate.value;
                        accommodation.number_of_washroom =
                            int.parse(formState.washRoomCount.value);
                        Room room =
                            context.read<AddRentalRoomBloc>().state.room!;
                        room.washroom_status =
                            context.read<DropDownValueCubit>().state.value;
                        var loginState = context.read<LoginBloc>().state;

                        if (loginState is LoginLoaded) {
                          context.read<AddRentalRoomApiCallBloc>().add(
                              AddRentalRoomHitEventApi(
                                  token: loginState.successModel.token!,
                                  accommodationImage: context
                                      .read<AddRentalRoomBloc>()
                                      .state
                                      .accommodationImage!,
                                  accommodation: accommodation,
                                  room: room,
                                  roomImage1: context
                                      .read<AddRentalRoomBloc>()
                                      .state
                                      .roomImage1!,
                                  roomImage2: context
                                      .read<AddRentalRoomBloc>()
                                      .state
                                      .roomImage2!,
                                  roomImage3: context
                                      .read<AddRentalRoomBloc>()
                                      .state
                                      .roomImage3!));
                        }
                      }
                      if (!(context
                          .read<FormBloc>()
                          .state
                          .formKey!
                          .currentState!
                          .validate())) {
                        customScaffold(
                            context: context,
                            title: "Oops",
                            message: "There are some validation errors",
                            contentType: ContentType.failure);
                        return;
                      }
                    },
                    child: Text("Confirm Addition"),
                    backgroundColor: Color(0xff32454D),
                    textColor: Colors.white,
                    height: 50);
              },
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
                  int count = 0;
                  Navigator.of(context).popUntil((_) => count++ >= 4);
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
                    Arc(
                      height: 50,
                      arcType: ArcType.CONVEX,
                      child: Container(
                        height: MediaQuery.of(context).size.height / 2.5,
                        decoration: BoxDecoration(
                            color: Color(0xff32454D),
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/rental_house.png"))),
                      ),
                    ),
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
                    CustomPoppinsText(
                      text: "Note: Add three images",
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: CustomFormField(
                                  onChange: (p0) => context
                                      .read<FormBloc>()
                                      .add(RateChangedEvent(
                                          rate: BlocFormItem(value: p0!))),
                                  // onChange: (p0) => ,
                                  inputFormatters: [],
                                  validatior: (p0) {
                                    if (p0!.isEmpty) {
                                      return "Empty?";
                                    }
                                    if (!(p0.isValidNumber)) {
                                      return "Invalid no.";
                                    }
                                    return null;
                                  },
                                  prefixIcon: Icon(Icons.attach_money),
                                  onTap: () {},
                                  keyboardType: TextInputType.number,
                                  onTapOutside: (p0) =>
                                      FocusScope.of(context).unfocus(),
                                  labelText: "Rate",
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: CustomFormField(
                                    onChange: (p0) => context
                                        .read<FormBloc>()
                                        .add(WashRoomCountChangedEvent(
                                            washRoomCount:
                                                BlocFormItem(value: p0!))),
                                    inputFormatters: [],
                                    validatior: (p0) {
                                      if (p0!.isEmpty) {
                                        return "Empty?";
                                      }
                                      if (!(p0.isValidNumber)) {
                                        return "Invalid no.";
                                      }
                                      return null;
                                    },
                                    prefixIcon: Icon(Icons.wash_rounded),
                                    onTap: () {},
                                    onTapOutside: (p0) =>
                                        FocusScope.of(context).unfocus(),
                                    labelText: "Washroom count",
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
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
                                              child: Column(
                                                children: [
                                                  CustomMaterialButton(
                                                      onPressed: () async {
                                                        print(context
                                                            .read<
                                                                AddRentalRoomBloc>()
                                                            .state
                                                            .roomImage1);
                                                        var imageHelper = context
                                                            .read<
                                                                ImageHelperCubit>()
                                                            .state
                                                            .imageHelper!;
                                                        final xFiles =
                                                            await imageHelper
                                                                .pickImage(
                                                                    multiple:
                                                                        true);
                                                        List<File> files = [];
                                                        xFiles.forEach((xFile) {
                                                          files.add(
                                                              File(xFile.path));
                                                        });

                                                        if (files.length != 3) {
                                                          customScaffold(
                                                              context: context,
                                                              title: "Error",
                                                              message:
                                                                  "Please provide three images",
                                                              contentType:
                                                                  ContentType
                                                                      .failure);
                                                          return;
                                                        }
                                                        context.read<
                                                            AddRentalRoomBloc>()
                                                          ..add(
                                                              InstantiateRoomImageEvent(
                                                                  roomImages:
                                                                      files));
                                                      },
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            "Add Images",
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          ),
                                                        ],
                                                      ),
                                                      backgroundColor:
                                                          Color(0xff514f53),
                                                      textColor: Colors.white,
                                                      height: 47),
                                                ],
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
                          Builder(
                            builder: (context) {
                              var state =
                                  context.watch<AddRentalRoomBloc>().state;
                              if (state.roomImage1 != null &&
                                  state.roomImage2 != null &&
                                  state.roomImage3 != null) {
                                print(
                                    "This is room 1 //${context.read<AddRentalRoomBloc>().state.roomImage1}");

                                return Column(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30.0),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: [
                                            Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Color(0xff32454D),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Color(0xff32454D),
                                                    image: DecorationImage(
                                                        fit: BoxFit.contain,
                                                        image: FileImage(
                                                          state.roomImage1!,
                                                        )))),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Color(0xff32454D),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Color(0xff32454D),
                                                    image: DecorationImage(
                                                        fit: BoxFit.contain,
                                                        image: FileImage(
                                                          state.roomImage2!,
                                                        )))),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Color(0xff32454D),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Color(0xff32454D),
                                                    image: DecorationImage(
                                                        fit: BoxFit.contain,
                                                        image: FileImage(
                                                          state.roomImage3!,
                                                        )))),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }
                              return SizedBox();
                            },
                          ),
                          //1 GridView(gridDelegate: )
                          BlocBuilder<AddRentalRoomBloc, AddRentalRoomState>(
                            builder: (context, state) {
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
                                    onChanged: (p0) {
                                      if (state.accommodation != null) {
                                        context.read<AddRentalRoomBloc>().add(
                                              UpdateAccommodationEvent(
                                                accommodation: state
                                                    .accommodation!
                                                    .copyWith(
                                                  trash_dispose_availability:
                                                      !(state.accommodation!
                                                          .trash_dispose_availability!),
                                                ),
                                              ),
                                            );
                                      }
                                    },
                                    title: "Dispose",
                                    icon: CupertinoIcons.trash,
                                    value: context
                                        .watch<AddRentalRoomBloc>()
                                        .state
                                        .accommodation!
                                        .trash_dispose_availability!,
                                  ),
                                  CustomCheckBoxTile(
                                    // onChanged: (p0) => print(p0),
                                    onChanged: (p0) {
                                      if (state.accommodation != null) {
                                        context.read<AddRentalRoomBloc>().add(
                                              UpdateAccommodationEvent(
                                                accommodation: state
                                                    .accommodation!
                                                    .copyWith(
                                                  parking_availability: !(state
                                                      .accommodation!
                                                      .parking_availability!),
                                                ),
                                              ),
                                            );
                                      }
                                    },
                                    title: "Parking",
                                    icon: CupertinoIcons.car,
                                    value: context
                                        .watch<AddRentalRoomBloc>()
                                        .state
                                        .accommodation!
                                        .parking_availability!,
                                  ),
                                  CustomCheckBoxTile(
                                    onChanged: (p0) => {
                                      context.read<AddRentalRoomBloc>().add(
                                            UpdateAccommodationEvent(
                                              room: state.room!.copyWith(
                                                fan_availability: !(state
                                                    .room!.fan_availability!),
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
                                                bed_availability: !(state
                                                    .room!.bed_availability!),
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
                                                sofa_availability: !(state
                                                    .room!.sofa_availability!),
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
                                                mat_availability: !(state
                                                    .room!.mat_availability!),
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
                                                    .room!
                                                    .carpet_availability!),
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
                                                    .room!
                                                    .dustbin_availability!),
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
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
