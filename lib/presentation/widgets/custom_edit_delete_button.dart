// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:stayfinder_vendor/logic/cubits/save_location/save_location_cubit.dart';

import '../../constants/constants_exports.dart';
import 'widgets_exports.dart';

class EditDeleteButtonWidget extends StatelessWidget {
  final Function() editOnTap;
  final Function() deleteOnTap;
  final int accommodationId;
  final MapController controller;
  final double longitude;
  final double latitude;
  const EditDeleteButtonWidget({
    Key? key,
    required this.editOnTap,
    required this.deleteOnTap,
    required this.accommodationId,
    required this.controller,
    required this.longitude,
    required this.latitude,
  }) : super(key: key);

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
          onTap: () async {
            context.read<SaveLocationCubit>()..clearLocation();
            context.read<SaveLocationCubit>()
              ..storeLocation(
                  longitude: longitude.toString(),
                  latitude: latitude.toString());
            bool locationPermission =
                await LocationHandler.handleLocationPermission(context);
            customScaffold(
                context: context,
                title: "Please Wait",
                message: "We are getting your current location",
                contentType: ContentType.warning);
            if (locationPermission) {
              Position position = await Geolocator.getCurrentPosition(
                  desiredAccuracy: LocationAccuracy.high);

              editLocation(
                  context: context,
                  latitude: position.latitude,
                  id: accommodationId,
                  longitude: position.longitude,
                  mapController: controller);
            }
          },
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
