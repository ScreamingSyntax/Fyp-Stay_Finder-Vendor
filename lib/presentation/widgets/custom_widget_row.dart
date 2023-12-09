import 'widgets_exports.dart';

class CustomWidgetRow extends StatelessWidget {
  final Widget widget1;
  final Widget widget2;

  CustomWidgetRow({
    super.key,
    required this.widget1,
    required this.widget2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
            width: MediaQuery.of(context).size.width / 2.2, child: widget1),
        SizedBox(
            width: MediaQuery.of(context).size.width / 2.2, child: widget2),
      ],
    );
  }
}
