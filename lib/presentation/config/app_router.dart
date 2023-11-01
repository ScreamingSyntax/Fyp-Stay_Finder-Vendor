import 'package:stayfinder_vendor/presentation/screens/renew_subscription_screen.dart';
import 'package:stayfinder_vendor/presentation/screens/transaction_history_screen.dart';

import '../../logic/blocs/bloc_exports.dart';
import '../../logic/cubits/cubit_exports.dart';
import '../../presentation/widgets/widgets_exports.dart';
import '../screens/screen_exports.dart';

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
      case "/paymentHistory":
        return MaterialPageRoute(
          builder: (_) => TransactionHistoryScreen(),
        );
      case "/renewSubscription":
        return MaterialPageRoute(
          builder: (_) => RenewSubscriptionScreen(),
        );
      case "/profile":
        return MaterialPageRoute(
          builder: (_) => ProfileScreen(),
        );
      case "/info":
        return MaterialPageRoute(builder: (_) => InformationScreen());
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
