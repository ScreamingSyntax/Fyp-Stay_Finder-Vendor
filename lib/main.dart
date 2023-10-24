import 'package:stayfinder_vendor/data/repository/vendor_profile_repository.dart';

import '../../logic/blocs/bloc_exports.dart';
import '../../logic/cubits/cubit_exports.dart';
import '../../presentation/widgets/widgets_exports.dart';
import '../../presentation/config/config_exports.dart';
import 'data/repository/repository_exports.dart';

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
        )
      ],
      child: RepositoryProvider(
        create: (context) => LoginRepository(),
        child: MaterialApp(
          theme: ThemeData(useMaterial3: true, fontFamily: 'Poppins'),
          onGenerateRoute: appRouter.onGeneratedRoute,
        ),
      ),
    );
  }
}
