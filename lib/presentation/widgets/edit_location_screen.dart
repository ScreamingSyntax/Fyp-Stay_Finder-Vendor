import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:stayfinder_vendor/logic/blocs/bloc_exports.dart';
import 'package:stayfinder_vendor/presentation/widgets/widgets_exports.dart';

import '../../logic/cubits/cubit_exports.dart';

Future<dynamic> editLocation(
    {required BuildContext context,
    required double latitude,
    required int id,
    required MapController mapController,
    required double longitude}) {
  return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: FlutterMap(
                    mapController: mapController,
                    options: MapOptions(
                      onMapEvent: (p0) {
                        // p0.
                      },
                      maxZoom: 20,
                      initialCenter: LatLng(latitude, longitude),
                      initialZoom: 15,
                      onLongPress: (tapPosition, point) {
                        context.read<SaveLocationCubit>()
                          ..storeLocation(
                              longitude: point.longitude.toString(),
                              latitude: point.latitude.toString());
                      },
                    ),
                    children: [
                      TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName:
                              "com.example.stayfinder_vendor"),
                      BlocBuilder<SaveLocationCubit, SaveLocationState>(
                        builder: (context, state) {
                          if (state.latitude != null) {
                            // print("Change");
                            return MarkerLayer(
                                alignment: Alignment.center,
                                markers: [
                                  Marker(
                                      point: LatLng(
                                          double.parse(state.latitude!),
                                          double.parse(state.longitude!)),
                                      child: Icon(
                                        Icons.location_on,
                                        color: Colors.red,
                                        size: 30,
                                      ))
                                ]);
                          }
                          return SizedBox();
                        },
                      ),
                      MarkerLayer(alignment: Alignment.center, markers: [
                        Marker(
                            point: LatLng(latitude, longitude),
                            child: Icon(
                              Icons.emoji_people,
                              color: Colors.red,
                              size: 20,
                            ))
                      ]),
                      RichAttributionWidget(
                        attributions: [
                          TextSourceAttribution('OpenStreetMap contributors',
                              onTap: () {}),
                        ],
                      ),
                    ]),
              ),
              Positioned(
                  top: 50,
                  left: 30,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xff455A64),
                          borderRadius: BorderRadius.circular(15)),
                      padding: const EdgeInsets.all(10.0),
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  mapController.dispose();
                                  // Navigator.pop(context);
                                  // _mapControlle
                                },
                                child: Icon(
                                  size: 15,
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Text(
                                  "Longpress the accommodation address",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
              Positioned(
                  bottom: 20,
                  left: 30,
                  child: InkWell(
                    onTap: () =>
                        mapController.move(LatLng(latitude, longitude), 17),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.location_searching_rounded,
                            size: 30,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        BlocBuilder<SaveLocationCubit, SaveLocationState>(
                          builder: (context, state) {
                            if (state.latitude != null) {
                              return SizedBox(
                                width: MediaQuery.of(context).size.width / 3,
                                child: CustomMaterialButton(
                                    onPressed: () {
                                      var loginState =
                                          context.read<LoginBloc>().state;
                                      if (loginState is LoginLoaded) {
                                        context.read<
                                            UpdateAccommodationLocationCubit>()
                                          ..updateAccommodationLocation(
                                              token: loginState
                                                  .successModel.token!,
                                              longitude: state.longitude!,
                                              latitude: state.latitude!);
                                      }
                                    },
                                    child: Text("Confirm"),
                                    backgroundColor: Color(0xff514f53),
                                    textColor: Colors.white,
                                    height: 45),
                              );
                            }
                            return SizedBox();
                          },
                        )
                      ],
                    ),
                  )),
            ],
          ),
        );
      });
}
