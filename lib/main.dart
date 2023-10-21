import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stayfinder_vendor/data/api/login_api.dart';
import 'package:stayfinder_vendor/data/api/vendor_data_api.dart';
import 'package:stayfinder_vendor/data/repository/login_repository.dart';
import 'package:stayfinder_vendor/data/repository/sign_up_repository.dart';
import 'package:stayfinder_vendor/data/repository/vendor_repository.dart';
import 'package:stayfinder_vendor/logic/blocs/form_bloc/form_bloc.dart';
import 'package:stayfinder_vendor/logic/blocs/login/login_bloc.dart';
import 'package:stayfinder_vendor/logic/blocs/sign_up/signup_bloc.dart';
import 'package:stayfinder_vendor/logic/blocs/sign_up_otp/sign_up_otp_dart_bloc.dart';
import 'package:stayfinder_vendor/logic/blocs/vendor_data/vendor_data_provider_bloc.dart';
import 'package:stayfinder_vendor/logic/cubits/home_tab_bar/home_tabbar_cubit.dart';
import 'package:stayfinder_vendor/logic/cubits/on_boarding/on_boarding_cubit.dart';
import 'package:stayfinder_vendor/logic/cubits/remember_me/remember_me_cubit.dart';
import 'package:stayfinder_vendor/presentation/config/app_router.dart';

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

  // const MyApp(super.key);
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
