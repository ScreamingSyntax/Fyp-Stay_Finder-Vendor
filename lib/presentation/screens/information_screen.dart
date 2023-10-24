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
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is FetchVendorProfileLoaded) {
            var custoDecoration = OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Color(0xff29383F),
                ),
                borderRadius: BorderRadius.circular(
                  5,
                ));
            return Scaffold(
              appBar: AppBar(
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
                              (state.vendorProfile.is_verified == "True")
                                  ? Icons.verified
                                  : Icons.error,
                              size: 20,
                            ),
                            (state.vendorProfile.is_verified == "True")
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
              ),
              body: Form(
                key: context.watch<FormBloc>().state.formKey,
                child: Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(16),
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
                        Text("Document Details",
                            style: TextStyle(
                                color: Color(0xff29383F),
                                fontSize: 16,
                                fontWeight: FontWeight.w700)),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Profile Photo",
                            style: TextStyle(
                                color: Color(0xff29383F),
                                fontSize: 12,
                                fontWeight: FontWeight.w500)),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Color(0xff29383F).withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                          onTap: () async {
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
                                              if (croppedFile != null) {
                                                context
                                                    .read<
                                                        DocumentDetailDartBloc>()
                                                    .add(ProfilePictureAddEvent(
                                                        profilePicture: File(
                                                            croppedFile.path)));
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
                                                      "${getIp()}${state.vendorProfile.profile_picture}")
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
                        Text("Citizenship Photo",
                            style: TextStyle(
                                color: Color(0xff29383F),
                                fontSize: 14,
                                fontWeight: FontWeight.w700)),
                        SizedBox(
                          height: 20,
                        ),
                        Text("Front",
                            style: TextStyle(
                                color: Color(0xff29383F),
                                fontSize: 12,
                                fontWeight: FontWeight.w500)),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xff29383F).withOpacity(0.5)),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () async {
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
                                        if (croppedFile != null) {
                                          context
                                              .read<DocumentDetailDartBloc>()
                                              .add(NagriktaFrontPictureAddEvent(
                                                  nagriktaFront:
                                                      File(croppedFile.path)));
                                        }
                                      }
                                    },
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
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
                                                    "${getIp()}${state.vendorProfile.citizenship_front}")
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
                        Text("Back",
                            style: TextStyle(
                                color: Color(0xff29383F),
                                fontSize: 12,
                                fontWeight: FontWeight.w500)),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xff29383F).withOpacity(0.5)),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () async {
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
                                        if (croppedFile != null) {
                                          context
                                              .read<DocumentDetailDartBloc>()
                                              .add(NagriktaBackPictureAddEvent(
                                                  nagriktaBack:
                                                      File(croppedFile.path)));
                                        }
                                      }
                                    },
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
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
                                                    "${getIp()}${state.vendorProfile.citizenship_back}")
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
                        Text("Enter Address",
                            style: TextStyle(
                                color: Color(0xff29383F),
                                fontSize: 12,
                                fontWeight: FontWeight.w500)),
                        SizedBox(
                          height: 5,
                        ),
                        BlocProvider(
                          create: (context) => ClickedItemCubit(),
                          child:
                              BlocBuilder<ClickedItemCubit, ClickedItemState>(
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
                                enabled: state.clicked,
                                controller: editingController,
                                onTapOutside: (event) =>
                                    FocusScope.of(context).unfocus(),
                                decoration: InputDecoration(
                                  hintText: "Dharan - 12 , Sunsari",
                                  suffixIcon: InkWell(
                                      onTap: () {
                                        context.read<ClickedItemCubit>()
                                          ..clickedUnique(!state.clicked);
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
                            return AnimatedContainer(
                              duration: Duration(seconds: 2),
                              width: MediaQuery.of(context).size.width,
                              child: MaterialButton(
                                  onPressed: () {
                                    if (state.formKey!.currentState!
                                        .validate()) {
                                      // print("nigga");
                                      // if(context.)
                                      var imageState = context
                                          .read<DocumentDetailDartBloc>()
                                          .state;
                                      if (imageState.nagriktaBack == null &&
                                          imageState.nagriktaFront == null &&
                                          imageState.profilePicture == null) {
                                        return customScaffold(
                                            context: context,
                                            title: "No Document photos",
                                            message:
                                                "Please attach your document photos above",
                                            contentType: ContentType.failure);
                                      }
                                      if (imageState.nagriktaFront == null) {
                                        return customScaffold(
                                            context: context,
                                            title: "Citizenship Picture",
                                            message:
                                                "Dear User, Please attach of your citizenship facing front",
                                            contentType: ContentType.failure);
                                      }
                                      if (imageState.nagriktaBack == null) {
                                        return customScaffold(
                                            context: context,
                                            title: "Citizenship Picture",
                                            message:
                                                "Dear User, Please attach of your citizenship facing backwards",
                                            contentType: ContentType.failure);
                                      }
                                      if (imageState.profilePicture == null) {
                                        return customScaffold(
                                            context: context,
                                            title: "Profile Photo not Added",
                                            message:
                                                "Dear User, Please add your Picture",
                                            contentType: ContentType.failure);
                                      }
                                      var state =
                                          context.read<LoginBloc>().state;
                                      if (state is LoginLoaded) {
                                        context
                                            .read<ProfileVerificationBloc>()
                                            .add(ProfileVerificationHitEvent(
                                                token:
                                                    state.successModel.token!,
                                                profilePicture:
                                                    imageState.profilePicture!,
                                                citizenshipFront:
                                                    imageState.nagriktaFront!,
                                                citizenshipBack:
                                                    imageState.nagriktaBack!,
                                                address:
                                                    editingController.text));
                                      }
                                    }
                                  },
                                  minWidth: MediaQuery.of(context).size.width,
                                  height: 48,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  textColor: Colors.white,
                                  color: Color(0xff546464),
                                  child: Text("Submit for verification")),
                            );
                          },
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
