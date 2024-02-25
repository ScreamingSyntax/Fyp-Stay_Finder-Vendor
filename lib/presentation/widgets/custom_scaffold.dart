import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

void customScaffold(
    {required BuildContext context,
    required String title,
    required String message,
    required ContentType contentType}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    duration: Duration(milliseconds: 1000),
    content: AwesomeSnackbarContent(
      title: title,
      message: message,
      contentType: contentType,
      titleFontSize: 13,
      messageFontSize: 11,
    ),
  ));
}
