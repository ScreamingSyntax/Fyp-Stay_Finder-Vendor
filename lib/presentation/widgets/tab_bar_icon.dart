import 'package:flutter/material.dart';

class TabBarIcon extends StatelessWidget {
  final Color backgroundColor;
  final Color iconColor;
  final IconData icon;
  const TabBarIcon({
    super.key,
    required this.backgroundColor,
    required this.iconColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: backgroundColor, borderRadius: BorderRadius.circular(11)),
        width: 40,
        height: 40,
        child: Icon(
          icon,
          color: iconColor,
        ));
  }
}
