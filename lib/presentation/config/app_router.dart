import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stayfinder_vendor/logic/blocs/login/login_bloc.dart';
import 'package:stayfinder_vendor/logic/cubits/nav_bar_index/nav_bar_index_cubit.dart';
import 'package:stayfinder_vendor/logic/cubits/on_boarding/on_boarding_cubit.dart';
import 'package:stayfinder_vendor/presentation/screens/screen_exports.dart';
import '../../logic/blocs/form_bloc/form_bloc.dart';

class AppRouter {
  Route onGeneratedRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case "/":
        return checkOnBoardingStatus();
      // return MaterialPageRoute(
      //   builder: (_) => BlocProvider(
      //     create: (_) => FormBloc()..add(InitEvent()),
      //     child: SignUpScreen(),
      //   ),
      // );
      case "/login":
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (_) => FormBloc(),
                  child: LoginScreen(),
                ));
      case "/otp":
        return MaterialPageRoute(builder: (_) => OtpScreen());
      case "/signUp":
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => FormBloc()..add(InitEvent()),
            child: SignUpScreen(),
          ),
        );
      case "/home":
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
              var state = context.read<LoginBloc>().state;
              print(status);
              bool remember_me = false;
              if (state is LoginLoaded) {
                remember_me = state.rememberMe;
              }
              if (status == false) {
                return OnBoardingScreen();
              } else {
                return MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (_) => FormBloc(),
                    ),
                  ],
                  child: LoginLogic(context, remember_me),
                );
              }
            }));
  }

  StatelessWidget LoginLogic(BuildContext context, bool remember_me) {
    if (remember_me == true) {
      return BlocProvider(
        create: (_) => NavBarIndexCubit(),
        child: NavBarMain(),
      );
    }
    return LoginScreen();
  }
}
