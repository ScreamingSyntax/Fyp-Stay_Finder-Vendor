import '../../logic/blocs/bloc_exports.dart';
import '../../logic/cubits/cubit_exports.dart';
import '../../presentation/widgets/widgets_exports.dart';
import '../screens/screen_exports.dart';

class AppRouter {
  Route onGeneratedRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case "/":
        return checkOnBoardingStatus();
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
      case "accommodationMain":
        return MaterialPageRoute(builder: (_) => AccommodationMainScreen());
      case "/addRentalScreen":
        return MaterialPageRoute(
          builder: (_) => RentalRoomAdditionScreen(),
        );
      case "/info":
        return MaterialPageRoute(builder: (_) => InformationScreen());
      case "/addHostelScreen":
        return MaterialPageRoute(builder: (_) => HostelAdditionScreen());
      // case "/addHotelScreen":
      //   return MaterialPageRoute(builder: (_) => HotelAdditionScreen());
      case "/hotelLandingScren":
        return MaterialPageRoute(builder: (_) => HotelLandingScreen());
      case "/hotelWithoutTierAddScreen":
        return MaterialPageRoute(
          builder: (_) => HostelWithoutTierScreen(),
        );
      case "/hotelWithTierAddScreen":
        return MaterialPageRoute(
          builder: (_) => HostelWithTierScreen(),
        );
      case "/hotelWithTierAddTierScreen":
        return MaterialPageRoute(
          builder: (_) => AddTierScreen(),
        );
      case "/viewRentalRoom":
        return MaterialPageRoute(
            builder: (_) => RentalRoomViewScreen(
                  arguments: routeSettings.arguments!,
                ));
      case "/viewHostel":
        return MaterialPageRoute(
            builder: (_) => HostelViewScreen(
                  arguments: routeSettings.arguments!,
                ));
      case "/viewHotelWithoutTier":
        return MaterialPageRoute(
            builder: (_) => HotelWithoutTierView(
                  data: routeSettings.arguments! as Map,
                ));
      case "/viewHotelWithTier":
        return MaterialPageRoute(
          builder: (_) => HotelWithTierView(
            data: routeSettings.arguments! as Map,
          ),
        );
      case "/resetPass":
        return MaterialPageRoute(builder: (_) => ResetPasswordScreen());
      case "/revenue":
        return MaterialPageRoute(builder: (_) => MonitorRevenueScreen());
      case "/forgotPass":
        return MaterialPageRoute(builder: (_) => ForgotPasswordEmailScreen());
      case "/devices":
        return MaterialPageRoute(builder: (_) => DevicesScreen());
      case '/inventory':
        return MaterialPageRoute(builder: (_) => InventoryScreen());
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
