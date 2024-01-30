import 'dart:io';

import 'package:stayfinder_vendor/logic/blocs/bloc_exports.dart';
import 'package:stayfinder_vendor/logic/cubits/cubit_exports.dart';
import 'package:stayfinder_vendor/presentation/config/image_helper.dart';
import 'package:stayfinder_vendor/presentation/widgets/widgets_exports.dart';

import '../../constants/constants_exports.dart';

class InformationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context
        .read<ImageHelperCubit>()
        .imageHelperAccess(imageHelper: ImageHelper());
    // var imagePicker = context.read<
    TextEditingController editingController = TextEditingController();

    return BlocProvider(
      create: (context) => FormBloc(),
      child: BlocConsumer<FetchVendorProfileBloc, FetchVendorProfileState>(
        listener: (context, fetchVendorState) {},
        builder: (context, fetchVendorState) {
          if (fetchVendorState is FetchVendorProfileLoaded) {
            var custoDecoration = OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Color(0xff29383F),
                ),
                borderRadius: BorderRadius.circular(
                  5,
                ));
            // if()
            if (fetchVendorState.vendorProfile.is_under_verification_process ==
                    'True' ||
                fetchVendorState.vendorProfile.is_verified == "True") {
              editingController.text = fetchVendorState.vendorProfile.address!;
            }
            return BlocListener<ProfileVerificationBloc,
                ProfileVerificationState>(
              listener: (context, dataProviderState) {
                if (dataProviderState is ProfileVerificationLoadedState) {
                  Navigator.pop(context);
                  customScaffold(
                      context: context,
                      title: "Successfully Send",
                      message: "Your data is send for verfication",
                      contentType: ContentType.success);
                  return context
                      .read<ProfileVerificationBloc>()
                      .add(ProfileVerificationResetEvent());
                }
                if (dataProviderState is ProfileVerificationErrorState) {
                  customScaffold(
                      context: context,
                      title: "Error",
                      message: dataProviderState.message,
                      contentType: ContentType.failure);
                  Navigator.pushNamed(context, "/home");
                }
              },
              child: Scaffold(
                appBar: PreferredSize(
                    preferredSize: Size.fromHeight(100),
                    child: InformationScreenAppBar(
                        fetchVendorState: fetchVendorState)),
                body: Form(
                  key: context.watch<FormBloc>().state.formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // if (fetchVendorState.vendorProfile.is_rejected ==
                        //     'True')
                        fetchVendorState.vendorProfile.is_rejected == 'True'
                            ? ProfileRejectedMessageWidget(
                                fetchVendorState: fetchVendorState,
                              )
                            : SizedBox(),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                              color: Color(
                                0xffDAD7CD,
                              ),
                              borderRadius: BorderRadius.circular(5)),
                          width: MediaQuery.of(context).size.width,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                CustomPoppinsText(
                                  text: "Document Details",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff29383F),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                CustomPoppinsText(
                                  text: "Profile Photo",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff29383F),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color:
                                            Color(0xff29383F).withOpacity(0.5),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: InkWell(
                                                  onTap: (fetchVendorState
                                                                  .vendorProfile
                                                                  .is_under_verification_process ==
                                                              'True' ||
                                                          fetchVendorState
                                                                  .vendorProfile
                                                                  .is_verified ==
                                                              'True')
                                                      ? null
                                                      : () async {
                                                          var imageHelper = context
                                                              .read<
                                                                  ImageHelperCubit>()
                                                              .state
                                                              .imageHelper!;
                                                          final files =
                                                              await imageHelper
                                                                  .pickImage();
                                                          if (files
                                                              .isNotEmpty) {
                                                            final croppedFile =
                                                                await imageHelper.crop(
                                                                    file: files
                                                                        .first,
                                                                    cropStyle:
                                                                        CropStyle
                                                                            .rectangle);
                                                            if (croppedFile !=
                                                                null) {
                                                              context
                                                                  .read<
                                                                      DocumentDetailDartBloc>()
                                                                  .add(ProfilePictureAddEvent(
                                                                      profilePicture:
                                                                          File(croppedFile
                                                                              .path)));
                                                            }
                                                          }
                                                        },
                                                  child: (context
                                                              .watch<
                                                                  DocumentDetailDartBloc>()
                                                              .state
                                                              .profilePicture ==
                                                          null)
                                                      ? CachedNetworkImage(
                                                          width: 100,
                                                          height: 100,
                                                          fit: BoxFit.fill,
                                                          imageUrl:
                                                              "${getIpWithoutSlash()}${fetchVendorState.vendorProfile.profile_picture}")
                                                      : Image.file(
                                                          context
                                                              .read<
                                                                  DocumentDetailDartBloc>()
                                                              .state
                                                              .profilePicture!,
                                                          width: 100,
                                                          height: 100,
                                                          fit: BoxFit.fill,
                                                        )),
                                            ),
                                          )
                                        ])),
                                SizedBox(
                                  height: 20,
                                ),
                                CustomPoppinsText(
                                  text: "Citizenship Photo",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff29383f),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                CustomPoppinsText(
                                    text: "Front",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                                Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:
                                            Color(0xff29383F).withOpacity(0.5)),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: (fetchVendorState
                                                            .vendorProfile
                                                            .is_under_verification_process ==
                                                        'True' ||
                                                    fetchVendorState
                                                            .vendorProfile
                                                            .is_verified ==
                                                        'True')
                                                ? null
                                                : () async {
                                                    var imageHelper = context
                                                        .read<
                                                            ImageHelperCubit>()
                                                        .state
                                                        .imageHelper!;
                                                    final files =
                                                        await imageHelper
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
                                                                DocumentDetailDartBloc>()
                                                            .add(NagriktaFrontPictureAddEvent(
                                                                nagriktaFront: File(
                                                                    croppedFile
                                                                        .path)));
                                                      }
                                                    }
                                                  },
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: context
                                                            .watch<
                                                                DocumentDetailDartBloc>()
                                                            .state
                                                            .nagriktaFront ==
                                                        null
                                                    ? CachedNetworkImage(
                                                        width: 100,
                                                        height: 100,
                                                        fit: BoxFit.fill,
                                                        imageUrl:
                                                            "${getIpWithoutSlash()}${fetchVendorState.vendorProfile.citizenship_front}")
                                                    : Image.file(
                                                        context
                                                            .read<
                                                                DocumentDetailDartBloc>()
                                                            .state
                                                            .nagriktaFront!,
                                                        height: 100,
                                                        width: 100,
                                                        fit: BoxFit.fill,
                                                      )),
                                          )
                                        ])),
                                SizedBox(
                                  height: 20,
                                ),
                                CustomPoppinsText(
                                  text: "Back",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff29383f),
                                ),
                                Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:
                                            Color(0xff29383F).withOpacity(0.5)),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: (fetchVendorState
                                                            .vendorProfile
                                                            .is_under_verification_process ==
                                                        'True' ||
                                                    fetchVendorState
                                                            .vendorProfile
                                                            .is_verified ==
                                                        'True')
                                                ? null
                                                : () async {
                                                    var imageHelper = context
                                                        .read<
                                                            ImageHelperCubit>()
                                                        .state
                                                        .imageHelper!;
                                                    final files =
                                                        await imageHelper
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
                                                                DocumentDetailDartBloc>()
                                                            .add(NagriktaBackPictureAddEvent(
                                                                nagriktaBack: File(
                                                                    croppedFile
                                                                        .path)));
                                                      }
                                                    }
                                                  },
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: context
                                                            .watch<
                                                                DocumentDetailDartBloc>()
                                                            .state
                                                            .nagriktaBack ==
                                                        null
                                                    ? CachedNetworkImage(
                                                        width: 100,
                                                        height: 100,
                                                        fit: BoxFit.fill,
                                                        imageUrl:
                                                            "${getIpWithoutSlash()}${fetchVendorState.vendorProfile.citizenship_back}")
                                                    : Image.file(
                                                        context
                                                            .read<
                                                                DocumentDetailDartBloc>()
                                                            .state
                                                            .nagriktaBack!,
                                                        width: 100,
                                                        height: 100,
                                                        fit: BoxFit.fill,
                                                      )),
                                          )
                                        ])),
                                SizedBox(
                                  height: 20,
                                ),
                                CustomPoppinsText(
                                  text: "Enter Address",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff29383f),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                BlocProvider(
                                  create: (context) => ClickedItemCubit(),
                                  child: BlocBuilder<ClickedItemCubit,
                                      ClickedItemState>(
                                    builder: (context, state) {
                                      return TextFormField(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Address canot be null";
                                          }
                                          if (value.length <= 5) {
                                            return "Address cannnot be less than 5 characters";
                                          }
                                          return null;
                                        },
                                        enabled: (fetchVendorState.vendorProfile
                                                        .is_under_verification_process ==
                                                    'True' ||
                                                fetchVendorState.vendorProfile
                                                        .is_verified ==
                                                    'True')
                                            ? false
                                            : true,
                                        controller: editingController,
                                        onTapOutside: (event) =>
                                            FocusScope.of(context).unfocus(),
                                        decoration: InputDecoration(
                                          hintText: "Dharan - 12 , Sunsari",
                                          suffixIcon: InkWell(
                                              onTap: () {
                                                context.read<ClickedItemCubit>()
                                                  ..clickedUnique(
                                                      !state.clicked);
                                              },
                                              child: Icon(Icons.edit)),
                                          isDense: true,
                                          focusedBorder: custoDecoration,
                                          enabledBorder: custoDecoration,
                                          disabledBorder: custoDecoration,
                                          border: custoDecoration,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                BlocBuilder<FormBloc, FormsState>(
                                  builder: (context, state) {
                                    if (fetchVendorState.vendorProfile
                                            .is_under_verification_process ==
                                        'True') {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              "Your account is under verification"),
                                        ],
                                      );
                                    } else {
                                      return (fetchVendorState
                                                  .vendorProfile.is_verified ==
                                              "True")
                                          ? SizedBox()
                                          : BlocBuilder<ProfileVerificationBloc,
                                                  ProfileVerificationState>(
                                              builder: (context, profiloState) {
                                              if (profiloState
                                                  is ProfileVerificationLoadingState) {
                                                return Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      CircularProgressIndicator(),
                                                    ],
                                                  ),
                                                );
                                              }
                                              return AnimatedContainer(
                                                  duration:
                                                      Duration(seconds: 2),
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: CustomMaterialButton(
                                                    backgroundColor:
                                                        Color(0xff546464),
                                                    height: 40,
                                                    textColor: Colors.white,
                                                    onPressed: () {
                                                      if (state.formKey!
                                                          .currentState!
                                                          .validate()) {
                                                        var imageState = context
                                                            .read<
                                                                DocumentDetailDartBloc>()
                                                            .state;
                                                        if (imageState.nagriktaBack == null &&
                                                            imageState
                                                                    .nagriktaFront ==
                                                                null &&
                                                            imageState
                                                                    .profilePicture ==
                                                                null) {
                                                          return customScaffold(
                                                              context: context,
                                                              title:
                                                                  "No Document photos",
                                                              message:
                                                                  "Please attach your document photos above",
                                                              contentType:
                                                                  ContentType
                                                                      .failure);
                                                        }
                                                        if (imageState
                                                                .nagriktaFront ==
                                                            null) {
                                                          return customScaffold(
                                                              context: context,
                                                              title:
                                                                  "Citizenship Picture",
                                                              message:
                                                                  "Dear User, Please attach of your citizenship facing front",
                                                              contentType:
                                                                  ContentType
                                                                      .failure);
                                                        }
                                                        if (imageState
                                                                .nagriktaBack ==
                                                            null) {
                                                          return customScaffold(
                                                              context: context,
                                                              title:
                                                                  "Citizenship Picture",
                                                              message:
                                                                  "Dear User, Please attach of your citizenship facing backwards",
                                                              contentType:
                                                                  ContentType
                                                                      .failure);
                                                        }
                                                        if (imageState
                                                                .profilePicture ==
                                                            null) {
                                                          return customScaffold(
                                                              context: context,
                                                              title:
                                                                  "Profile Photo not Added",
                                                              message:
                                                                  "Dear User, Please add your Picture",
                                                              contentType:
                                                                  ContentType
                                                                      .failure);
                                                        }
                                                        var state = context
                                                            .read<LoginBloc>()
                                                            .state;
                                                        if (state
                                                            is LoginLoaded) {
                                                          context.read<ProfileVerificationBloc>().add(ProfileVerificationHitEvent(
                                                              token: state
                                                                  .successModel
                                                                  .token!,
                                                              profilePicture:
                                                                  imageState
                                                                      .profilePicture!,
                                                              citizenshipFront:
                                                                  imageState
                                                                      .nagriktaFront!,
                                                              citizenshipBack:
                                                                  imageState
                                                                      .nagriktaBack!,
                                                              address:
                                                                  editingController
                                                                      .text));
                                                        }
                                                      }
                                                    },
                                                    child: Text(
                                                        "Submit for verification"),
                                                  ));
                                            });
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 30,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return Scaffold(
              body: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [CustomCircularBar(message: "Fetching ")],
            ),
          ));
        },
      ),
    );
  }
}

