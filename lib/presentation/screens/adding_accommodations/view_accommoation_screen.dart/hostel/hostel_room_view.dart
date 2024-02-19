import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stayfinder_vendor/data/model/room_image_model.dart';
import 'package:stayfinder_vendor/logic/cubits/update_hostel/update_hostel_cubit.dart';
import 'package:stayfinder_vendor/presentation/screens/adding_accommodations/view_accommoation_screen.dart/hostel/hostel_view.dart';
import 'package:stayfinder_vendor/presentation/widgets/widgets_exports.dart';

import '../../../../../constants/constants_exports.dart';
import '../../../../../data/api/api_exports.dart';
import '../../../../../data/model/model_exports.dart';
import '../../../../../logic/blocs/bloc_exports.dart';
import '../../../../../logic/cubits/cubit_exports.dart';
import '../../../../../logic/cubits/fetch_hostel/fetch_hostel_details_cubit.dart';
import '../../../../../logic/cubits/room_addition/room_addition_cubit.dart';
import '../../../../../logic/cubits/store_images/store_images_cubit.dart';
import '../../../../config/config_exports.dart';
import '../rental_room_view.dart';

class HostelRoomView extends StatelessWidget {
  final Map data;

  const HostelRoomView({super.key, required this.data});
  Future<void> callHostelApis(
      Map<dynamic, dynamic> args, BuildContext context) async {
    String token = args['token'];
    int accommodationID = args['id'];
    context.read<FetchHostelDetailsCubit>().fetchHostelAccommodation(
        accommodationId: accommodationID, token: token);
  }

