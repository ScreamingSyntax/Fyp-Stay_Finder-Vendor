import 'package:flutter/cupertino.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stayfinder_vendor/data/api/api_exports.dart';
import 'package:stayfinder_vendor/logic/cubits/fetch_hotel_with_tier/fetch_hotel_with_tier_cubit.dart';
import 'package:stayfinder_vendor/logic/cubits/update_hotel_with_tier/update_hotel_with_tier_cubit.dart';
import 'package:stayfinder_vendor/presentation/config/config_exports.dart';
import 'package:stayfinder_vendor/presentation/screens/adding_accommodations/view_accommoation_screen.dart/hotel/api_call.dart';
import 'package:stayfinder_vendor/presentation/screens/adding_accommodations/view_accommoation_screen.dart/hotel/hotel_with_tier_rooms_view.dart';
import 'package:stayfinder_vendor/presentation/widgets/widgets_exports.dart';

import '../../../../../constants/constants_exports.dart';
import '../../../../../data/model/model_exports.dart';
import '../../../../../logic/blocs/accommodation_addition/accommodation_addition_bloc.dart';
import '../../../../../logic/blocs/bloc_exports.dart';
import '../../../../../logic/cubits/cubit_exports.dart';
import '../../../../../logic/cubits/store_images/store_images_cubit.dart';

class HotelWithTierView extends StatelessWidget {
  final Map data;

  const HotelWithTierView({super.key, required this.data});

  void fetchHotelWithTierApis(
      {required String token,
      required String accommodationID,
      required BuildContext context}) {
    context.read<FetchHotelWithTierCubit>()
      ..fetchHotelWithTierDetails(
          token: token, acccommodationID: accommodationID);
  }

  @override
  Widget build(BuildContext context) {
    // double c_width = MediaQuery.of(context).size.width * 0.8;

    return Scaffold(
      backgroundColor: Color(0xffe5e5e5),
      body: BlocBuilder<FetchHotelWithTierCubit, FetchHotelWithTierState>(
        builder: (context, state) {
          if (state is FetchHotelTierLoading) {
            return Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [CircularProgressIndicator()],
              ),
            );
          }
          if (state is FetchHotelWithTierError) {
            return Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomPoppinsText(
                      text: state.message,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100.0),
                    child: CustomMaterialButton(
                        onPressed: () async {
                          CallHotelWithTierAPi.fetchHotelWithTierApis(
                              context: context,
                              token: data['token'],
                              accommodationID: data['id'].toString());
                          // fetchHotelWithTierApis(
                          //     accommodationID: data['id'].toString(),
                          //     token: data['token'],
                          //     context: context);
                        },
                        child: Text("Retry"),
                        backgroundColor: Color(0xff4C4C4C),
                        textColor: Colors.white,
                        height: 45),
                  )
                ],
              ),
            );
          }
          if (state is FetchHotelTierSuccess) {
            return HotelWithTierSuccessViewScreen(
              data: data,
              fetchHotelTierSuccess: state,
            );
          }
          return Column(
            children: [],
          );
        },
      ),
    );
  }
}

class HotelWithTierSuccessViewScreen extends StatelessWidget {
  final Map data;
  final FetchHotelTierSuccess fetchHotelTierSuccess;
  HotelWithTierSuccessViewScreen(
      {super.key, required this.data, required this.fetchHotelTierSuccess});

  Future<dynamic> editTier(
      {required BuildContext context,
      required String token,
      required int id,
      required HotelTier tier}) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return BlocProvider(
          create: (context) =>
              ImageHelperCubit()..imageHelperAccess(imageHelper: ImageHelper()),
          child: Builder(builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.5,
                          child: CustomMaterialButton(
                              onPressed: () async {
                                var imageHelper = context
                                    .read<ImageHelperCubit>()
                                    .state
                                    .imageHelper!;
                                final files = await imageHelper.pickImage();
                                if (files.isNotEmpty) {
                                  final croppedFile = await imageHelper.crop(
                                      file: files.first,
                                      cropStyle: CropStyle.rectangle);
                                  print("This is cropped file ");
                                  if (croppedFile != null) {
                                    context.read<UpdateHotelWithTierCubit>()
                                      ..updateHotelTierImage(
                                          tier_id: id,
                                          token: data['token'],
                                          image: File(croppedFile.path));
                                    Navigator.pop(context);
                                  }
                                }
                              },
                              child: Text("Change Image"),
                              backgroundColor: Colors.black.withOpacity(0.5),
                              textColor: Colors.white,
                              height: 45),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.5,
                          child: CustomMaterialButton(
                              onPressed: () {
                                editAccommodationDetails(
                                    context: context,
                                    hotelTier: tier,
                                    token: token);
                              },
                              child: Text("Edit Tier Details"),
                              backgroundColor: Colors.black.withOpacity(0.5),
                              textColor: Colors.white,
                              height: 45),
                        )
                      ],
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

