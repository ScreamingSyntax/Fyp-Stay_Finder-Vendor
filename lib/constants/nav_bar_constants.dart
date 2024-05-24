import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stayfinder_vendor/logic/cubits/home_tab_bar/home_tabbar_cubit.dart';
import 'package:stayfinder_vendor/presentation/screens/bookings_screen.dart';

import '../presentation/screens/screen_exports.dart';

List<Widget> getNavBarItems() {
  return <Widget>[
    Icon(
      Icons.home_outlined,
      size: 30,
      color: Color(0xff64FFDA),
    ),
    Icon(
      CupertinoIcons.chat_bubble,
      size: 30,
      color: Color(0xff64FFDA),
    ),
    Icon(
      CupertinoIcons.arrow_right_arrow_left_square,
      size: 30,
      color: Color(0xff64FFDA),
    ),
    Icon(
      CupertinoIcons.bell,
      size: 30,
      color: Color(0xff64FFDA),
    ),
  ];
}

List<Widget> getNavBarBody() {
  return <Widget>[
    BlocProvider(
      create: (_) => HomeTabbarCubit(),
      child: HomeScreen(),
    ),
    ChatScreen(),
    BookingScreen(),
    NotificationScreen(),
  ];
}

List<Widget> offLineNavBarBody() {
  return <Widget>[
    NoConnectionScreen(),
    NoConnectionScreen(),
    NoConnectionScreen(),
    NoConnectionScreen(),
  ];
}
