import 'dart:io';

import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:stayfinder_vendor/data/model/accommodation_model.dart';
import 'package:stayfinder_vendor/data/model/bloc_form_model.dart';
import 'package:stayfinder_vendor/data/model/room_model.dart';
import 'package:stayfinder_vendor/logic/blocs/add_rental_room/add_rental_room_bloc.dart';
import 'package:stayfinder_vendor/logic/blocs/bloc_exports.dart';
import 'package:stayfinder_vendor/logic/cubits/cubit_exports.dart';
import 'package:stayfinder_vendor/presentation/config/image_helper.dart';
import 'package:stayfinder_vendor/presentation/widgets/widgets_exports.dart';
import 'package:stayfinder_vendor/constants/extensions.dart';

void navigateToAccommodation(DropDownValueState state, BuildContext context) {
  if (state.value == "rental_room") {
    context.read<DropDownValueCubit>().instantiateDropDownValue(
        items: ['Excellent', 'Average', 'Adjustable']);
    Navigator.pushNamed(context, "/addRentalScreen");
  }
  if (state.value == "hotel") {
    Navigator.pushNamed(context, "/addHotelScreen");
  }
  if (state.value == "hostel") {
    context.read<DropDownValueCubit>().instantiateDropDownValue(
        items: ['Excellent', 'Average', 'Adjustable']);
    Navigator.pushNamed(context, "/addHostelScreen");
  }
}

class AccommodationMainScreen extends StatelessWidget {
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
            bottomNavigationBar: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
                child: BlocBuilder<FormBloc, FormsState>(
                  builder: (context, formState) {
                    return CustomMaterialButton(
                        onPressed: () {
                          if (formState.formKey!.currentState!.validate()) {
                            if (context
                                    .read<AddRentalRoomBloc>()
                                    .state
                                    .accommodationImage ==
                                null) {
                              return customScaffold(
                                  context: context,
                                  title: "Image Error",
                                  message: "Please provide accommodation image",
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
                            showExitPopup(
                                context: context,
                                message:
                                    'Are you sure you want sure you want to choose ${context.read<DropDownValueCubit>().state.value} as your accommodation',
                                title: "Confirmation",
                                noBtnFunction: () => Navigator.pop(context),
                                yesBtnFunction: () {
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
                                          accommodation: Accommodation(
                                              parking_availability: false,
                                              trash_dispose_availability: false,
                                              address: formState.address.value,
                                              name: formState.name.value,
                                              city: formState.city.value,
                                              type: context
                                                  .read<DropDownValueCubit>()
                                                  .state
                                                  .value)));
                                  navigateToAccommodation(
                                      context.read<DropDownValueCubit>().state,
                                      context);
                                });
                          }
                        },
                        child: Text("Continue"),
                        backgroundColor: Color(0xff32454D),
                        textColor: Colors.white,
                        height: 50);
                  },
                )),
            body: BlocBuilder<FormBloc, FormsState>(
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Form(
                    key: context.read<FormBloc>().state.formKey,
                    child: Column(
                      children: [
                        Arc(
                          height: 50,
                          arcType: ArcType.CONVEX,
                          child: Container(
                            height: MediaQuery.of(context).size.height / 2.5,
                            decoration: BoxDecoration(
                                color: Color(0xff32454D),
                                image: context
                                            .watch<AddRentalRoomBloc>()
                                            .state
                                            .accommodationImage ==
                                        null
                                    ? DecorationImage(
                                        image: AssetImage(
                                            "assets/images/Building-bro.png"))
                                    : DecorationImage(
                                        fit: BoxFit.cover,
                                        image: FileImage(context
                                            .watch<AddRentalRoomBloc>()
                                            .state
                                            .accommodationImage!))),
                          ),
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
                                                  if (croppedFile != null) {
                                                    context
                                                        .read<
                                                            AddRentalRoomBloc>()
                                                        .add(InitializeRentalRoomAccommodationEvent(
                                                            accommodationImage:
                                                                File(croppedFile
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
}
