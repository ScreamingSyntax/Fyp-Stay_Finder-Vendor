import 'package:flutter/material.dart';

Future<bool> showExitPopup({
  required BuildContext context,
  required String message,
  required String title,
  required Function() noBtnFunction,
  required Function() yesBtnFunction,
}) async {
  return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF29383F).withOpacity(0.8),
              fontSize: 16.0, // Adjust the font size
            ),
          ),
          content: Text(
            message,
            style: TextStyle(
              fontSize: 16.0, // Adjust the font size
              color: Color(0xFF29383F).withOpacity(0.8),
            ),
          ),
          backgroundColor: Colors.white,
          actions: [
            ElevatedButton(
              onPressed: noBtnFunction,
              child: Text(
                'No',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0, // Adjust the font size
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                  Color(0xFF29383F).withOpacity(0.5),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: yesBtnFunction,
              child: Text(
                'Yes',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0, // Adjust the font size
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                  Color(0xFF29383F).withOpacity(0.5),
                ),
              ),
            ),
          ],
        ),
      ) ??
      false;
}
