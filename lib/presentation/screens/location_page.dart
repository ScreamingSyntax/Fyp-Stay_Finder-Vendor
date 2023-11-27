import 'package:geolocator/geolocator.dart';
import 'package:stayfinder_vendor/presentation/widgets/widgets_exports.dart';
import 'package:stayfinder_vendor/constants/constants_exports.dart';

class LocationPage extends StatefulWidget {
  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  String? _currentAddress;

  Position? _currentPosition;
  Future<void> _getCurrentPosition() async {
    final hasPermission =
        await LocationHandler.handleLocationPermission(context);
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('LAT: ${_currentPosition?.latitude ?? ""}'),
          Text('LNG: ${_currentPosition?.longitude ?? ""}'),
          Text('ADDRESS: ${_currentAddress ?? ""}'),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: _getCurrentPosition,
            child: const Text("Get Current Location"),
          )
        ],
      ),
    );
  }
}
