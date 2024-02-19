import 'widgets_exports.dart';

// ignore: must_be_immutable
class CustomPoppinsText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  Color? color;
  TextAlign? textAlign;

  CustomPoppinsText(
      {super.key,
      this.color,
      this.textAlign,
      required this.text,
      required this.fontSize,
      required this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign == null ? null : textAlign,
      style: TextStyle(
          // overflow: TextOverflow.ellipsis,/
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: this.color == null ? null : this.color),
    );
  }
}
