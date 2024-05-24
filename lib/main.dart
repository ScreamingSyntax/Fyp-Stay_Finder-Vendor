import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:stayfinder_vendor/data/api/api_exports.dart';

import 'package:connectivity_bloc/connectivity_bloc.dart';
import '../../logic/blocs/bloc_exports.dart';
import '../../logic/cubits/cubit_exports.dart';
import '../../presentation/widgets/widgets_exports.dart';
import '../../presentation/config/config_exports.dart';
import 'data/repository/repository_exports.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  AndroidNotificationChannel channel = AndroidNotificationChannel(
      Random.secure().nextInt(10000).toString(), "High Importance notification",
      importance: Importance.max);
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );

  AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    channel.id.toString(),
    channel.name.toString(),
    channelDescription: 'your_channel_description',
    importance: Importance.max,
    priority: Priority.high,
    showWhen: false,
  );
  NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0,
    message.notification?.title,
    message.notification?.body,
    platformChannelSpecifics,
    payload: 'item x',
  );

  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  runApp(MyApp(
    appRouter: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  const MyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OnBoardingCubit(),
        ),
        BlocProvider(
          create: (context) => ConnectivityBloc(),
        ),
        BlocProvider(
          create: (context) => RememberMeCubit(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(
              apiRepository: LoginRepository(),
              rememberMe: context.read<RememberMeCubit>().state.rememberMe),
        ),
        BlocProvider(
          create: (context) =>
              VendorDataProviderBloc(vendorRepository: VendorRepository()),
        ),
        BlocProvider(
          create: (context) => SignupBloc(repository: SignUpRepository()),
        ),
        BlocProvider(create: (context) => HomeTabbarCubit()),
        BlocProvider(
            create: (context) =>
                SignUpOtpDartBloc(repository: SignUpRepository())),
        BlocProvider(
          create: (context) => FetchTierBloc(tier: TierRepository()),
        ),
        BlocProvider(
          create: (context) =>
              FetchVendorProfileBloc(repository: VendorProfileRepository()),
        ),
        BlocProvider(create: (context) => ImageHelperCubit()),
        BlocProvider(
          create: (context) => DocumentDetailDartBloc(),
        ),
        BlocProvider(
          create: (context) => ProfileVerificationBloc(
              repository: ProfileVerificationRepository()),
        ),
        BlocProvider(
          create: (context) =>
              FetchCurrentTierBloc(repository: CurrentTierApiRepository()),
        ),
        BlocProvider(
            create: (context) => FetchTransactionHistoryBloc(
                transactionHistoryRepository: TransactionHistoryRepository())),
        BlocProvider(
          create: (context) => RadioListTileCubit(),
        ),
        BlocProvider(
          create: (context) => DropDownValueCubit(),
        ),
        BlocProvider(
          create: (context) =>
              RenewSubscriptionBloc(renewTierRepository: RenewTierRepository()),
        ),
        BlocProvider(
          create: (context) => AddRentalRoomBloc(),
        ),
        BlocProvider(
          create: (context) => HostelAdditionBloc(),
        ),
        BlocProvider(
          create: (context) => FetchAddedAccommodationsBloc(
              repo: AccommodationAdditionRepository()),
        ),
        BlocProvider(
          create: (context) => AccommodationAdditionBloc(),
        ),
        BlocProvider(
          create: (context) => AddHotelWithoutTierBloc(),
        ),
        BlocProvider(
          create: (context) => AddHotelWithoutTierApiCallbackBlocBloc(
              repo: AccommodationAdditionRepository()),
        ),
        BlocProvider(
          create: (context) => AddHotelWithTierBlocBloc(),
        ),
        BlocProvider(
          create: (context) => StoreRoomsCubit(),
        ),
        BlocProvider(
          create: (context) => FetchRentalRoomCubit(),
        ),
        BlocProvider(
          create: (context) => UpdateRentalAccommodationCubit(),
        ),
        BlocProvider(
          create: (context) => FetchHostelDetailsCubit(),
        ),
        BlocProvider(
          create: (context) => UpdateHostelCubit(),
        ),
        BlocProvider(
          create: (context) => FetchHotelWithoutTierCubit(),
        ),
        BlocProvider(
          create: (context) => UpdateHotelWithoutTierCubit(),
        ),
        BlocProvider(
          create: (context) => FetchHotelWithTierCubit(),
        ),
        BlocProvider(
          create: (context) => UpdateHotelWithTierCubit(),
        ),
        BlocProvider(
          create: (context) => FetchBookingRequestCubit(),
        ),
        BlocProvider(create: (context) => VerifyBookingRequestCubit()),
        BlocProvider(create: (context) => FetchParticularBookingDetailsCubit()),
        BlocProvider(create: (context) => FetchAccommodationReviewsCubit()),
        BlocProvider(create: (context) => ResetPasswordCubit()),
        BlocProvider(
            create: (context) => ResumbitAccommodationVerificationCubit()),
        BlocProvider(create: (context) => FetchRevenueDataCubit()),
        BlocProvider(create: (context) => ForgotPassCubit()),
        BlocProvider(create: (context) => StoreTempUserDetailsCubit()),
        BlocProvider(create: (context) => BooleanChangeCubit()),
        BlocProvider(create: (context) => FetchNotificationsCubit()),
        BlocProvider(create: (context) => SaveLocationCubit()),
        BlocProvider(
          create: (context) => UpdateAccommodationLocationCubit(),
        ),
        BlocProvider(create: (context) => AddDeviceIdCubit()),
        BlocProvider(create: (context) => FetchDevicesCubit()),
        BlocProvider(create: (context) => StoredevicetokenCubit()),
        BlocProvider(create: (context) => DeleteDeviceCubit()),
        BlocProvider(create: (context) => StoreSingularDateCubit()),
        BlocProvider(create: (context) => StoreRangeDatesCubit()),
        BlocProvider(create: (context) => StoreFilterCubit()),
        BlocProvider(create: (context) => AddInventoryCubit()),
        BlocProvider(create: (context) => FetchInventoryCubit()),
        BlocProvider(create: (context) => GetAllMessagesCubit()),
        BlocProvider(create: (context) => ViewParticularChatCubit()),
        BlocProvider(
          create: (context) => ChatCubit(ChatRepository()),
        ),
        BlocProvider(
          create: (context) => SeenAllMessagesCubit(),
        ),
      ],
      child: RepositoryProvider(
        create: (context) => LoginRepository(),
        child: KhaltiScope(
          publicKey: "test_public_key_d6413422f8ce49868d7c874e68c5f557",
          enabledDebugging: true,
          builder: (context, navKey) {
            return MaterialApp(
              navigatorKey: navKey,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(useMaterial3: true, fontFamily: 'Poppins'),
              onGenerateRoute: appRouter.onGeneratedRoute,
              localizationsDelegates: const [KhaltiLocalizations.delegate],
            );
          },
        ),
      ),
    );
  }
}
