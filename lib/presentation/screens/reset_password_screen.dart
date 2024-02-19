import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stayfinder_vendor/logic/blocs/bloc_exports.dart';
import 'package:stayfinder_vendor/logic/cubits/cubit_exports.dart';
import 'package:stayfinder_vendor/presentation/widgets/widgets_exports.dart';

class ResetPasswordScreen extends StatelessWidget {
  TextEditingController _oldPasswordController = new TextEditingController();
  TextEditingController _newPasswordController = new TextEditingController();
  TextEditingController _confirmNewPasswordController =
      new TextEditingController();
  final _formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccess) {
          customScaffold(
              context: context,
              title: "Success",
              message: state.message,
              contentType: ContentType.success);
          Navigator.pop(context);
        }
        if (state is ResetPasswordError) {
          customScaffold(
              context: context,
              title: "Error",
              message: state.message,
              contentType: ContentType.failure);
        }
        // TODO: implement listener
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff37474F),
          foregroundColor: Colors.white,
          title: Text(
            "Reset Password",
            style: TextStyle(fontSize: 14),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // CustomFormField(
                //   labelText: "Current Pass",
                //   controller: _oldPasswordController,
                //   inputFormatters: [],
                //   validatior: (p0) {
                //     if (p0 == "" || p0 == null) {
                //       return "Old pass can't be null";
                //     }
                //     return null;
                //   },
                // ),
                SizedBox(
                  height: 30,
                ),
                BlocProvider(
                  create: (context) => EyeButtonCubit(),
                  child: BlocBuilder<EyeButtonCubit, EyeButtonState>(
                    builder: (context, state) {
                      bool value = state.clickedEye;
                      return CustomFormField(
                        labelText: "Old Pass",
                        controller: _oldPasswordController,
                        inputFormatters: [],
                        obscureText: state.clickedEye,
                        icon: IconButton(
                            onPressed: () {
                              context.read<EyeButtonCubit>()
                                ..pressedEyeButton(!context
                                    .read<EyeButtonCubit>()
                                    .state
                                    .clickedEye);
                            },
                            icon: value
                                ? Icon(FontAwesomeIcons.eyeSlash)
                                : Icon(Icons.remove_red_eye)),
                        validatior: (p0) {
                          if (p0 == "" || p0 == null) {
                            return "Old pass can't be null";
                          }
                          return null;
                        },
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                BlocProvider(
                  create: (context) => EyeButtonCubit(),
                  child: BlocBuilder<EyeButtonCubit, EyeButtonState>(
                    builder: (context, state) {
                      bool value = state.clickedEye;
                      return CustomFormField(
                        labelText: "New Pass",
                        controller: _newPasswordController,
                        inputFormatters: [],
                        obscureText: state.clickedEye,
                        icon: IconButton(
                            onPressed: () {
                              context.read<EyeButtonCubit>()
                                ..pressedEyeButton(!context
                                    .read<EyeButtonCubit>()
                                    .state
                                    .clickedEye);
                            },
                            icon: value
                                ? Icon(FontAwesomeIcons.eyeSlash)
                                : Icon(Icons.remove_red_eye)),
                        validatior: (p0) {
                          if (p0 == "" || p0 == null) {
                            return "New pass can't be null";
                          }
                          return null;
                        },
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                BlocProvider(
                  create: (context) => EyeButtonCubit(),
                  child: BlocBuilder<EyeButtonCubit, EyeButtonState>(
                    builder: (context, state) {
                      bool value = state.clickedEye;
                      return CustomFormField(
                        labelText: "Confirm New Pass",
                        controller: _confirmNewPasswordController,
                        inputFormatters: [],
                        obscureText: state.clickedEye,
                        icon: IconButton(
                            onPressed: () {
                              context.read<EyeButtonCubit>()
                                ..pressedEyeButton(!context
                                    .read<EyeButtonCubit>()
                                    .state
                                    .clickedEye);
                            },
                            icon: value
                                ? Icon(FontAwesomeIcons.eyeSlash)
                                : Icon(Icons.remove_red_eye)),
                        validatior: (p0) {
                          if (p0 == "" || p0 == null) {
                            return "New pass can't be null";
                          }
                          if (_newPasswordController.text !=
                              _confirmNewPasswordController.text) {
                            return "Passwords donot match";
                          }
                          return null;
                        },
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                // CustomFormField(
                //   labelText: "Confirm New Pass",
                //   controller: _confirmNewPasswordController,
                //   validatior: (p0) {
                //     if (p0 == "" || p0 == null) {
                //       return "Confirm pass can't be null";
                //     }
                //     if (_newPasswordController.text !=
                //         _confirmNewPasswordController.text) {
                //       return "Password's donot match";
                //     }
                //     return null;
                //   },
                //   inputFormatters: [],
                // ),
                // SizedBox(
                //   height: 30,
                // ),
                CustomMaterialButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        print("N");
                        var state = context.read<LoginBloc>().state;
                        if (state is LoginLoaded) {
                          context.read<ResetPasswordCubit>()
                            ..resetPassword(
                                token: state.successModel.token!,
                                oldPass: _oldPasswordController.text,
                                newPass: _newPasswordController.text);
                        }
                      }
                    },
                    child: Text("Confirm"),
                    backgroundColor: Color(0xff37474F),
                    textColor: Colors.white,
                    height: 45)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
