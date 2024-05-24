import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomFormField extends StatelessWidget {
  final List<TextInputFormatter> inputFormatters;
  final TextEditingController? controller;
  final String? Function(String?)? validatior;
  final void Function(String?)? onChange;
  final void Function()? onTap;
  final void Function(PointerDownEvent?)? onTapOutside;
  final TextInputType? keyboardType;
  final bool obscureText;
  final IconButton? icon;
  final Icon? prefixIcon;
  final String? labelText;
  final String? initialValue;
  final bool? hasBorder;
  const CustomFormField(
      {super.key,
      this.initialValue,
      required this.inputFormatters,
      this.validatior,
      this.onChange,
      this.onTap,
      this.onTapOutside,
      this.keyboardType,
      this.icon,
      this.prefixIcon,
      this.labelText,
      this.obscureText = false,
      this.controller,
      this.hasBorder = true});

  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        controller: controller,
        initialValue: initialValue ?? null,
        obscureText: obscureText,
        keyboardType: this.keyboardType != null ? keyboardType : null,
        inputFormatters: inputFormatters,
        validator: validatior,
        decoration: InputDecoration(
            icon: prefixIcon ?? null,
            suffixIcon: icon,
            filled: true,
            // hintText: "aa",

            labelText: labelText ?? null,
            fillColor: Color(0xffe5e5e5),
            isDense: true,
            border: hasBorder!
                ? borderDecoration(borderColor: Color(0xff878e92), radius: 5)
                : null,
            errorBorder: hasBorder!
                ? borderDecoration(borderColor: Colors.red, radius: 5)
                : null,
            focusedBorder: hasBorder!
                ? borderDecoration(borderColor: Color(0xff878e92), radius: 5)
                : null,
            enabledBorder: hasBorder!
                ? borderDecoration(borderColor: Color(0xff878e92), radius: 5)
                : null),
        onTap: onTap,
        onChanged: onChange,
        onTapOutside: onTapOutside,
      ),
    );
  }
}

OutlineInputBorder borderDecoration(
    {required Color borderColor, required double radius}) {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(color: borderColor, width: 1.5));
}
