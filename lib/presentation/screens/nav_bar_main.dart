import 'package:connectivity_bloc/connectivity_bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';

import '../../constants/constants_exports.dart';
import '../../data/api/api_exports.dart';
import '../../logic/blocs/bloc_exports.dart';
import '../../logic/cubits/cubit_exports.dart';
import '../../presentation/widgets/widgets_exports.dart';

class NavBarMain extends StatefulWidget {
  @override
  State<NavBarMain> createState() => _NavBarMainState();
}

class _NavBarMainState extends State<NavBarMain> {
  // if()
  NotificationServices notificationServices = new NotificationServices();
  void getDeviceToken({required BuildContext context}) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String? deviceModel;
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceModel = androidInfo.model;
    }

    notificationServices.getDeviceToken().then((value) {
      if (value != null) {
        var loginState = context.read<LoginBloc>().state;
        if (loginState is LoginLoaded) {
          print("This is value ${value}");
          context.read<StoredevicetokenCubit>()
            ..storeDeviceToken(deviceToken: value);
          context.read<AddDeviceIdCubit>()
            ..addDeviceId(
                token: loginState.successModel.token!,
                id: value.toString(),
                deviceModel: deviceModel);
        }
      }
    });
  }

  @override
  void initState() {
    if (Platform.isAndroid) {
      NotificationServices notificationServices = new NotificationServices();
      notificationServices.requestNotificationPermission();
      getDeviceToken(context: context);
      notificationServices.firebaseInit(context);
      notificationServices.setUpInteractMessage(context);
      notificationServices.foregroundMessage();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitPopup(
          context: context,
          message: "Are you sure you want to exit?",
          title: "Exit",
          noBtnFunction: () => Navigator.pop(context),
          yesBtnFunction: () => SystemNavigator.pop()),
      child: Scaffold(
        bottomNavigationBar: BlocBuilder<ConnectivityBloc, ConnectivityState>(
          builder: (context, state) {
            return CurvedNavigationBar(
              index: context.watch<NavBarIndexCubit>().state.index,
              backgroundColor: Colors.transparent,
              color: (state is ConnectivityFailureState)
                  ? Colors.red.withOpacity(0.7)
                  : Color(0xff263238),
              items: getNavBarItems(),
              onTap: (index) {
                print(index);

                if (index == 2) {
                  var state = context.read<LoginBloc>().state;
                  if (state is LoginLoaded) {
                    context.read<FetchBookingRequestCubit>()
                      ..fetchBookingRequests(token: state.successModel.token!);
                  }
                }
                context.read<NavBarIndexCubit>().changeIndex(index);
              },
            );
          },
        ),
        body: BlocBuilder<ConnectivityBloc, ConnectivityState>(
          builder: (context, connectionState) {
            return BlocBuilder<NavBarIndexCubit, NavBarIndexState>(
              builder: (context, state) {
                if (connectionState is ConnectivityFailureState) {
                  return offLineNavBarBody()[state.index];
                }
                return getNavBarBody()[state.index];
              },
            );
          },
        ),
      ),
    );
  }
}
