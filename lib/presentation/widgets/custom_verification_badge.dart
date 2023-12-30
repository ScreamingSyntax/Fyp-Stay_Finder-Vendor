import 'widgets_exports.dart';

class VerificationBadgeRentalRoom extends StatelessWidget {
  final Widget w1;
  final Widget w2;
  const VerificationBadgeRentalRoom({
    super.key,
    required this.w1,
    required this.w2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            decoration: BoxDecoration(
                color: Colors.teal, borderRadius: BorderRadius.circular(50)),
            width: 120,
            height: 50,
            padding: EdgeInsets.all(5),
            child: Container(
              padding: EdgeInsets.all(5),
              child: Row(
                children: [
                  w1,
                  SizedBox(
                    width: 10,
                  ),
                  w2
                ],
              ),
            )),
      ],
    );
  }
}
