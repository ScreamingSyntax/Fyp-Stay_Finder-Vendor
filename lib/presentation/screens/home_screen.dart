import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stayfinder_vendor/logic/cubits/home_tab_bar/home_tabbar_cubit.dart';
import 'package:stayfinder_vendor/presentation/screens/home_tab_bodies/tab_exports.dart';
import 'package:stayfinder_vendor/presentation/widgets/tab_bar_icon.dart';

import '../widgets/widgets_exports.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  List<Widget> tabs = [TabBar1(), TabBar2()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
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
                              style: TextStyle(
                                  fontFamily: 'Slackey', fontSize: 24),
                            ),
                            Text(
                              "finder",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hi Aaryan,",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "Good Morning",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w700),
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
                        Container(
                          height: 88,
                          width: 88,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(200),
                              border: Border.all(color: Colors.black),
                              image: DecorationImage(
                                  image: AssetImage(
                                    "assets/images/hanci_aaryan.jpg",
                                  ),
                                  fit: BoxFit.contain)),
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
            ),
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
                                    onTap: () => context
                                        .read<HomeTabbarCubit>()
                                        .firstElementClicked(),
                                    backgroundColor: firstElement
                                        ? Color(0xffC9C9C9)
                                        : Colors.white,
                                    iconColor: firstElement
                                        ? Color(0xff29383F)
                                        : Color(0xffCAD0E5),
                                    icon: Icons.apps_outlined,
                                  ),
                                  TabBarIcon(
                                    onTap: () => context
                                        .read<HomeTabbarCubit>()
                                        .secondElementClicked(),
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
