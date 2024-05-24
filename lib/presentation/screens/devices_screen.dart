import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stayfinder_vendor/logic/blocs/bloc_exports.dart';
import 'package:stayfinder_vendor/presentation/widgets/widgets_exports.dart';

import '../../data/model/model_exports.dart';
import '../../logic/cubits/cubit_exports.dart';

class DevicesScreen extends StatelessWidget {
  fetchDevicesCall(BuildContext context) {
    var loginState = context.read<LoginBloc>().state;
    if (loginState is LoginLoaded) {
      context.read<FetchDevicesCubit>()
        ..fetchNotification(token: loginState.successModel.token!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteDeviceCubit, DeleteDeviceState>(
      listener: (context, state) {
        if (state is DeleteDeviceError) {
          customScaffold(
              context: context,
              title: "Error",
              message: state.message,
              contentType: ContentType.failure);
        }
        if (state is DeleteDeviceSuccess) {
          customScaffold(
              context: context,
              title: "Success",
              message: state.message,
              contentType: ContentType.success);
          fetchDevicesCall(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Devices",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
        ),
        body: BlocBuilder<FetchDevicesCubit, FetchDevicesState>(
          builder: (context, state) {
            if (state is FetchDevicesError) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    state.message,
                    style: TextStyle(
                      color: Color(0xff455A64),
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomMaterialButton(
                      onPressed: () {
                        fetchDevicesCall(context);
                      },
                      child: Text("Retry"),
                      backgroundColor: Color(0xff455A64),
                      textColor: Colors.white,
                      height: 45)
                ],
              ));
            }
            if (state is FetchDevicesSuccess) {
              var deviceToken =
                  context.read<StoredevicetokenCubit>().state.token;
              return RefreshIndicator(
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  scrollDirection: Axis.vertical,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: state.devices.length,
                  itemBuilder: (context, index) {
                    print(state.devices);
                    DevicesModel devicesModel = state.devices[index];
                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                // pa
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                tileColor: Colors.white,
                                leading: Icon(FontAwesomeIcons.mobile),
                                title: Text(
                                  devicesModel.device_model!,
                                  style: TextStyle(fontSize: 13),
                                ),
                                subtitle: (deviceToken.toString() ==
                                        devicesModel.device_id)
                                    ? Text(
                                        "Current",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : null,
                                trailing: (deviceToken.toString() !=
                                        devicesModel.device_id)
                                    ? InkWell(
                                        onTap: () {
                                          showExitPopup(
                                              context: context,
                                              message:
                                                  "Doing this will remove services such as analytics, notificaitons from the device",
                                              title: "Confirm Action",
                                              noBtnFunction: () {
                                                Navigator.pop(context);
                                              },
                                              yesBtnFunction: () async {
                                                var loginState = context
                                                    .read<LoginBloc>()
                                                    .state;
                                                if (loginState is LoginLoaded) {
                                                  context
                                                      .read<DeleteDeviceCubit>()
                                                    ..deleteDevice(
                                                        deviceId: devicesModel
                                                            .device_id!,
                                                        token: loginState
                                                            .successModel
                                                            .token!);
                                                }
                                                Navigator.pop(context);
                                              });
                                        },
                                        child: Icon(
                                          Icons.delete_outline_outlined,
                                          color: Colors.red,
                                        ),
                                      )
                                    : null,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    );
                  },
                ),
                onRefresh: () async => fetchDevicesCall(context),
              );
            }
            return Column();
          },
        ),
      ),
    );
  }
}
