import 'widgets_exports.dart';

class EditDeleteButtonWidget extends StatelessWidget {
  final Function() editOnTap;
  final Function() deleteOnTap;
  const EditDeleteButtonWidget(
      {super.key, required this.editOnTap, required this.deleteOnTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: editOnTap,
          child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Icon(Icons.edit)),
        ),
        SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: deleteOnTap,
          child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(5)),
              child: Icon(
                Icons.delete,
                color: Colors.white,
              )),
        ),
      ],
    );
  }
}
