import 'package:stayfinder_vendor/data/repository/vendor_profile_repository.dart';
import 'package:stayfinder_vendor/logic/blocs/fetch_current_tier/fetch_current_tier_bloc.dart';

import '../../logic/blocs/bloc_exports.dart';
import '../../logic/cubits/cubit_exports.dart';
import '../../presentation/widgets/widgets_exports.dart';
import '../../presentation/config/config_exports.dart';
import 'data/repository/repository_exports.dart';
// import '';
import 'package:khalti_flutter/khalti_flutter.dart';

import 'logic/blocs/accommodation_addition/accommodation_addition_bloc.dart';
import 'logic/blocs/add_rental_room/add_rental_room_bloc.dart';
import 'logic/blocs/fetch_added_accommodations/fetch_added_accommodations_bloc.dart';
import 'logic/blocs/hostel_addition/hostel_addition_bloc.dart';
import 'logic/blocs/hotel_without_tier_addition/add_hotel_without_tier_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
