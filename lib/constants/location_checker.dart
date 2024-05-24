import 'package:geolocator/geolocator.dart';
import 'package:stayfinder_vendor/presentation/widgets/widgets_exports.dart';

class LocationHandler {
  static Future<bool> handleLocationPermission(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      customScaffold(
          context: context,
          title: "Permission Denied",
          message: 'Please enable gps on your system',
          contentType: ContentType.failure);
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      customScaffold(
          context: context,
          title: "Permission Denied",
          message:
              'Location permissions are denied, Please enable permissions manually from settings',
          contentType: ContentType.failure);
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //     content: Text(
      //   style: TextStyle(fontSize: 12),
      // )));
      return false;
    }
    return true;
  }
}
