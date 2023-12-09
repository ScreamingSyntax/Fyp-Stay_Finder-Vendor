import 'widgets_exports.dart';

class CustomCheckBoxTile extends StatelessWidget {
  final String title;
  final void Function(bool?)? onChanged;
  final bool value;
  final IconData icon;
  Color? color;
  CustomCheckBoxTile(
      {super.key,
      this.color,
      required this.title,
      required this.onChanged,
      required this.value,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 10,
      // padding: EdgeInsets.all(),
      decoration: BoxDecoration(
          color: color ?? Color(0xffe5e5e5),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(width: 2, color: Color(0xffa8abaf))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              icon,
              color: Color(0xff625f66),
              size: 12,
            ),
          ),
          CustomPoppinsText(
              text: title,
              fontSize: 10,
              color: Color(0xff625f66),
              fontWeight: FontWeight.w500),
          SizedBox(
            // height: 14,
            // width: 14,
            child: Transform.scale(
              scale: 0.8,
              child: Checkbox(

                  // visualDensity: VisualDensity(horizontal: -55, vertical: -5),
                  fillColor: MaterialStatePropertyAll(Color(0xff625f66)),
                  overlayColor: MaterialStatePropertyAll(Color(0xffD9D9D9)),
                  value: value,
                  onChanged: onChanged),
            ),
          ),
        ],
      ),
    );
  }
}
