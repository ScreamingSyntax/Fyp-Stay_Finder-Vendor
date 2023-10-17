import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stayfinder_vendor/logic/cubits/nav_bar_index/nav_bar_index_cubit.dart';
import 'package:stayfinder_vendor/logic/cubits/on_boarding/on_boarding_cubit.dart';
import 'package:stayfinder_vendor/logic/cubits/remember_me/remember_me_cubit.dart';
import 'package:stayfinder_vendor/presentation/screens/nav_bar_main.dart';
import 'package:stayfinder_vendor/presentation/screens/screen_exports.dart';
import '../../logic/blocs/form_bloc/form_bloc.dart';

class AppRouter {
  Route onGeneratedRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      // case "/":
      //   return checkOnBoardingStatus();
      // case "/home":
      //   return MaterialPageRoute(builder: (_) => HomeScreen());
      // case "/signUp":
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider(
      //       create: (_) => FormBloc()..add(InitEvent()),
      //       child: SignUpScreen(),
      //     ),
      //   );
      case "/":
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => NavBarIndexCubit(),
            child: NavBarMain(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Text("No Route named ${routeSettings.name} found")],
            ),
          ),
        );
    }
  }

  MaterialPageRoute<dynamic> checkOnBoardingStatus() {
    return MaterialPageRoute(
        builder: (_) => Builder(builder: (context) {
              var status =
                  context.read<OnBoardingCubit>().state.visitedOnBoarding;
              if (status == false) {
                return OnBoardingScreen();
              } else {
                return MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (_) => FormBloc(),
                    ),
                    BlocProvider(
                      create: (context) => RememberMeCubit(),
                    ),
                  ],
                  child: LoginScreen(),
                );
              }
            }));
  }
}
