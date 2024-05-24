import '../widgets/widgets_exports.dart';
import '../../logic/blocs/bloc_exports.dart';
import '../../data/model/model_exports.dart';
import 'screen_exports.dart';

class OtpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    OtpFieldControllerV2 otpFieldControllerV2 = OtpFieldControllerV2();
    return BlocListener<SignUpOtpDartBloc, SignUpOtpDartState>(
      listener: (context, state) async {
        if (state is SignupOtpLoading) {
          await Future.delayed(Duration(seconds: 2));

          customScaffold(
              context: context,
              title: "Hold on Captain",
              message: "Signing You In Captain :)",
              contentType: ContentType.help);
        }
        if (state is SignUpOtpErrorState) {
          await Future.delayed(Duration(seconds: 2));

          otpFieldControllerV2.clear();
          customScaffold(
              context: context,
              title: "Oh Snap!",
              message: state.errorMessage,
              contentType: ContentType.failure);
        }
        if (state is SignupOtpLoaded) {
          customScaffold(
              context: context,
              title: "Horraay :) ",
              message: state.success.message!,
              contentType: ContentType.success);
          // Future.wait()
          await Future.delayed(Duration(seconds: 2));
          Navigator.pushNamed(context, "/login");
        }
      },
      child: WillPopScope(
        onWillPop: () => showExitPopup(
          context: context,
          message: "This will take you back to login",
          title: "Exit Otp Verification",
          noBtnFunction: () => Navigator.pop(context),
          yesBtnFunction: () =>
              Navigator.pushReplacementNamed(context, "/login"),
        ),
        child: Scaffold(
          body: Container(
            padding: EdgeInsets.all(8),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    templateBoarding(
                      imagePath: "assets/images/Thinking_face_girl.png",
                      heading: "Hmmm... Let's Verify",
                      body: "",
                    ),
                    BlocBuilder<SignupBloc, SignupState>(
                      builder: (context, state) {
                        if ((context.read<SignUpOtpDartBloc>().state ==
                            SignupOtpLoading())) {
                          return Center(
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
                          );
                        }
                        if (context.read<SignUpOtpDartBloc>().state ==
                            SignupLoaded) {
                          return Center(
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
                          );
                        } else {
                          return OTPTextFieldV2(
                            length: 6,
                            width: MediaQuery.of(context).size.width,
                            textFieldAlignment: MainAxisAlignment.spaceAround,
                            fieldWidth: 45,
                            controller: otpFieldControllerV2,
                            otpFieldStyle: OtpFieldStyle(
                              disabledBorderColor: Color(0xff767171),
                              borderColor: Color(0xff767171),
                              enabledBorderColor: Color(0xff767171),
                              errorBorderColor: Color(0xff767171),
                              focusBorderColor: Color(0xff767171),
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
                              if (state is SignupLoaded) {
                                context.read<SignUpOtpDartBloc>().add(
                                    SignUpEventHitOtp(
                                        vendor: Vendor(
                                            id: 0,
                                            email: state.vendor.email,
                                            phone_number:
                                                state.vendor.phone_number,
                                            isVerified: null,
                                            password: state.vendor.password,
                                            fullName: state.vendor.fullName,
                                            otp: pin)));
                              }
                            },
                          );
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text("Didn't receive a code? "),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/");
                        },
                        child: Text(
                          "Resend",
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
        ),
      ),
    );
  }
}
