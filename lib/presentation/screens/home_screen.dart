import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:stayfinder_vendor/presentation/widgets/tab_bar_icon.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                            style:
                                TextStyle(fontFamily: 'Slackey', fontSize: 24),
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
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Your Plan and Accommodation",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  Container(
                    // color: Colors.black,
                    width: 100,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TabBarIcon(
                            backgroundColor: Color(0xffC9C9C9),
                            iconColor: Color(0xff29383F),
                            icon: Icons.apps_outlined,
                          ),
                          TabBarIcon(
                            backgroundColor: Colors.white,
                            iconColor: Color(0xffCAD0E5),
                            icon: Icons.more_horiz_rounded,
                          )
                        ]),
                  )
                ],
              )
            ],
          )
          // AnimationLimiter(
          //   child: Expanded(
          //     flex: 3,
          //     child: GridView.builder(
          //       shrinkWrap: true,
          //       // scrollDirection: Axis. ,

          //       itemCount: 100,
          //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //           crossAxisCount: 2),
          //       itemBuilder: (context, index) {
          //         return AnimationConfiguration.staggeredGrid(
          //           position: index,
          //           columnCount: 2,
          //           duration: Duration(seconds: 2),
          //           child: SlideAnimation( // One for whole List
          //             // verticalOffset: 100,
          //             duration: Duration(seconds: 1),
          //             child: SlideAnimation( // Other for particular items
          //               delay: Duration(seconds: 1),
          //               child: Padding(
          //                 padding: EdgeInsets.symmetric(horizontal: 10),
          //                 child: SizedBox(
          //                   height: 170,
          //                   child: Card(
          //                     elevation: 2,
          //                     surfaceTintColor: Colors.orange,
          //                     shadowColor: Colors.red,
          //                     color: Colors.lightGreen,
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ),
          //         );
          //       },
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
