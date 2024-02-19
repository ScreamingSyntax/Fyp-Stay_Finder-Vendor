// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:stayfinder_vendor/logic/blocs/fetch_added_accommodations/fetch_added_accommodations_bloc.dart';
import 'package:stayfinder_vendor/logic/blocs/fetch_current_tier/fetch_current_tier_bloc.dart';

import '../../logic/blocs/bloc_exports.dart';
import '../../logic/cubits/cubit_exports.dart';
import '../../presentation/widgets/widgets_exports.dart';
import 'home_tab_bodies/tab_exports.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  List<Widget> tabs = [TabBar1(), TabBar2()];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, loggedInStae) {
        return RefreshIndicator(
          onRefresh: () async {
            if (loggedInStae is LoginLoaded) {
              callApis(context, loggedInStae);
            }
          },
          child: BlocBuilder<FetchVendorProfileBloc, FetchVendorProfileState>(
            builder: (context, fetchVendorProfileState) {
              return BlocBuilder<FetchCurrentTierBloc, FetchCurrentTierState>(
                builder: (context, fetchCurrentTier) {
                  if (loggedInStae is LoginLoaded) {
                    if (fetchCurrentTier is FetchCurrentTierError ||
                        fetchVendorProfileState is FetchVendorProfileError) {
                      return NoInternetConnection(
                        loggedInStae: loggedInStae,
                      );
                    }
                  }
                  return Scaffold(
                    backgroundColor: Color(0xffECEFF1),
                    body: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          UpperBody(),
                          SizedBox(
                            height: 30,
                          ),
                          BlocBuilder<HomeTabbarCubit, HomeTabbarState>(
                            builder: (context, state) {
                              bool firstElement = state.item1;
                              bool secondElement = state.item2;
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      CustomPoppinsText(
                                          text: "Your Plan and Accomodation",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                      HomeTabBar(
                                          context, firstElement, secondElement)
                                    ],
                                  ),
                                  if (state.item1) tabs[0] else tabs[1],
                                ],
                              );
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  Container HomeTabBar(
      BuildContext context, bool firstElement, bool secondElement) {
    return Container(
        width: 100,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          TabBarIcon(
            onTap: () {
              context.read<HomeTabbarCubit>().firstElementClicked();
            },
            backgroundColor: firstElement ? Color(0xffC9C9C9) : Colors.white,
            iconColor: firstElement
                ? Color(0xff29383F)
                : Color.fromRGBO(202, 208, 229, 1),
            icon: Icons.apps_outlined,
          ),
          TabBarIcon(
            onTap: () {
              final state = context.read<LoginBloc>().state;
              final state2 = context.read<FetchTierBloc>().state;
              if (state is LoginLoaded) {
                if (state2 is! FetchTierLoadedState) {
                  BlocProvider.of<FetchTierBloc>(context)
                    ..add(FetchTierHitEvent(
                        token: state.successModel.token.toString()));
                }
              }
              context.read<HomeTabbarCubit>().secondElementClicked();
            },
            backgroundColor: secondElement ? Color(0xffC9C9C9) : Colors.white,
            iconColor: secondElement ? Color(0xff29383F) : Color(0xffCAD0E5),
            icon: Icons.more_horiz_rounded,
          )
        ]));
  }
}

class NoInternetConnection extends StatelessWidget {
  final LoginLoaded loggedInStae;
  const NoInternetConnection({
    super.key,
    required this.loggedInStae,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          UpperBody(),
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomPoppinsText(
                    text: "Please Check your Internet Connection",
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 140.0),
                    child: CustomMaterialButton(
                      height: 40,
                      backgroundColor: Color(0xff546464),
                      textColor: Colors.white,
                      child: Text("Retry"),
                      onPressed: () {
                        callApis(context, loggedInStae);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void callApis(BuildContext context, LoginLoaded loggedInStae) {
  context
      .read<FetchTierBloc>()
      .add(FetchTierHitEvent(token: loggedInStae.successModel.token!));
  context
      .read<FetchVendorProfileBloc>()
      .add(HitFetchVendorProfileEvent(token: loggedInStae.successModel.token!));
  var currentTierState = context.read<FetchVendorProfileBloc>().state;
  if (currentTierState is FetchVendorProfileLoaded) {
    callNotificationsMethod(context);
    if (currentTierState.vendorProfile.is_verified == 'True') {
      context.read<FetchCurrentTierBloc>().add(
          FetchCurrentTierHitEvent(token: loggedInStae.successModel.token!));
      context.read<FetchAddedAccommodationsBloc>()
        ..add(FetchAddedAccommodationHitEvent(
            token: loggedInStae.successModel.token!));
    }
  }
}
