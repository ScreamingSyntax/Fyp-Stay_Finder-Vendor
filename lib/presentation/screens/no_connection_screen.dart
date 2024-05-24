import 'package:flutter/material.dart';
import 'package:stayfinder_vendor/presentation/widgets/widgets_exports.dart';

class NoConnectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.wifi_off,
              size: 80,
              color: Colors.red.withOpacity(0.7),
            ),
            SizedBox(height: 20),
            Text(
              "Please turn on wifi or mobile data",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.red.withOpacity(0.7),
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
