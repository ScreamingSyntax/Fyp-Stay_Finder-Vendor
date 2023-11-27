import 'dart:io';

import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:stayfinder_vendor/constants/constants_exports.dart';
import 'package:stayfinder_vendor/data/model/bloc_form_model.dart';
import 'package:stayfinder_vendor/logic/blocs/add_rental_room/add_rental_room_bloc.dart';
import 'package:stayfinder_vendor/logic/blocs/bloc_exports.dart';
import 'package:stayfinder_vendor/logic/cubits/cubit_exports.dart';
import 'package:stayfinder_vendor/presentation/config/image_helper.dart';
import 'package:stayfinder_vendor/presentation/widgets/widgets_exports.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

class HostelAdditionScreen extends StatelessWidget {
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
      ],
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: Builder(builder: (context) {
            return Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: CustomMaterialButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Column(
                              children: [
                                // Text("")
                                SizedBox(
                                  height: 20,
                                ),
                                CustomPoppinsText(
                                  text: "Add your room data",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff514f53),
                                ),

                                BlocBuilder<DropDownValueCubit,
                                    DropDownValueState>(
                                  builder: (context, state) {
                                    return Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
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
                                                          color:
                                                              Color(0xff878e92),
                                                          width: 1.3),
                                                      color: Color(0xffe5e5e5),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child:
                                                      DropdownButtonHideUnderline(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 13.0),
                                                      child:
                                                          CustomDropDownButton(
                                                        state: state,
                                                        items: state.items!
                                                            .map<
                                                                DropdownMenuItem<
                                                                    String>>((value) =>
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
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 20.0),
                                                    child: CustomMaterialButton(
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
                                                          xFiles
                                                              .forEach((xFile) {
                                                            files.add(File(
                                                                xFile.path));
                                                          });

                                                          if (files.length !=
                                                              3) {
                                                            customScaffold(
                                                                context:
                                                                    context,
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
                                                        child: Text(
                                                          "Add Images",
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        ),
                                                        backgroundColor:
                                                            Color(0xff514f53),
                                                        textColor: Colors.white,
                                                        height: 47),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 50.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          CustomCheckBoxTile(
                                              title: "Fan",
                                              onChanged: (p0) {},
                                              value: false,
                                              icon: Icons.cached),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.5,
                                              child: CustomFormField(
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                prefixIcon: Icon(CupertinoIcons
                                                    .money_dollar),
                                                labelText: "Rate",
                                                keyboardType:
                                                    TextInputType.number,
                                                validatior: (p0) {
                                                  return null;
                                                },
                                                onTapOutside: (p0) =>
                                                    FocusScope.of(context)
                                                        .unfocus(),
                                                onChange: (p0) {},
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
                                        labelText: "Washroom Count",
                                        keyboardType: TextInputType.number,
                                        validatior: (p0) {
                                          return null;
                                        },
                                        onTapOutside: (p0) =>
                                            FocusScope.of(context).unfocus(),
                                        onChange: (p0) {},
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      CustomMaterialButton(
                                          onPressed: () {},
                                          child: Text("Confirm Addition"),
                                          backgroundColor: Color(0xff32454D),
                                          textColor: Colors.white,
                                          height: 50),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        );
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
                  child: CustomMaterialButton(
                      onPressed: () {},
                      child: Text(
                        "Confirm Addition",
                        style: TextStyle(fontSize: 12),
                      ),
                      backgroundColor: Color(0xff32454D),
                      textColor: Colors.white,
                      height: 50),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8.0),
                        child: Column(
                          children: [
                            CustomFormField(
                              validatior: (p0) {
                                if (p0!.isEmpty || p0 == Null) {
                                  return "Admission Rate cannot be empty";
                                }
                                if (!(p0.isValidNumber)) {
                                  return "Please enter a valid Number";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                              onTapOutside: (p0) =>
                                  FocusScope.of(context).unfocus(),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              labelText: "Meals per day",
                              prefixIcon: Icon(Boxicons.bx_coffee_togo),
                            ),
                            CustomFormField(
                              validatior: (p0) {
                                if (p0!.isEmpty || p0 == Null) {
                                  return "Admission Rate cannot be empty";
                                }
                                if (!(p0.isValidNumber)) {
                                  return "Please enter a valid Number";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
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
                                  return "Admission Rate cannot be empty";
                                }
                                if (!(p0.isValidNumber)) {
                                  return "Please enter a valid Number";
                                }
                                return null;
                              },
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
                              validatior: (p0) {
                                if (p0!.isEmpty || p0 == Null) {
                                  return "Admission Rate cannot be empty";
                                }
                                if (!(p0.isValidNumber)) {
                                  return "Please enter a valid Number";
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
                              validatior: (p0) {
                                if (p0!.isEmpty || p0 == Null) {
                                  return "Admission Rate cannot be empty";
                                }
                                if (!(p0.isValidNumber)) {
                                  return "Please enter a valid Number";
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
                    ]),
              );
            }),
          ),
        ),
      ),
    );
  }
}
