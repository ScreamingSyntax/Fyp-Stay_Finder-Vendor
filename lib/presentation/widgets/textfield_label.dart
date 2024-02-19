import 'package:flutter/material.dart';

class TextFieldLabel extends StatelessWidget {
  final String label;
  const TextFieldLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          label,
          style:
              TextStyle(color: Color(0xff212121), fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
