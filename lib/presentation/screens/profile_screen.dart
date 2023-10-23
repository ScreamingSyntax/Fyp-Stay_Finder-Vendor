import 'package:flutter/cupertino.dart';
import 'package:stayfinder_vendor/presentation/widgets/widgets_exports.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Container(
            //   height: 350,
            //   child: Stack(
            //     children: [
            //       Container(
            //         width: MediaQuery.of(context).size.width,
            //         height: 200,
            //         decoration: BoxDecoration(
            //           color: Color(
            //             0xffDAD7CD,
            //           ),
            //         ),
            //       ),
            //       Positioned(
            //         // bottom: ,
            //         top: 80,
            //         child: Container(
            //           padding: EdgeInsets.symmetric(horizontal: 20),
            //           width: MediaQuery.of(context).size.width,
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               IconButton(
            //                 icon: Icon(Icons.arrow_back),
            //                 onPressed: () => Navigator.pop(context),
            //               ),
            //               // Text")
            //               Row(
            //                 children: [
            //                   Text("Account Status"),
            //                   SizedBox(
            //                     width: 10,
            //                   ),
            //                   Icon(Icons.verified)
            //                 ],
            //               ),
            //               // Icon(Icons.door_sliding)
            //               Text("")
            //             ],
            //           ),
            //         ),
            //       ),
            //       Positioned(
            //         bottom: 100,
            //         child: Column(
            //           children: [
            //             Container(
            //               width: MediaQuery.of(context).size.width,
            //               child: Row(
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 children: [
            //                   Container(
            //                     height: 108,
            //                     width: 108,
            //                     decoration: BoxDecoration(
            //                         borderRadius: BorderRadius.circular(200),
            //                         border: Border.all(color: Colors.black),
            //                         image: DecorationImage(
            //                             image: AssetImage(
            //                               "assets/images/hanci_aaryan.jpg",
            //                             ),
            //                             fit: BoxFit.contain)),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //       Positioned(
            //         bottom: 30,
            //         child: Container(
            //           width: MediaQuery.of(context).size.width,
            //           child: Column(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               Text(
            //                 "Aaryan Jha",
            //                 style: TextStyle(
            //                     color: Color(0xff29383F),
            //                     fontSize: 20,
            //                     fontWeight: FontWeight.w800),
            //               ),
            //               Text(
            //                 "whcloud91@gmail.com",
            //                 style: TextStyle(
            //                     color: Color(0xff9DA8C3),
            //                     fontSize: 12,
            //                     fontWeight: FontWeight.w600),
            //               ),
            //               Text(
            //                 "9745471881",
            //                 style: TextStyle(
            //                     color: Color(0xff9DA8C3),
            //                     fontSize: 12,
            //                     fontWeight: FontWeight.w600),
            //               ),
            //             ],
            //           ),
            //         ),
            //       )
            //     ],
            //   ),
            // ),
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
                            SizedBox(
                              width: 17,
                            ),
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
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.person_crop_circle,
                                    fill: 0.5,
                                    color: Color(0xff32454D),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Aaryan Jha",
                                    style: TextStyle(
                                        color: Color(0xff32454D),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.mail,
                                    fill: 0.5,
                                    color: Color(0xff32454D),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "whcloud91@gmail.com",
                                    style: TextStyle(
                                        color: Color(0xff32454D),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.verified_outlined,
                                    fill: 0.5,
                                    color: Color(0xff32454D),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Unverified",
                                    style: TextStyle(
                                        color: Color(0xff32454D),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () => Navigator.pushNamed(context, "/profile"),
                          child: Container(
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 27.0),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      CupertinoIcons.doc_checkmark_fill,
                      color: Color(0xff32454D).withOpacity(0.8),
                    ),
                    title: Text(
                      "My information",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff32454D).withOpacity(0.8),
                      ),
                    ),
                    subtitle: Text(
                      "View your personal information",
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xff32454D).withOpacity(0.8),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.door_back_door_rounded,
                      color: Color(0xff32454D).withOpacity(0.8),
                    ),
                    title: Text(
                      "Log out",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff32454D).withOpacity(0.8),
                      ),
                    ),
                    subtitle: Text(
                      "Log out from the system bro",
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xff32454D).withOpacity(0.8),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
