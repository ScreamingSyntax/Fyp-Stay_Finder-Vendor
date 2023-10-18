import 'package:flutter/material.dart';

class TabBarIcon extends StatelessWidget {
  final Color backgroundColor;
  final Color iconColor;
  final IconData icon;
  final Function() onTap;
  const TabBarIcon({
    super.key,
    required this.backgroundColor,
    required this.iconColor,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
          duration: Duration(seconds: 2),
          decoration: BoxDecoration(
              color: backgroundColor, borderRadius: BorderRadius.circular(11)),
          width: 40,
          height: 40,
          child: Icon(
            icon,
            color: iconColor,
          )),
    );
  }
}