  Future<dynamic> editAccommodationDetails(
      {required BuildContext context,
      required String token,
      required HotelTier hotelTier}) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return BlocProvider(
          create: (context) => FormBloc()..add(InitEvent()),
          child: Builder(builder: (context) {
            return BlocBuilder<FormBloc, FormsState>(
              builder: (context, state) {
                return SingleChildScrollView(
                    child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: state.formKey,
                    child: Column(
                      children: [
                        CustomFormField(
                          initialValue: hotelTier.tier_name,
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
                          initialValue: hotelTier.description,
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
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 65.0, vertical: 20),
                          child: CustomMaterialButton(
                              onPressed: () {
                                if (state.formKey!.currentState!.validate()) {
                                  Map datal = {
                                    'hoteltier_id': hotelTier.id.toString(),
                                    'tier_name': state.name.value == ''
                                        ? hotelTier.tier_name
                                        : state.name.value,
                                    'description': state.city.value == ''
                                        ? hotelTier.description
                                        : state.city.value,
                                  };
                                  print("Thisi sthe data ${datal}");

                                  context.read<UpdateHotelWithTierCubit>()
                                    ..updateHotelWithTierTierDetails(
                                        token: token, data: datal);
                                }
                              },
                              child: Text("Update Details"),
                              backgroundColor: Colors.black.withOpacity(0.5),
                              textColor: Colors.white,
                              height: 45),
                        )
                      ],
                    ),
                  ),
                ));
              },
            );
          }),
        );
      },
    );
  }

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
          child:
              BlocListener<UpdateHotelWithTierCubit, UpdateHotelWithTierState>(
            listener: (context, state) {
              // TODO: implement listener
              if (state is UpdateHotelWithTierLoading) {
                customScaffold(
                    context: context,
                    title: "Loading",
                    message: "Please Waitt",
                    contentType: ContentType.warning);
              }

              if (state is UpdateHotelWithTierSuccess) {
                // callHotelWithTierApis(
                //     context: context,
                //     token: data['token'],
                //     accommodationID: data['id']);
                CallHotelWithTierAPi.fetchHotelWithTierApis(
                    context: context,
                    token: data['token'],
                    accommodationID: data['id'].toString());
                customScaffold(
                    context: context,
                    title: "Success",
                    message: state.message,
                    contentType: ContentType.success);
              }

              if (state is UpdateHotelWithTierError) {
                customScaffold(
                    context: context,
                    title: "Error",
                    message: state.message,
                    contentType: ContentType.failure);
              }
            },
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
                                  width:
                                      MediaQuery.of(context).size.width / 1.3,
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
                                          value: accommodation
                                              .parking_availability!,
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
                                                ..add(AccommodationAdditionUpdateHitEvent(
                                                    accommodation:
                                                        accommodation.copyWith(
                                                            gym_availability:
                                                                p0)));
                                            }
                                          },
                                          value:
                                              accommodation.gym_availability!,
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
                                          if (accommodationState
                                                  .accommodation !=
                                              null) {
                                            context.read<
                                                AccommodationAdditionBloc>()
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
                                  'swimming_pool_availability':
                                      stateAccommodation
                                          .swimming_pool_availability
                                          .toString()
                                };
                                print("The data is ${updateData}");
                                await context.read<UpdateHotelWithTierCubit>()
                                  ..updateAccommodationDetail(
                                      data: updateData, token: data['token']);
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
          ),
        );
      },
    );
  }

  Future<dynamic> addTier(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => FormBloc()..add(InitEvent()),
            ),
            BlocProvider(
              create: (context) => StoreImagesCubit(),
            ),
            BlocProvider(
              create: (context) => ImageHelperCubit()
                ..imageHelperAccess(imageHelper: ImageHelper()),
            ),
          ],
          child: Builder(builder: (context) {
            return SingleChildScrollView(
              child: BlocBuilder<FormBloc, FormsState>(
                builder: (context, state) {
                  return Padding(
                    padding: EdgeInsets.all(20),
                    child: Form(
                      key: state.formKey,
                      child: Column(
                        children: [
                          context.watch<StoreImagesCubit>().state.images.isEmpty
                              ? Text(
                                  "Add atleast one image",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                )
                              : Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      // color: Colors.black,
                                      border: Border.all(
                                          color: Colors.black, width: 0.5),
                                      image: DecorationImage(
                                          image: FileImage(context
                                              .read<StoreImagesCubit>()
                                              .state
                                              .images[0]))),
                                ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomFormField(
                            onTapOutside: (p0) =>
                                FocusScope.of(context).unfocus(),
                            validatior: (p0) {
                              print("The value of p is //");
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 3,
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
                                        print("This is cropped file ");
                                        if (croppedFile != null) {
                                          context.read<StoreImagesCubit>()
                                            ..addImage(File(croppedFile.path));
                                          // context
                                          //     .read<UpdateHotelWithTierCubit>()
                                          //   ..updateAccommodationImage(
                                          //       accommodation_id: data['id'],
                                          //       token: data['token'],
                                          //       image: File(croppedFile.path));
                                          // var loginState = context.read<LoginBloc>().state;
                                          // print("The file is ${File(croppedFile.path)}");
                                          // File file = File(croppedFile.path);
                                          // if (loginState is LoginLoaded) {
                                          //   await context.read<UpdateHotelWithoutTierCubit>()
                                          //     ..updateAccommodationImage(
                                          //         token: loginState.successModel.token!,
                                          //         image: file,
                                          //         id: data['id']);
                                          //   await callHotelWithoutTierApis(
                                          //       accommodationID: data['id'],
                                          //       context: context,
                                          //       token: data['token']);
                                        }
                                      }
                                    },
                                    child: Text("Add Image"),
                                    backgroundColor:
                                        Colors.black.withOpacity(0.5),
                                    textColor: Colors.white,
                                    height: 45),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 3,
                                child: CustomMaterialButton(
                                    onPressed: () async {
                                      if (state.formKey!.currentState!
                                          .validate()) {
                                        var roomState = context
                                            .read<StoreImagesCubit>()
                                            .state;
                                        var formState =
                                            context.read<FormBloc>().state;
                                        if (roomState.images.isNotEmpty) {
                                          context
                                              .read<UpdateHotelWithTierCubit>()
                                            ..addTier(
                                                token: data['token'],
                                                tierName: formState.name.value,
                                                description:
                                                    formState.city.value,
                                                image: roomState.images[0],
                                                accommodationId: data['id']);
                                        }
                                        Navigator.pop(context);
                                        // Map datal = {
                                        //   'hoteltier_id': hotelTier.id.toString(),
                                        //   'tier_name': state.name.value == ''
                                        //       ? hotelTier.tier_name
                                        //       : state.name.value,
                                        //   'description': state.city.value == ''
                                        //       ? hotelTier.description
                                        //       : state.city.value,
                                        // };
                                        // print("Thisi sthe data ");

                                        // context.read<UpdateHotelWithTierCubit>()
                                        //   ..updateHotelWithTierTierDetails(
                                        //       token: token, data: datal);
                                      }
                                    },
                                    child: Text("Add Tier"),
                                    backgroundColor:
                                        Colors.black.withOpacity(0.5),
                                    textColor: Colors.white,
                                    height: 45),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ImageHelperCubit()..imageHelperAccess(imageHelper: ImageHelper()),
      child: Builder(builder: (context) {
        return MultiBlocListener(
          listeners: [
            BlocListener<UpdateHotelWithTierCubit, UpdateHotelWithTierState>(
              listener: (context, state) {
                if (state is UpdateHotelWithTierLoading) {
                  customScaffold(
                      context: context,
                      title: "Loading",
                      message: "Please Waitt",
                      contentType: ContentType.warning);
                }

                if (state is UpdateHotelWithTierSuccess) {
                  CallHotelWithTierAPi.fetchHotelWithTierApis(
                      context: context,
                      token: data['token'],
                      accommodationID: data['id'].toString());
                  customScaffold(
                      context: context,
                      title: "Success",
                      message: state.message,
                      contentType: ContentType.success);
                }

                if (state is UpdateHotelWithTierError) {
                  customScaffold(
                      context: context,
                      title: "Error",
                      message: state.message,
                      contentType: ContentType.failure);
                }
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
                  CallHotelWithTierAPi.fetchHotelWithTierApis(
                      context: context,
                      token: data['token'],
                      accommodationID: data['id'].toString());
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
          child: RefreshIndicator(
            onRefresh: () async {
              CallHotelWithTierAPi.fetchHotelWithTierApis(
                  token: data['token'],
                  accommodationID: data['id'].toString(),
                  context: context);
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 270,
                    child: Stack(
                      children: [
                        CustomMainImageVIew(
                            imageLink:
                                "${getIpWithoutSlash()}${fetchHotelTierSuccess.accommodation.image}"),
                        if (fetchHotelTierSuccess.accommodation.is_pending! ==
                            false)
                          Positioned(
                              right: 20,
                              top: 20,
                              child: EditDeleteButtonWidget(
                                  deleteOnTap: () async {},
                                  editOnTap: () async {
                                    var imageHelper = context
                                        .read<ImageHelperCubit>()
                                        .state
                                        .imageHelper!;
                                    final files = await imageHelper.pickImage();
                                    if (files.isNotEmpty) {
                                      final croppedFile =
                                          await imageHelper.crop(
                                              file: files.first,
                                              cropStyle: CropStyle.rectangle);
                                      print("This is cropped file ");
                                      if (croppedFile != null) {
                                        context.read<UpdateHotelWithTierCubit>()
                                          ..updateAccommodationImage(
                                              accommodation_id: data['id'],
                                              token: data['token'],
                                              image: File(croppedFile.path));
                                        // var loginState = context.read<LoginBloc>().state;
                                        // print("The file is ${File(croppedFile.path)}");
                                        // File file = File(croppedFile.path);
                                        // if (loginState is LoginLoaded) {
                                        //   await context.read<UpdateHotelWithoutTierCubit>()
                                        //     ..updateAccommodationImage(
                                        //         token: loginState.successModel.token!,
                                        //         image: file,
                                        //         id: data['id']);
                                        //   await callHotelWithoutTierApis(
                                        //       accommodationID: data['id'],
                                        //       context: context,
                                        //       token: data['token']);
                                      }
                                    }
                                  })),
                        Positioned(
                            left: 1,
                            bottom: -1,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (fetchHotelTierSuccess
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
                                  if (fetchHotelTierSuccess
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
                                  if (fetchHotelTierSuccess
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
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.all(20),
                      // color: Colors.amber,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      CustomPoppinsText(
                                          text: fetchHotelTierSuccess
                                              .accommodation.name!,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                      SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  ),
                                ),
                                if (fetchHotelTierSuccess
                                        .accommodation.is_pending! !=
                                    true)
                                  InkWell(
                                    onTap: () async {
                                      await editAccommodaiton(
                                          accommodation: fetchHotelTierSuccess
                                              .accommodation,
                                          context: context);
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
                                        "${fetchHotelTierSuccess.accommodation.city}, ${fetchHotelTierSuccess.accommodation.address}",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
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
                                              value: fetchHotelTierSuccess
                                                  .accommodation
                                                  .parking_availability!)
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
                                              value: fetchHotelTierSuccess
                                                  .accommodation
                                                  .gym_availability!)
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
                                              value: fetchHotelTierSuccess
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
                        children: [
                          CustomPoppinsText(
                              text: "Scroll horizontally to view Tiers",
                              fontSize: 12,
                              fontWeight: FontWeight.w500)
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 400,
                    // width: 100,
                    child: ListView.builder(
                        itemCount: fetchHotelTierSuccess.tier.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          HotelTier hotelTier =
                              fetchHotelTierSuccess.tier[index];
                          int room_count = 0;
                          int startingPrice = 0;
                          int endingPrice = 0;
                          List<Room> sortedRooms = [];
                          fetchHotelTierSuccess.room.forEach((element) {
                            if (element.hotel_tier == hotelTier.id) {
                              room_count += 1;
                              sortedRooms.add(element);
                            }
                          });
                          // parseint
                          sortedRooms.sort(
                            (a, b) {
                              return a.per_day_rent!.compareTo(b.per_day_rent!);
                            },
                          );
                          if (sortedRooms.length == 1) {
                            startingPrice = sortedRooms[0].per_day_rent!;
                            endingPrice = sortedRooms[0].per_day_rent!;
                          }
                          if (sortedRooms.length >= 2) {
                            startingPrice = sortedRooms[0].per_day_rent!;
                            endingPrice = sortedRooms[sortedRooms.length - 1]
                                .per_day_rent!;
                          }
                          return InkWell(
                            onTap: () {
                              data['tier'] = hotelTier.id;
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) =>
                                    HotelWithTierRoomsView(data: data),
                              ));
                              // MaterialPageRoute(builder: (context) =>);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Container(
                                  // padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    // mainAxisAlignment,
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      // Text()
                                      Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Container(
                                              height: 150,
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    "${getIpWithoutSlash()}${hotelTier.image}",
                                                imageBuilder:
                                                    (context, imageProvider) {
                                                  return Container(
                                                    // alignment: Alignment.center,
                                                    // padding: EdgeInsets.all(19),
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            1,
                                                    height: 150,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        image: DecorationImage(
                                                            alignment: Alignment
                                                                .center,
                                                            image:
                                                                imageProvider,
                                                            fit: BoxFit.cover)),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          if (fetchHotelTierSuccess
                                                  .accommodation.is_pending !=
                                              true)
                                            Positioned(
                                                right: 30,
                                                top: 40,
                                                child: Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        editTier(
                                                            tier: hotelTier,
                                                            context: context,
                                                            token:
                                                                data['token'],
                                                            id: hotelTier.id!);
                                                      },
                                                      child: Container(
                                                          height: 35,
                                                          width: 35,
                                                          // padding: EdgeInsets.all(10),
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                          child:
                                                              Icon(Icons.edit)),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        context.read<
                                                            UpdateHotelWithTierCubit>()
                                                          ..deleteTier(
                                                              token:
                                                                  data['token'],
                                                              hotelTierId:
                                                                  hotelTier.id
                                                                      .toString());
                                                      },
                                                      child: Container(
                                                          height: 35,
                                                          width: 35,
                                                          decoration: BoxDecoration(
                                                              color: Colors.red,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                          child: Icon(
                                                            Icons.delete,
                                                            color: Colors.white,
                                                          )),
                                                    ),
                                                  ],
                                                ))
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 2),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  // width: /,
                                                  // height: 30,
                                                  child: CustomPoppinsText(
                                                      text:
                                                          hotelTier.tier_name!,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons.bed,
                                                            color: Colors.brown,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          CustomPoppinsText(
                                                              text: room_count
                                                                  .toString(),
                                                              color:
                                                                  Colors.brown,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            CupertinoIcons
                                                                .money_dollar,
                                                            color: Colors.red,
                                                            // size: 15,
                                                          ),
                                                          CustomPoppinsText(
                                                              text:
                                                                  "$startingPrice -  $endingPrice",
                                                              color: Colors.red,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            CustomPoppinsText(
                                                text: hotelTier.description!,
                                                fontSize: 13,
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                                fontWeight: FontWeight.w500),
                                            SizedBox(
                                              height: 30,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: InkWell(
                      onTap: () {
                        addTier(context);
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [Icon(Icons.add), Text("Add Tier")],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (fetchHotelTierSuccess.accommodation.is_rejected!)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: Column(
                        children: [
                          BlocBuilder<ResumbitAccommodationVerificationCubit,
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
                                            token:
                                                loginState.successModel.token!,
                                            accommodationId:
                                                fetchHotelTierSuccess
                                                    .accommodation.id!);
                                    }
                                  },
                                  child: Text("Resubmit for Verification"),
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
            ),
          ),
        );
      }),
    );
  }
}
