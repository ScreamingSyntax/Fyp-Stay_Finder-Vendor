import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:stayfinder_vendor/constants/ip.dart';
import 'package:stayfinder_vendor/presentation/widgets/widgets_exports.dart';

import '../../logic/blocs/bloc_exports.dart';

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
            BlocBuilder<FetchVendorProfileBloc, FetchVendorProfileState>(
              builder: (context, fetchVendorState) {
                if (fetchVendorState is FetchVendorProfileLoaded) {
                  return UppBody(
                    fetchVendorState: fetchVendorState,
                  );
                }
                return UppBodyTemplate();
              },
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 27.0),
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      var state = context.read<LoginBloc>().state;
                      if (state is LoginLoaded) {
                        context.read<FetchVendorProfileBloc>()
                          ..add(HitFetchVendorProfileEvent(
                              token: state.successModel.token!));
                        Navigator.pushNamed(context, "/info");
                      }
                      context
                          .read<DocumentDetailDartBloc>()
                          .add(DocumentDataClearEvent());
                    },
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
                    onTap: () {},
                    leading: Icon(
                      CupertinoIcons.lock_fill,
                      color: Color(0xff32454D).withOpacity(0.8),
                    ),
                    title: Text(
                      "Reset Password",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff32454D).withOpacity(0.8),
                      ),
                    ),
                    subtitle: Text(
                      "Do you want to change your password?",
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xff32454D).withOpacity(0.8),
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      context.read<LoginBloc>().add(LoginClearEvent());
                      Navigator.pushNamed(context, "/login");
                    },
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

class UppBody extends StatelessWidget {
  final FetchVendorProfileLoaded fetchVendorState;
  const UppBody({
    super.key,
    required this.fetchVendorState,
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
                    SizedBox(
                      width: 17,
                    ),
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
                          BlocBuilder<VendorDataProviderBloc,
                              VendorDataProviderState>(
                            builder: (context, state) {
                              if (state is VendorLoaded) {
                                return Text(
                                  "${state.vendorModel.fullName}",
                                  style: TextStyle(
                                      color: Color(0xff32454D),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                );
                              }
                              return SizedBox();
                            },
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
                          BlocBuilder<VendorDataProviderBloc,
                              VendorDataProviderState>(
                            builder: (context, state) {
                              if (state is VendorLoaded) {
                                return Text(
                                  "${state.vendorModel.email}",
                                  style: TextStyle(
                                      color: Color(0xff32454D),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                );
                              }
                              return SizedBox();
                            },
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
                            fetchVendorState.vendorProfile.is_verified == 'True'
                                ? "Verified"
                                : "Unverifed",
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
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200),
                      border: Border.all(width: 2, color: Colors.black)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(200),
                    child: CachedNetworkImage(
                        width: 88,
                        height: 88,
                        fit: BoxFit.fill,
                        imageUrl:
                            "${getIp()}${fetchVendorState.vendorProfile.profile_picture}"),
                  ),
                )
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

class UppBodyTemplate extends StatelessWidget {
  const UppBodyTemplate({
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
                    SizedBox(
                      width: 17,
                    ),
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
                            "Loading",
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
                            "Loading",
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
                            "Loading",
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
    );
  }
}
