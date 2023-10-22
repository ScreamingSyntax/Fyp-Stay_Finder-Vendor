import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stayfinder_vendor/data/model/bloc_form_model.dart';
import 'package:stayfinder_vendor/data/model/model_exports.dart';
import 'package:stayfinder_vendor/logic/blocs/form_bloc/form_bloc.dart';
import 'package:stayfinder_vendor/logic/blocs/login/login_bloc.dart';
import 'package:stayfinder_vendor/logic/blocs/sign_up/signup_bloc.dart';
import 'package:stayfinder_vendor/logic/cubits/clicked_item/clicked_item_cubit.dart';
import 'package:stayfinder_vendor/constants/extensions.dart';
import 'package:stayfinder_vendor/logic/cubits/eye_cubit/eye_button_cubit.dart';
import 'package:stayfinder_vendor/presentation/widgets/widgets_exports.dart';

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
            child: BlocBuilder<FormBloc, FormsState>(
              builder: (context, state) {
                String passOne = context.read<FormBloc>().state.password1.value;
                String passTwo = context.read<FormBloc>().state.password2.value;
                return Scaffold(
                  body: SafeArea(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: SingleChildScrollView(
                        child: Form(
                          key: state.formKey,
                          child: Container(
                            child: Column(
                              mainAxisAlignment:
                                  !(context.watch<SignupBloc>().state ==
                                          SignupLoading())
                                      ? MainAxisAlignment.start
                                      : MainAxisAlignment.center,
                              children: [
                                AnimatedContainer(
                                  height: context
                                          .watch<ClickedItemCubit>()
                                          .state
                                          .clicked
                                      ? 200
                                      : 0,
                                  width: context
                                          .watch<ClickedItemCubit>()
                                          .state
                                          .clicked
                                      ? 200
                                      : 0,
                                  duration: Duration(seconds: 1),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                            "assets/images/Current_Location.png",
                                          ),
                                          fit: BoxFit.contain)),
                                ),
                                BlocBuilder<SignupBloc, SignupState>(
                                  builder: (context, state) {
                                    return AnimatedContainer(
                                      duration: Duration(seconds: 2),
                                      // width: !(state == SignupLoading()) ? null : 0,
                                      // height:
                                      // !(state == SignupLoading()) ? null : 0,
                                      child: (state == SignupLoading())
                                          ? Center(
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  CircularProgressIndicator(
                                                    color: Color(0xff546464),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text("Please wait.....")
                                                ],
                                              ),
                                            )
                                          : ListView(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              children: [
                                                TextFieldLabel(
                                                  label: "Name :",
                                                ),
                                                CustomFormField(
                                                  inputFormatters: [],
                                                  onChange: (p0) {
                                                    BlocProvider.of<FormBloc>(
                                                            context)
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
                                                    context.read<
                                                        ClickedItemCubit>()
                                                      ..unclicked();
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                  },
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                TextFieldLabel(
                                                  label: "Phone :",
                                                ),
                                                CustomFormField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  onChange: (p0) {
                                                    BlocProvider.of<FormBloc>(
                                                            context)
                                                        .add(PhoneChangedEvent(
                                                            mobile:
                                                                BlocFormItem(
                                                                    value:
                                                                        p0!)));
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
                                                    context.read<
                                                        ClickedItemCubit>()
                                                      ..unclicked();
                                                    FocusScope.of(context)
                                                        .unfocus();
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
                                                    BlocProvider.of<FormBloc>(
                                                            context)
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
                                                    context.read<
                                                        ClickedItemCubit>()
                                                      ..unclicked();
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                  },
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                TextFieldLabel(
                                                  label: "Password :",
                                                ),
                                                BlocProvider(
                                                  create: (_) =>
                                                      EyeButtonCubit(),
                                                  child: Builder(
                                                      builder: (context) {
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
                                                              ? Icon(
                                                                  CupertinoIcons
                                                                      .eye_slash)
                                                              : Icon(
                                                                  CupertinoIcons
                                                                      .eye)),
                                                      obscureText: obscureText,
                                                      inputFormatters: [],
                                                      onChange: (p0) => context
                                                          .read<FormBloc>()
                                                        ..add(Password1ChangedEvent(
                                                            password:
                                                                BlocFormItem(
                                                                    value:
                                                                        p0!))),
                                                      onTap: () => context
                                                          .read<
                                                              ClickedItemCubit>()
                                                          .clicked(),
                                                      onTapOutside: (event) {
                                                        context.read<
                                                            ClickedItemCubit>()
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
                                                        if (passOne !=
                                                            passTwo) {
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
                                                  create: (_) =>
                                                      EyeButtonCubit(),
                                                  child: Builder(
                                                      builder: (context) {
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
                                                              ? Icon(
                                                                  CupertinoIcons
                                                                      .eye_slash)
                                                              : Icon(
                                                                  CupertinoIcons
                                                                      .eye)),
                                                      obscureText: obscureText,
                                                      inputFormatters: [],
                                                      onChange: (p0) => context
                                                          .read<FormBloc>()
                                                        ..add(Password2ChangedEvent(
                                                            password2:
                                                                BlocFormItem(
                                                                    value:
                                                                        p0!))),
                                                      onTap: () => context
                                                          .read<
                                                              ClickedItemCubit>()
                                                          .clicked(),
                                                      onTapOutside: (event) {
                                                        context.read<
                                                            ClickedItemCubit>()
                                                          ..unclicked();
                                                        FocusScope.of(context)
                                                            .unfocus();
                                                      },
                                                      validatior: (p0) {
                                                        if (p0!.isEmpty) {
                                                          return 'Please enter valid password';
                                                        }
                                                        if (passOne !=
                                                            passTwo) {
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
                                                              .watch<
                                                                  SignupBloc>()
                                                              .state ==
                                                          SignupLoading())
                                                      ? () async {
                                                          if (context
                                                              .read<FormBloc>()
                                                              .state
                                                              .formKey!
                                                              .currentState!
                                                              .validate()) {
                                                            context.read<
                                                                SignupBloc>()
                                                              ..add(SignUpEventHit(
                                                                  vendor: Vendor(
                                                                      id: 0,
                                                                      email: context
                                                                          .read<
                                                                              FormBloc>()
                                                                          .state
                                                                          .email
                                                                          .value,
                                                                      phoneNumber: context
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
                                                  minWidth:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width,
                                                  height: 48,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  textColor: Colors.white,
                                                  color: Color(0xff546464),
                                                  child: Text("Signup"),
                                                ),
                                                SizedBox(
                                                  height: 30,
                                                ),
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                          "Already have an Account? "),
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                        child: Text(
                                                          "Login",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff29383F),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                      )
                                                    ])
                                              ],
                                            ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
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
