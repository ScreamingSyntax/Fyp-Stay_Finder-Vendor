import 'widgets_exports.dart';

class CustomCheckBoxDetailTile extends StatelessWidget {
  const CustomCheckBoxDetailTile({
    super.key,
    required this.value,
    required this.text,
    required this.icon,
  });

  final bool value;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      // padding: ,
      child: Row(
        children: [
          Container(
            height: 50,
            width: 100,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: value
                  ? Colors.blue.withOpacity(0.1)
                  : Colors.blue.withOpacity(0.11),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: Colors.black.withOpacity(0.5),
                  size: 16,
                ),
                SizedBox(
                  width: 20,
                ),
                CustomPoppinsText(
                    text: text, fontSize: 12, fontWeight: FontWeight.w400),
              ],
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Icon(
            value ? Icons.verified : Icons.clear,
            color: value ? Colors.blue : Colors.red,
          )
        ],
      ),
    );
  }
}