  Future<dynamic> updateRoomImage(
      {required BuildContext context,
      required List<RoomImage> images,
      required int roomId}) {
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
                      itemCount: images.length,
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
                                    await context.read<UpdateHostelCubit>()
                                      ..updateRoomImage(
                                          token: loginState.successModel.token!,
                                          FileImage: file,
                                          roomId: roomId,
                                          roomImageId: images[index].id!);
                                    Navigator.pop(context);
                                  }
                                }
                              }
                            },
                            // context.read<UpdateRentalAccommodationCubit>()..updateRoomImage(room_id: state.roomImages[index].id.toString(), room_image_id: state.roomImages[index].room.toString(), token: token, image: state.roomImages)
                            child: Row(
                              children: [
                                RoomImageRental(
                                    image: NetworkImage(
                                        "${getIpWithoutSlash()}${images[index].images}")),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe5e5e5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<FetchHostelDetailsCubit, FetchHostelDetailsState>(
                  builder: (context, state) {
                if (state is FetchHostelDetailLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is FetchHostelDetailError) {
                  return HostelRetryScreen(
                    state: state,
                    data: data,
                  );
                }
                if (state is FetchHostelDetailSuccess) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      return await callHostelApis(data, context);
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                  onTap: () => Navigator.pop(context),
                                  child: Icon(Icons.arrow_back)),
                              if (state.accommodation!.is_pending! == false)
                                InkWell(
                                    onTap: () {
                                      context.read<DropDownValueCubit>()
                                        ..changeDropDownValue("Average");
                                      customHostelRoomAddition(
                                          context, data['id']);
                                    },
                                    child: Icon(Icons.add))
                            ],
                          ),
                        ),
                        ListView.builder(
                          itemCount: state.rooms!.length,
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            Room room = state.rooms![index];
                            List<RoomImage> images = [];
                            print(images);
                            var one = state.images!.where((element) {
                              return element.room == room.id;
                            });
                            List<RoomImage> list =
                                List<RoomImage>.from(one).toList();
                            print("The sate is ${list}");
                            return HostelViewCard(
                              isPending:
                                  state.accommodation!.is_pending ?? false,
                              images: list,
                              id: room.id!,
                              onEdit: (p0) {
                                context.read<DropDownValueCubit>()
                                  ..changeDropDownValue(room.washroom_status!);
                                roomDetailsUpdateSheet(
                                    id: room.id!,
                                    context: context,
                                    beds: room.seater_beds!,
                                    fanAvailable: room.fan_availability!,
                                    rate: room.monthly_rate!,
                                    washroom: room.washroom_status!);
                              },
                              onChangePhoto: (p0) async {
                                await updateRoomImage(
                                    roomId: room.id!,
                                    context: context,
                                    images: list);
                              },
                              bedCount: room.seater_beds.toString(),
                              fanAvailability: room.fan_availability!,
                              onDelete: (p0) {
                                context.read<UpdateHostelCubit>()
                                  ..deleteRoom(
                                      token: data['token'], room: room.id!);
                              },
                              ruppes: room.monthly_rate.toString(),
                              roomIndex: index + 1,
                              washRoomStatus: room.washroom_status.toString(),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                }
                return SizedBox();
              })
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> roomDetailsUpdateSheet(
      {required BuildContext context,
      required String washroom,
      required bool fanAvailable,
      required int id,
      required int beds,
      required int rate}) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          child: MultiBlocProvider(
              providers: [
                // BlocProvider(create: (context) => DropDownValueCubit()),
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
                                        washRoomCount: BlocFormItem(
                                            value: p0.toString())));
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
                                        rate: BlocFormItem(
                                            value: p0.toString())));
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 13.0),
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
                                    context
                                        .read<RoomAdditionCubit>()
                                        .RoomUpdate(Room(
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
                                      "seater_beds": state.washRoomCount.value,
                                      "monthly_rate": state.rate.value,
                                    };
                                    Map<String, dynamic> validatedFields = {
                                      "washroom_status": context
                                          .read<DropDownValueCubit>()
                                          .state
                                          .value
                                          .toString(),
                                      "fan_availability": context
                                          .read<RoomAdditionCubit>()
                                          .state
                                          .room!
                                          .fan_availability,
                                      'id': id
                                    };
                                    textFields.forEach(
                                      (key, value) {
                                        print(key);
                                        print(value.toString());
                                        if (value != "") {
                                          validatedFields[key] =
                                              int.parse(value);
                                        }
                                      },
                                    );
                                    var loginState =
                                        context.read<LoginBloc>().state;
                                    if (loginState is LoginLoaded) {
                                      context.read<UpdateHostelCubit>()
                                        ..updateAccommodationRoomDetails(
                                            token:
                                                loginState.successModel.token!,
                                            data: validatedFields);
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
}

Future<dynamic> customHostelRoomAddition(
    BuildContext context, int accommodationId) {
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                                  text: "Please add two images",
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
                                                            String>>((value) =>
                                                        DropdownMenuItem(
                                                          child: Text(value!),
                                                          value: value,
                                                        ))
                                                    .toList(),
                                                onChanged: (p0) {
                                                  context
                                                      .read<
                                                          DropDownValueCubit>()
                                                      .changeDropDownValue(p0!);
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
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            child: BlocBuilder<ImageHelperCubit,
                                                ImageHelperState>(
                                              builder: (context, state) {
                                                return CustomMaterialButton(
                                                    onPressed: () async {
                                                      context.read<
                                                          ImageHelperCubit>()
                                                        ..imageHelperAccess(
                                                            imageHelper:
                                                                ImageHelper());
                                                      ImageHelper? imageHelper =
                                                          context
                                                              .read<
                                                                  ImageHelperCubit>()
                                                              .state
                                                              .imageHelper;
                                                      List<XFile> files = [];
                                                      List<File>
                                                          convertedImages = [];
                                                      files = await imageHelper!
                                                          .pickImage(
                                                              multiple: true);
                                                      if (files.length == 2) {
                                                        files
                                                            .forEach((element) {
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
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
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
                                          value: state.room!.fan_availability!,
                                          icon: Icons.cached);
                                    },
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      child: CustomFormField(
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
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
                                                rate:
                                                    BlocFormItem(value: p0!)));
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
                                      // print(
                                      //     "The image is here ${context.read<HostelAdditionBloc>().state.roomImages}");
                                      // print(
                                      //     'This is the accommodation ${context.read<HostelAdditionBloc>().state.accommodation}');
                                      if (context
                                              .read<StoreImagesCubit>()
                                              .state
                                              .images
                                              .length ==
                                          2) {
                                        // List<Room?>? room = context
                                        //     .read<HostelAdditionBloc>()
                                        //     .state
                                        //     .room;
                                        // List<Room?>? roomAdded = context.read<()

                                        // if (room != null) {
                                        //   room.forEach((element) {
                                        //     print(element!.id);
                                        //   });
                                        // }

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
                                        var loginState =
                                            context.read<LoginBloc>().state;
                                        if (loginState is LoginLoaded) {
                                          context.read<UpdateHostelCubit>()
                                            ..addHostelRoom(
                                                token: loginState
                                                    .successModel.token!,
                                                accommodationId:
                                                    accommodationId,
                                                image1: images[0],
                                                image2: images[1],
                                                seaterBeds:
                                                    int.parse(seaterBeds),
                                                washroom_status: washRoomStatus,
                                                fan_availability:
                                                    fan_availability,
                                                monthly_rate: int.parse(rate));
                                          Navigator.pop(context);
                                        }
                                        // if (room != null) {
                                        //   bool exists = room.any((element) =>
                                        //       element!.seater_beds
                                        //           .toString() ==
                                        //       seaterBeds);
                                        //   if (exists) {
                                        //     Navigator.pop(context);
                                        //     customScaffold(
                                        //         context: context,
                                        //         title: "Already Exists",
                                        //         message:
                                        //             "The room with ${seaterBeds} beds already exists",
                                        //         contentType:
                                        //             ContentType.help);
                                        //     return;
                                        //   }
                                        // }
                                        // context.read<HostelAdditionBloc>()
                                        //   ..add(HostelAddtionHitEvent(
                                        //       images: context
                                        //           .read<StoreImagesCubit>()
                                        //           .state
                                        //           .images,
                                        //       room: Room(
                                        //         fan_availability:
                                        //             fan_availability,
                                        //         washroom_status:
                                        //             washRoomStatus,
                                        //         seater_beds:
                                        //             int.parse(seaterBeds),
                                        //         monthly_rate: int.parse(rate),
                                        //       )));
                                        // Navigator.pop(context);
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

class HostelViewCard extends StatelessWidget {
  final List<RoomImage> images;
  final Function(BuildContext) onEdit;
  final Function(BuildContext) onDelete;
  final Function(BuildContext) onChangePhoto;
  final int roomIndex;
  final bool fanAvailability;
  final String bedCount;

  final String washRoomStatus;
  final String ruppes;
  final int id;
  final bool isPending;

  HostelViewCard({
    required this.images,
    super.key,
    required this.id,
    required this.onEdit,
    required this.isPending,
    required this.onDelete,
    required this.onChangePhoto,
    required this.roomIndex,
    required this.fanAvailability,
    required this.washRoomStatus,
    required this.ruppes,
    required this.bedCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      child: Slidable(
        endActionPane: ActionPane(
          extentRatio: 1,
          motion: ScrollMotion(),
          children: this.isPending == true
              ? []
              : [
                  SlidableAction(
                    backgroundColor: Colors.transparent,
                    onPressed: onEdit,
                    foregroundColor: Color(0xff878e92),
                    icon: Icons.edit,
                    label: 'Edit',
                  ),
                  SlidableAction(
                    onPressed: onChangePhoto,
                    backgroundColor: Colors.transparent,
                    foregroundColor: Color(0xff514f53),
                    icon: Icons.photo,
                    label: 'Change',
                  ),
                  SlidableAction(
                    onPressed: onDelete,
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.red,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                ],
        ),
        // endActionPane: ActionPane(motion: motion, children: children),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: FlutterCarousel(
                          items: [
                            Container(
                                height: 100,
                                width: 100,
                                child: CachedNetworkImage(
                                    imageUrl:
                                        "${getIpWithoutSlash()}${images[0].images}")
                                //  Image.asset(
                                //     "assets/profile/citizenship_back.jpeg")
                                ),
                            Container(
                                height: 100,
                                width: 100,
                                child: CachedNetworkImage(
                                    imageUrl:
                                        "${getIpWithoutSlash()}${images[1].images}")),
                          ],
                          options: CarouselOptions(
                              // controller: buttonCarsouselController,
                              height: 100,
                              enlargeCenterPage: true,
                              viewportFraction: 0.9,
                              aspectRatio: 2.0,
                              showIndicator: false,
                              initialPage: 0,
                              autoPlay: true,
                              // showIndicator: true,
                              scrollDirection: Axis.horizontal)),
                    ),
                    Expanded(
                      child: Container(
                        // decoration: BoxDecoration(color: Colors.),
                        // color: Colors.red,
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Room ${roomIndex}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.bed,
                                        // color: Colors.cyan,
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      CustomPoppinsText(
                                          text: bedCount,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ],
                                  ),
                                  // SizedBox()
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.fan,
                                        size: 14,
                                        color: Colors.blue,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      CustomVerifiedWidget(
                                          value: fanAvailability)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.toilet,
                                        size: 14,
                                        color: Colors.orange,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        washRoomStatus,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.dollarSign,
                                        size: 14,
                                        color: Colors.green,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "rs $ruppes",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )
                // Row(
                //   children: [
                //     Container(
                //         height: 50,
                //         width: 50,
                //         child: Image.asset("assets/logos/logo.png"))
                //   ],
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
