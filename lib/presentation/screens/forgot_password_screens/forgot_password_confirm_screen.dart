// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';

import '../../../logic/cubits/cubit_exports.dart';
import '../../widgets/widgets_exports.dart';

class ForgotPasswordConfirmationScreen extends StatelessWidget {
  final String email;
  final String otp;
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _confirmPasswordController =
      new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  ForgotPasswordConfirmationScreen(
      {super.key, required this.email, required this.otp});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPassCubit, ForgotPassState>(
      listener: (context, state) {
        if (state is ForgotPassSuccess) {
          customScaffold(
            message: state.message,
            context: context,
            contentType: ContentType.success,
            title: "Success",
          );
          return popMultipleScreens(context, 1);
        }
        if (state is ForgotPassError) {
          customScaffold(
            message: state.message,
            context: context,
            contentType: ContentType.failure,
            title: "Error",
          );
        }
      },
      child: WillPopScope(
        onWillPop: () async {
          showExitPopup(
              context: context,
              message: "Are you sure you want to cancel? ",
              noBtnFunction: () => Navigator.pop(context),
              yesBtnFunction: () => popMultipleScreens(context, 3),
              title: "Confirmation");
          return true;
        },
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: SafeArea(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomPoppinsText(
                          text: "New Pass",
                          fontWeight: FontWeight.w500,
                          fontSize: 12),
                      SizedBox(
                        height: 5,
                      ),
                      BlocProvider(
                        create: (context) => BooleanChangeCubit(),
                        child: Builder(builder: (context) {
                          return BlocBuilder<BooleanChangeCubit,
                              BooleanChangeState>(
                            builder: (context, state) {
                              bool value = state.value;
                              return CustomFormField(
                                controller: _passwordController,
                                inputFormatters: [],
                                icon: IconButton(
                                    onPressed: () {
                                      context.read<BooleanChangeCubit>()
                                        ..change();
                                    },
                                    icon: !value
                                        ? Icon(CupertinoIcons.eye)
                                        : Icon(CupertinoIcons.eye_slash)),
                                obscureText: value,
                                validatior: (p0) {
                                  if (p0!.isEmpty) {
                                    return "The password field cannot be null";
                                  }
                                  return null;
                                },
                              );
                            },
                          );
                        }),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomPoppinsText(
                          text: "Confirm New Pass",
                          fontWeight: FontWeight.w500,
                          fontSize: 12),
                      SizedBox(
                        height: 5,
                      ),
                      BlocProvider(
                        create: (context) => BooleanChangeCubit(),
                        child: Builder(builder: (context) {
                          return BlocBuilder<BooleanChangeCubit,
                              BooleanChangeState>(
                            builder: (context, state) {
                              bool value = state.value;
                              return CustomFormField(
                                controller: _confirmPasswordController,
                                inputFormatters: [],
                                icon: IconButton(
                                    onPressed: () {
                                      context.read<BooleanChangeCubit>()
                                        ..change();
                                    },
                                    icon: !value
                                        ? Icon(CupertinoIcons.eye)
                                        : Icon(CupertinoIcons.eye_slash)),
                                obscureText: value,
                                validatior: (p0) {
                                  if (p0!.isEmpty) {
                                    return "The password field cannot be null";
                                  }
                                  if (_passwordController.text !=
                                      _confirmPasswordController.text) {
                                    return "Passwords donot match";
                                  }
                                  return null;
                                },
                              );
                            },
                          );
                        }),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      BlocBuilder<ForgotPassCubit, ForgotPassState>(
                        builder: (context, state) {
                          if (state is ForgotPassLoading) {
                            return Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.all(20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [CircularProgressIndicator()],
                                ));
                          }
                          return CustomMaterialButton(
                            height: 50,
                            textColor: Colors.white,
                            backgroundColor: Color(0xff29383F),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (_formKey.currentState!.validate()) {
                                  context.read<ForgotPassCubit>()
                                    ..forgotPassword(
                                        email: email,
                                        newPass:
                                            _confirmPasswordController.text,
                                        otp: otp);
                                }
                              }
                            },
                            child: Text(
                              "Confirm",
                              style: TextStyle(fontSize: 12),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
