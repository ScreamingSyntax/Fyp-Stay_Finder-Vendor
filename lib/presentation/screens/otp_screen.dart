import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import 'screen_exports.dart';

class OtpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // color: Colors.black,
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
                OtpTextField(
                  fieldWidth: 50,
                  handleControllers: (controllers) {
                    if (controllers.length >= 5) {
                      // print(controllers.te.length);
                      controllers.forEach((element) {
                        if (element?.text != null) {
                          element!.clear();
                        }
                      });
                    }
                  },
                  clearText: true,
                  obscureText: true,
                  onSubmit: (value) {
                    print(value);
                    if (value != 3333) {}
                  },
                  numberOfFields: 5,
                  borderWidth: 2,
                  borderColor: Color(0xff767171),
                  disabledBorderColor: Color(0xff767171),
                  enabledBorderColor: Color(0xff767171),
                  focusedBorderColor: Color(0xff767171),
                  autoFocus: true,
                  borderRadius: BorderRadius.circular(5),
                  showFieldAsBox: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text("Didn't receive a code? "),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/login");
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
    );
  }
}
