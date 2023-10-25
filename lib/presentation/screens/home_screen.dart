import '../../constants/ip.dart';
import '../../logic/blocs/bloc_exports.dart';
import '../../logic/cubits/cubit_exports.dart';
import '../../presentation/widgets/widgets_exports.dart';
import 'home_tab_bodies/tab_exports.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  List<Widget> tabs = [TabBar1(), TabBar2()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Your Plan and Accommodation",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                        Container(
                            width: 100,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  TabBarIcon(
                                    onTap: () {
                                      context
                                          .read<HomeTabbarCubit>()
                                          .firstElementClicked();
                                    },
                                    backgroundColor: firstElement
                                        ? Color(0xffC9C9C9)
                                        : Colors.white,
                                    iconColor: firstElement
                                        ? Color(0xff29383F)
                                        : Color(0xffCAD0E5),
                                    icon: Icons.apps_outlined,
                                  ),
                                  TabBarIcon(
                                    onTap: () {
                                      final state =
                                          context.read<LoginBloc>().state;
                                      if (state is LoginLoaded) {
                                        BlocProvider.of<FetchTierBloc>(context)
                                          ..add(FetchTierHitEvent(
                                              token: state.successModel.token
                                                  .toString()));
                                      }
                                      context
                                          .read<HomeTabbarCubit>()
                                          .secondElementClicked();
                                    },
                                    backgroundColor: secondElement
                                        ? Color(0xffC9C9C9)
                                        : Colors.white,
                                    iconColor: secondElement
                                        ? Color(0xff29383F)
                                        : Color(0xffCAD0E5),
                                    icon: Icons.more_horiz_rounded,
                                  )
                                ]))
                      ],
                    ),
                    if (state.item1) tabs[0] else tabs[1]
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
  }
}

class UpperBody extends StatelessWidget {
  const UpperBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 224,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Stay",
                      style: TextStyle(fontFamily: 'Slackey', fontSize: 24),
                    ),
                    Text(
                      "finder",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<VendorDataProviderBloc,
                        VendorDataProviderState>(builder: (context, state) {
                      if (state is VendorLoaded) {
                        return Text(
                          "Hi ${state.vendorModel.fullName},",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        );
                      }
                      return Text(
                        "Hi There,",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      );
                    }),
                    Text(
                      "Good Morning",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, "/profile");
                      },
                      child: BlocBuilder<FetchVendorProfileBloc,
                          FetchVendorProfileState>(
                        builder: (context, fetchVendorState) {
                          if (fetchVendorState is FetchVendorProfileLoaded) {
                            return Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(200),
                                  border: Border.all(
                                      width: 2, color: Colors.black)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(200),
                                child: CachedNetworkImage(
                                    width: 88,
                                    height: 88,
                                    fit: BoxFit.fill,
                                    imageUrl:
                                        "${getIp()}${fetchVendorState.vendorProfile.profile_picture}"),
                              ),
                            );
                          }
                          return SizedBox();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
      margin: EdgeInsets.all(0.2),
      decoration: BoxDecoration(
          color: Color(0xffDAD7CD),
          border: Border.all(
            color: Color(
              0xff29383F,
            ),
          ),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(
                50,
              ),
              bottomRight: Radius.circular(50))),
    );
  }
}
