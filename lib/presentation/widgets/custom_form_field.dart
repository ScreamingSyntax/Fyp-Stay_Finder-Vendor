import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomFormField extends StatelessWidget {
  final List<TextInputFormatter> inputFormatters;
  final String? Function(String?)? validatior;
  final void Function(String?)? onChange;
  final void Function()? onTap;
  final void Function(PointerDownEvent?)? onTapOutside;
  final TextInputType? keyboardType;
  const CustomFormField({
    super.key,
    required this.inputFormatters,
    this.validatior,
    this.onChange,
    this.onTap,
    this.onTapOutside,
    this.keyboardType,
  });

  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: this.keyboardType != null ? keyboardType : null,
      inputFormatters: inputFormatters,
      validator: validatior,
      decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xffe5e5e5),
          isDense: true,
          border: borderDecoration(borderColor: Color(0xff878e92), radius: 5),
          errorBorder: borderDecoration(borderColor: Colors.red, radius: 5),
          focusedBorder:
              borderDecoration(borderColor: Color(0xff878e92), radius: 5),
          enabledBorder:
              borderDecoration(borderColor: Color(0xff878e92), radius: 5)),
      onTap: onTap,
      onChanged: onChange,
      onTapOutside: onTapOutside,
    );
  }
}

OutlineInputBorder borderDecoration(
    {required Color borderColor, required double radius}) {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(color: borderColor, width: 1.5));
}
