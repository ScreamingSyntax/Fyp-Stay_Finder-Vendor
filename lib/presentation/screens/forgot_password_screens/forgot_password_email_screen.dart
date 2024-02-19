//

import 'package:stayfinder_vendor/constants/constants_exports.dart';

import '../../../logic/blocs/bloc_exports.dart';
import '../../../logic/cubits/cubit_exports.dart';
import '../../widgets/widgets_exports.dart';
import 'forgot_password_otp_screen.dart';

class ForgotPasswordEmailScreen extends StatelessWidget {
  TextEditingController _emailController = new TextEditingController();
  final _key = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPassCubit, ForgotPassState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is ForgotPassSuccess) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (_) =>
                      ForgotPasswordOtpScreen(email: _emailController.text)));
          customScaffold(
            message: state.message,
            context: context,
            contentType: ContentType.success,
            title: "Success",
          );
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
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Forgot Password ",
            style: TextStyle(
                color: Color(0xff29383F).withOpacity(0.5),
                fontSize: 12,
                fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
        ),
        body: Form(
          key: _key,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/forgot_pass.png"),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // CustomTextFormField(
                  //   controller: _emailController,
                  //   borderColor: UsedColors.fadeOutColor,
                  //   hintText: "Email",
                  //   borderRadius: 10,
                  //   contentCenter: false,
                  //   validator: (p0) {
                  //     if (!(p0!.isValidEmail())) {
                  //       return "Invalid Email";
                  //     }
                  //     return null;
                  //   },
                  // ),
                  CustomFormField(
                    inputFormatters: [],
                    controller: _emailController,
                    labelText: "Enter Email",
                    validatior: (p0) {
                      if (!(p0!.isValidEmail)) {
                        return "Invalid Email";
                      }
                      return null;
                    },
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
                          if (_key.currentState!.validate()) {
                            context.read<ForgotPassCubit>()
                              ..forgotPassword(email: _emailController.text);
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
    );
  }
}
