import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stayfinder_vendor/constants/constants_exports.dart';
import 'package:stayfinder_vendor/logic/cubits/nav_bar_index/nav_bar_index_cubit.dart';

import '../widgets/widgets_exports.dart';

class NavBarMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitPopup(
          context: context,
          message: "Are you sure you want to exit?",
          title: "Exit",
          noBtnFunction: () => Navigator.pop(context),
          yesBtnFunction: () => SystemNavigator.pop()),
      child: Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          index: context.watch<NavBarIndexCubit>().state.index,
          backgroundColor: Colors.transparent,
          color: Color(0xffdff7e6),
          items: getNavBarItems(),
          onTap: (index) {
            context.read<NavBarIndexCubit>().changeIndex(index);
          },
        ),
        body: BlocBuilder<NavBarIndexCubit, NavBarIndexState>(
          builder: (context, state) {
            return getNavBarBody()[state.index];
          },
        ),
      ),
    );
  }
}
