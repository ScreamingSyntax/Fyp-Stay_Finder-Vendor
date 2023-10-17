import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stayfinder_vendor/constants/extensions.dart';
import 'package:stayfinder_vendor/data/model/bloc_form.dart';
import 'package:stayfinder_vendor/logic/blocs/form_bloc/form_bloc.dart';
import 'package:stayfinder_vendor/logic/cubits/clicked_item/clicked_item_cubit.dart';
import 'package:stayfinder_vendor/logic/cubits/remember_me/remember_me_cubit.dart';
import 'package:stayfinder_vendor/presentation/widgets/widgets_exports.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ClickedItemCubit(),
        ),
      ],
      child: BlocBuilder<FormBloc, FormsState>(
        builder: (context, state) {
          return Builder(
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
                        children: [
                          AnimatedContainer(
                            height:
                                context.watch<ClickedItemCubit>().state.clicked
                                    ? 200
                                    : 0,
                            width:
                                context.watch<ClickedItemCubit>().state.clicked
                                    ? 200
                                    : 0,
                            duration: Duration(seconds: 1),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                      "assets/images/map.png",
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
                            onTap: () =>
                                context.read<ClickedItemCubit>().clicked(),
                            onTapOutside: (event) {
                              context.read<ClickedItemCubit>()..unclicked();
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
                          CustomFormField(
                            validatior: (p0) {
                              if (p0!.isEmpty) {
                                return "The password field cannot be null";
                              }
                              return null;
                            },
                            onChange: (p0) => context.read<FormBloc>()
                              ..add(Password1ChangedEvent(
                                  password: BlocFormItem(value: p0!))),
                            inputFormatters: [],
                            onTap: () =>
                                context.read<ClickedItemCubit>().clicked(),
                            onTapOutside: (event) {
                              context.read<ClickedItemCubit>()..unclicked();
                              FocusScope.of(context).unfocus();
                            },
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
                                  side: BorderSide(color: Colors.transparent),
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
                          MaterialButton(
                            onPressed: () {
                              if (state.formKey!.currentState!.validate()) {
                                Navigator.pushNamed(context, "/home");
                              }
                            },
                            minWidth: MediaQuery.of(context).size.width,
                            height: 48,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            textColor: Colors.white,
                            color: Color(0xff546464),
                            child: Text("Login"),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Not an User? "),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, "/signUp");
                                    state.formKey!.currentState!.reset();
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
          );
        },
      ),
    );
  }
}
