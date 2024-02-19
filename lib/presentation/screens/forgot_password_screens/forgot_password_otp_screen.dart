// ignore_for_file: must_be_immutable

import 'package:stayfinder_vendor/presentation/widgets/widgets_exports.dart';

import '../../../data/api/api_exports.dart';
import '../../../logic/cubits/cubit_exports.dart';
import 'forgot_password_confirm_screen.dart';

class ForgotPasswordOtpScreen extends StatelessWidget {
  final String email;
  OtpFieldControllerV2 controller = new OtpFieldControllerV2();

  ForgotPasswordOtpScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPassCubit, ForgotPassState>(
      listener: (context, state) {
        if (state is ForgotPassSuccess) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (_) => ForgotPasswordConfirmationScreen(
                      email: email,
                      otp: context
                          .read<StoreTempUserDetailsCubit>()
                          .state
                          .name!)));
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
          // showPopup(
          //     context: context,
          //     description: state.message,
          //     title: "Error",
          //     type: ToastificationType.error);
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Image.asset("assets/images/Thinking_face_girl.png"),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Please Enter Otp",
                style: TextStyle(
                    color: Color(0xff29383F).withOpacity(0.5),
                    fontSize: 24,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 20,
              ),
              OTPTextFieldV2(
                  length: 6,
                  width: MediaQuery.of(context).size.width,
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldWidth: 45,
                  controller: controller,
                  otpFieldStyle: OtpFieldStyle(
                    disabledBorderColor: Color(0xff29383F).withOpacity(0.5),
                    borderColor: Color(0xff29383F).withOpacity(0.5),
                    enabledBorderColor: Color(0xff29383F).withOpacity(0.5),
                    errorBorderColor: Color(0xff29383F).withOpacity(0.5),
                    focusBorderColor: Color(0xff29383F).withOpacity(0.5),
                  ),
                  fieldStyle: FieldStyle.box,
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  outlineBorderRadius: 5,
                  style: TextStyle(fontSize: 17),
                  onChanged: (pin) {
                    print("Changed: " + pin);
                  },
                  onCompleted: (pin) {
                    context.read<StoreTempUserDetailsCubit>().clearData();
                    context.read<StoreTempUserDetailsCubit>()
                      ..storeTempData(
                          image: File(""), name: pin, email: "", password: "");
                    context.read<ForgotPassCubit>()
                      ..forgotPassword(email: email, otp: pin);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
