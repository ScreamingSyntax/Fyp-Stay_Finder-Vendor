import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    HomeScreen(),
    ChatScreen(),
    NotificationScreen(),
  ];
}
