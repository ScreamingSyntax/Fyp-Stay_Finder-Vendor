import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stayfinder_vendor/logic/cubits/home_tab_bar/home_tabbar_cubit.dart';

import '../presentation/screens/screen_exports.dart';

List<Widget> getNavBarItems() {
  return <Widget>[
    Icon(Icons.home_outlined, size: 30),
    Icon(CupertinoIcons.chat_bubble, size: 30),
    Icon(CupertinoIcons.bell, size: 30),
  ];
}

List<Widget> getNavBarBody() {
  return <Widget>[
    BlocProvider(
      create: (_) => HomeTabbarCubit(),
      child: HomeScreen(),
    ),
    ChatScreen(),
    NotificationScreen(),
  ];
}