class ProfileRejectedMessageWidget extends StatelessWidget {
  final FetchVendorProfileLoaded fetchVendorState;
  const ProfileRejectedMessageWidget({
    super.key,
    required this.fetchVendorState,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(
            0xffDAD7CD,
          ),
          borderRadius: BorderRadius.circular(5)),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Your profile got rejected, Please submit again",
            style: TextStyle(
                color: Colors.red.withOpacity(0.7),
                fontSize: 16,
                fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "-  Reason :  ${fetchVendorState.vendorProfile.rejected_message}",
            style: TextStyle(
                color: Color(0xff29383F),
                fontSize: 12,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class InformationScreenAppBar extends StatelessWidget {
  final FetchVendorProfileLoaded fetchVendorState;
  const InformationScreenAppBar({
    super.key,
    required this.fetchVendorState,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Container(
              width: 120,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Color(
                    0xffDAD7CD,
                  ),
                  borderRadius: BorderRadius.circular(50)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    (fetchVendorState.vendorProfile.is_verified == "True")
                        ? Icons.verified
                        : Icons.error,
                    size: 20,
                  ),
                  (fetchVendorState.vendorProfile.is_verified == "True")
                      ? Text("Verified")
                      : Text("Unverified")
                ],
              )),
        )
      ],
      title: Text(
        "My Information",
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
