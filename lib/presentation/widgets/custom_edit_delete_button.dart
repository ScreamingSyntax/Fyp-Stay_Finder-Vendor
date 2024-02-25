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
              height: 40,
              width: 40,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                  offset: Offset(0, 2),
                  blurRadius: 8.0,
                  spreadRadius: -1.0,
                ),
              ], color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Icon(Icons.edit)),
        ),
        SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: deleteOnTap,
          child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                  offset: Offset(0, 2),
                  blurRadius: 8.0,
                  spreadRadius: -1.0,
                ),
              ], color: Colors.red, borderRadius: BorderRadius.circular(5)),
              child: Icon(
                Icons.delete,
                color: Colors.white,
              )),
        ),
        SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: deleteOnTap,
          child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                      offset: Offset(0, 2),
                      blurRadius: 8.0,
                      spreadRadius: -1.0,
                    ),
                  ],
                  color: Colors.blue.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(5)),
              child: Icon(
                Icons.map,
                color: Colors.black.withOpacity(0.8),
              )),
        ),
        // SizedBox(
        //   height: 10,
        // ),
        // Container(
        //   width: MediaQuery.of(context).size.width,
        //   child: Icon(Icons.location_on_outlined),
        // )
        // )
      ],
    );
  }
}
