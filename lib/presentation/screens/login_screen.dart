// ignore_for_file: must_be_immutable
import 'package:flutter/cupertino.dart';
import '../../data/model/model_exports.dart';
import '../../logic/blocs/bloc_exports.dart';
import '../../constants/constants_exports.dart';
import '../../logic/cubits/cubit_exports.dart';
import '../../presentation/widgets/widgets_exports.dart';

class LoginScreen extends StatelessWidget {
  var loaded = false;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ClickedItemCubit(),
        ),
      ],
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            return customScaffold(
                contentType: ContentType.warning,
                context: context,
                title: "Loading",
                message: "Loggin you in captain");
          }
          if (state is LoginLoaded) {
            BlocProvider.of<VendorDataProviderBloc>(context)
              ..add(LoadDataEvent(token: state.successModel.token.toString()));
            BlocProvider.of<FetchTierBloc>(context)
              ..add(FetchTierHitEvent(
                  token: state.successModel.token.toString()));
            context.read<FetchVendorProfileBloc>()
              ..add(
                  HitFetchVendorProfileEvent(token: state.successModel.token!));
            Navigator.pushReplacementNamed(context, "/home");
          }
          if (state is LoginError) {
            return customScaffold(
                context: context,
                title: "Login Failed",
                message: state.message.toString(),
                contentType: ContentType.failure);
          }
        },
        child: WillPopScope(onWillPop: () {
          return showExitPopup(
            context: context,
            message: "Do you want to exit?",
            noBtnFunction: () => Navigator.pop(context),
            title: "Exit Application",
            yesBtnFunction: () => SystemNavigator.pop(),
          );
        }, child: BlocBuilder<FormBloc, FormsState>(
          builder: (context, state) {
            return !(context.watch<LoginBloc>().state == LoginLoading() ||
                    context.watch<LoginBloc>().state == LoginLoading())
                ? Builder(
                    builder: (context) {
                      return Scaffold(
                        resizeToAvoidBottomInset: false,
                        body: SafeArea(
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(20),
                            child: Form(
                              key: state.formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: context
                                        .watch<ClickedItemCubit>()
                                        .state
                                        .clicked
                                    ? MainAxisAlignment.center
                                    : MainAxisAlignment.start,
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
                                              "assets/images/location.png",
                                            ),
                                            fit: BoxFit.contain)),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFieldLabel(
                                    label: "Email :",
                                  ),
                                  CustomFormField(
                                    inputFormatters: [],
                                    onChange: (p0) => context.read<FormBloc>()
                                      ..add(EmailChangedEvent(
                                          email: BlocFormItem(value: p0!))),
                                    onTap: () => context
                                        .read<ClickedItemCubit>()
                                        .clicked(),
                                    onTapOutside: (event) {
                                      context.read<ClickedItemCubit>()
                                        ..unclicked();
                                      FocusScope.of(context).unfocus();
                                    },
                                    validatior: (p0) {
                                      if (p0!.isEmpty) {
                                        return "The Email Field cannot be null";
                                      }
                                      if (!p0.isValidEmail) {
                                        return "Please Enter Valid Email";
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFieldLabel(
                                    label: "Password :",
                                  ),
                                  BlocProvider(
                                    create: (_) => EyeButtonCubit(),
                                    child: Builder(builder: (context) {
                                      return BlocBuilder<EyeButtonCubit,
                                          EyeButtonState>(
                                        builder: (context, state) {
                                          bool obscureText = state.clickedEye;
                                          return CustomFormField(
                                            icon: IconButton(
                                                onPressed: () {
                                                  context
                                                      .read<EyeButtonCubit>()
                                                      .pressedEyeButton(
                                                          !obscureText);
                                                },
                                                icon: !obscureText
                                                    ? Icon(CupertinoIcons.eye)
                                                    : Icon(CupertinoIcons
                                                        .eye_slash)),
                                            obscureText: obscureText,
                                            validatior: (p0) {
                                              if (p0!.isEmpty) {
                                                return "The password field cannot be null";
                                              }
                                              return null;
                                            },
                                            onChange: (p0) =>
                                                context.read<FormBloc>()
                                                  ..add(Password1ChangedEvent(
                                                      password: BlocFormItem(
                                                          value: p0!))),
                                            inputFormatters: [],
                                            onTap: () => context
                                                .read<ClickedItemCubit>()
                                                .clicked(),
                                            onTapOutside: (event) {
                                              context.read<ClickedItemCubit>()
                                                ..unclicked();
                                              FocusScope.of(context).unfocus();
                                            },
                                          );
                                        },
                                      );
                                    }),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: [
                                        Checkbox(
                                          fillColor: MaterialStatePropertyAll(
                                              Color(0xffD9D9D9)),
                                          side: BorderSide(
                                              color: Colors.transparent),
                                          value: context
                                              .watch<RememberMeCubit>()
                                              .state
                                              .rememberMe,
                                          onChanged: (value) => context
                                              .read<RememberMeCubit>()
                                              .rememberMeTicked(value!),
                                        ),
                                        TextFieldLabel(label: "Remember Me")
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  AnimatedContainer(
                                    duration: Duration(seconds: 2),
                                    width: !(context.watch<LoginBloc>().state ==
                                            LoginLoading())
                                        ? MediaQuery.of(context).size.width
                                        : 0,
                                    child: MaterialButton(
                                      onPressed: !(context
                                                  .watch<LoginBloc>()
                                                  .state ==
                                              LoginLoading())
                                          ? () {
                                              if (state.formKey!.currentState!
                                                  .validate()) {
                                                context.read<LoginBloc>().add(
                                                    LoginClickedEvent(
                                                        rememberMe: context
                                                            .read<
                                                                RememberMeCubit>()
                                                            .state
                                                            .rememberMe,
                                                        email:
                                                            state.email.value,
                                                        password: state
                                                            .password1.value));
                                              }
                                            }
                                          : null,
                                      minWidth:
                                          MediaQuery.of(context).size.width,
                                      height: 48,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      textColor: Colors.white,
                                      color: Color(0xff546464),
                                      child: Text("Login"),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Not an User? "),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, "/signUp");
                                            state.formKey!.currentState!
                                                .reset();
                                          },
                                          child: Text(
                                            "Register",
                                            style: TextStyle(
                                                color: Color(0xff29383F),
                                                fontWeight: FontWeight.w700),
                                          ),
                                        )
                                      ])
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : Scaffold(
                    body: SafeArea(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Color(0xff29383F).withOpacity(0.8),
                        ),
                      ),
                    ),
                  );
          },
        )),
      ),
    );
  }
}
