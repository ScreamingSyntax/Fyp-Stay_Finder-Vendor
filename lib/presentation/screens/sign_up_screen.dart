import 'package:flutter/cupertino.dart';

import '../../data/model/model_exports.dart';
import '../../logic/blocs/bloc_exports.dart';
import '../../constants/constants_exports.dart';
import '../../logic/cubits/cubit_exports.dart';
import '../../presentation/widgets/widgets_exports.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ClickedItemCubit(),
        ),
      ],
      child: Builder(builder: (context) {
        return BlocListener<SignupBloc, SignupState>(
          listener: (context, state) {
            if (state is SignupLoading) {
              customScaffold(
                  context: context,
                  title: "Hold on Captain",
                  message: "Signing You In Captain :)",
                  contentType: ContentType.help);
            }
            if (state is SignUpErrorState) {
              customScaffold(
                  context: context,
                  title: "Oh Snap!",
                  message: state.errorMessage,
                  contentType: ContentType.failure);
            }
            if (state is SignupLoaded) {
              customScaffold(
                  context: context,
                  title: "Horraay :) ",
                  message: state.success.message!,
                  contentType: ContentType.success);
              Navigator.pushNamed(context, "/otp");
            }
          },
          child: WillPopScope(
            onWillPop: () => showExitPopup(
              context: context,
              message: "You sure yo don't want to signup ?",
              title: "Exit Signup",
              noBtnFunction: () => Navigator.pop(context),
              yesBtnFunction: () => Navigator.pushNamed(context, "/login"),
            ),
            child: BlocBuilder<SignupBloc, SignupState>(
              builder: (context, state) {
                if (state is SignupLoading) {
                  return Material(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return BlocBuilder<FormBloc, FormsState>(
                  builder: (context, state) {
                    String passOne =
                        context.read<FormBloc>().state.password1.value;
                    String passTwo =
                        context.read<FormBloc>().state.password2.value;
                    return Scaffold(
                      backgroundColor: Color(0xffECEFF1),
                      // backgroundColor: Color(0xff29383F),
                      body: Form(
                        key: state.formKey,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0,
                              child: Container(
                                height: 180,
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 40, horizontal: 30),
                                  child: Text(
                                    "Sign up",
                                    style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width,
                                color: Color(0xff29383F),
                              ),
                            ),
                            Positioned(
                              top: 160,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color(0xffECEFF1),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10))),
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.all(30),
                                child: Container(
                                  height: MediaQuery.of(context).size.height,
                                  child: SingleChildScrollView(
                                    physics: AlwaysScrollableScrollPhysics(),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Welcome Back",
                                            style: TextStyle(
                                              fontSize: 21,
                                              color: Color(0xff212121),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "To proceed, kindly enter your credentials.",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xffB0BEC5),
                                              // .withOpacity(0.5),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          TextFieldLabel(
                                            label: "Name :",
                                          ),
                                          CustomFormField(
                                            inputFormatters: [],
                                            onChange: (p0) {
                                              BlocProvider.of<FormBloc>(context)
                                                  .add(NameChangedEvent(
                                                      name: BlocFormItem(
                                                          value: p0!)));
                                            },
                                            validatior: (p0) {
                                              if (p0 != null &&
                                                  !p0.isValidName) {
                                                return 'Enter Valid Name';
                                              }
                                              return null;
                                            },
                                            onTap: () => context
                                                .read<ClickedItemCubit>()
                                                .clicked(),
                                            onTapOutside: (event) {
                                              context.read<ClickedItemCubit>()
                                                ..unclicked();
                                              FocusScope.of(context).unfocus();
                                            },
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          TextFieldLabel(
                                            label: "Phone :",
                                          ),
                                          CustomFormField(
                                            keyboardType: TextInputType.number,
                                            onChange: (p0) {
                                              BlocProvider.of<FormBloc>(context)
                                                  .add(PhoneChangedEvent(
                                                      mobile: BlocFormItem(
                                                          value: p0!)));
                                            },
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            validatior: (p0) {
                                              if (p0 != null &&
                                                  !p0.isValidPhone) {
                                                return 'Enter Valid Phone Number';
                                              }
                                              return null;
                                            },
                                            onTap: () => context
                                                .read<ClickedItemCubit>()
                                                .clicked(),
                                            onTapOutside: (event) {
                                              context.read<ClickedItemCubit>()
                                                ..unclicked();
                                              FocusScope.of(context).unfocus();
                                            },
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          TextFieldLabel(
                                            label: "Email :",
                                          ),
                                          CustomFormField(
                                            inputFormatters: [],
                                            onChange: (p0) {
                                              BlocProvider.of<FormBloc>(context)
                                                  .add(EmailChangedEvent(
                                                      email: BlocFormItem(
                                                          value: p0!)));
                                            },
                                            validatior: (p0) {
                                              if (p0 != null &&
                                                  !p0.isValidEmail) {
                                                return "Please Enter Valid Email";
                                              }
                                              return null;
                                            },
                                            onTap: () => context
                                                .read<ClickedItemCubit>()
                                                .clicked(),
                                            onTapOutside: (event) {
                                              context.read<ClickedItemCubit>()
                                                ..unclicked();
                                              FocusScope.of(context).unfocus();
                                            },
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          TextFieldLabel(
                                            label: "Password :",
                                          ),
                                          BlocProvider(
                                            create: (_) => EyeButtonCubit(),
                                            child: Builder(builder: (context) {
                                              bool obscureText = context
                                                  .watch<EyeButtonCubit>()
                                                  .state
                                                  .clickedEye;
                                              return CustomFormField(
                                                icon: IconButton(
                                                    onPressed: () {
                                                      context
                                                          .read<
                                                              EyeButtonCubit>()
                                                          .pressedEyeButton(
                                                              !obscureText);
                                                    },
                                                    icon: obscureText
                                                        ? Icon(CupertinoIcons
                                                            .eye_slash)
                                                        : Icon(CupertinoIcons
                                                            .eye)),
                                                obscureText: obscureText,
                                                inputFormatters: [],
                                                onChange: (p0) => context
                                                    .read<FormBloc>()
                                                  ..add(Password1ChangedEvent(
                                                      password: BlocFormItem(
                                                          value: p0!))),
                                                onTap: () => context
                                                    .read<ClickedItemCubit>()
                                                    .clicked(),
                                                onTapOutside: (event) {
                                                  context
                                                      .read<ClickedItemCubit>()
                                                    ..unclicked();
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                },
                                                validatior: (p0) {
                                                  if (p0!.isEmpty) {
                                                    return 'Please enter valid password';
                                                  }
                                                  print(
                                                      "This is passs1 : ${passOne} , This is pass2: ${passTwo}");
                                                  if (passOne != passTwo) {
                                                    return "Passwords donot match";
                                                  }
                                                  return null;
                                                },
                                              );
                                            }),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          TextFieldLabel(
                                            label: "Confirm Password :",
                                          ),
                                          BlocProvider(
                                            create: (_) => EyeButtonCubit(),
                                            child: Builder(builder: (context) {
                                              bool obscureText = context
                                                  .watch<EyeButtonCubit>()
                                                  .state
                                                  .clickedEye;
                                              return CustomFormField(
                                                icon: IconButton(
                                                    onPressed: () {
                                                      context
                                                          .read<
                                                              EyeButtonCubit>()
                                                          .pressedEyeButton(
                                                              !obscureText);
                                                    },
                                                    icon: obscureText
                                                        ? Icon(CupertinoIcons
                                                            .eye_slash)
                                                        : Icon(CupertinoIcons
                                                            .eye)),
                                                obscureText: obscureText,
                                                inputFormatters: [],
                                                onChange: (p0) => context
                                                    .read<FormBloc>()
                                                  ..add(Password2ChangedEvent(
                                                      password2: BlocFormItem(
                                                          value: p0!))),
                                                onTap: () => context
                                                    .read<ClickedItemCubit>()
                                                    .clicked(),
                                                onTapOutside: (event) {
                                                  context
                                                      .read<ClickedItemCubit>()
                                                    ..unclicked();
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                },
                                                validatior: (p0) {
                                                  if (p0!.isEmpty) {
                                                    return 'Please enter valid password';
                                                  }
                                                  if (passOne != passTwo) {
                                                    return "Passwords donot match";
                                                  }
                                                  return null;
                                                },
                                              );
                                            }),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          MaterialButton(
                                            onPressed: !(context
                                                        .watch<SignupBloc>()
                                                        .state ==
                                                    SignupLoading())
                                                ? () async {
                                                    if (context
                                                        .read<FormBloc>()
                                                        .state
                                                        .formKey!
                                                        .currentState!
                                                        .validate()) {
                                                      context.read<SignupBloc>()
                                                        ..add(SignUpEventHit(
                                                            vendor: Vendor(
                                                                id: 0,
                                                                email: context
                                                                    .read<
                                                                        FormBloc>()
                                                                    .state
                                                                    .email
                                                                    .value,
                                                                phone_number:
                                                                    context
                                                                        .read<
                                                                            FormBloc>()
                                                                        .state
                                                                        .phone
                                                                        .value,
                                                                isVerified:
                                                                    false,
                                                                fullName: context
                                                                    .read<
                                                                        FormBloc>()
                                                                    .state
                                                                    .name
                                                                    .value,
                                                                password: context
                                                                    .read<
                                                                        FormBloc>()
                                                                    .state
                                                                    .password1
                                                                    .value)));
                                                    }
                                                  }
                                                : null,
                                            minWidth: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 48,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            textColor: Colors.white,
                                            color: Color(0xff546464),
                                            child: Text("Signup"),
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                    "Already have an Account? "),
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: Text(
                                                    "Login",
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff29383F),
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                )
                                              ]),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
