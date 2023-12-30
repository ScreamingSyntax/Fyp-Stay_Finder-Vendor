import 'widgets_exports.dart';

class CustomMainImageVIew extends StatelessWidget {
  final String imageLink;
  const CustomMainImageVIew({
    super.key,
    required this.imageLink,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CachedNetworkImage(
        imageBuilder: (context, imageProvider) {
          return Container(
            width: 135,
            height: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                image: DecorationImage(
                    alignment: Alignment.center,
                    image: imageProvider,
                    fit: BoxFit.cover)),
          );
        },
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
        alignment: Alignment.center,
        imageUrl: imageLink,
        height: 250,
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }
}
