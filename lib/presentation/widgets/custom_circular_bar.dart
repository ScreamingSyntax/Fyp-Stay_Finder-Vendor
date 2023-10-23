import 'widgets_exports.dart';

class CustomCircularBar extends StatelessWidget {
  final String message;
  const CustomCircularBar({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
          Text(message)
        ],
      ),
    );
  }
}
