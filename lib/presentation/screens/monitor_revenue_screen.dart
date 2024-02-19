// import 'fl_cha÷';

import 'package:stayfinder_vendor/data/model/success_model.dart';
import 'package:stayfinder_vendor/presentation/widgets/widgets_exports.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../constants/ip.dart';
import '../../logic/blocs/bloc_exports.dart';
import '../../logic/cubits/cubit_exports.dart';

class MonitorRevenueScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<FetchRevenueDataCubit, FetchRevenueDataState>(
        builder: (context, state) {
          if (state is FetchRevenueDataLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is FetchRevenueDataError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(state.message),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: CustomMaterialButton(
                        onPressed: () {},
                        child: Text("Retry"),
                        backgroundColor: Color(0xff546464),
                        textColor: Colors.white,
                        height: 40),
                  )
                ],
              ),
            );
          }
          if (state is FetchRevenueDataSuccess) {
            final data = state.success.data;
            return SingleChildScrollView(
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 65,
                            child: CustomMaterialButton(
                                onPressed: () {
                                  filterRevenueStatus(context, 'daily');
                                },
                                child: Text(
                                  "Today",
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                                backgroundColor: Colors.white,
                                textColor: Colors.black.withOpacity(0.7),
                                height: 35),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 67,
                            child: CustomMaterialButton(
                                onPressed: () {
                                  filterRevenueStatus(context, 'weekly');
                                },
                                child: Text(
                                  "7 days",
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                                backgroundColor: Colors.white,
                                textColor: Colors.black.withOpacity(0.7),
                                height: 35),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 75,
                            child: CustomMaterialButton(
                                onPressed: () {
                                  filterRevenueStatus(context, 'monthly');
                                },
                                child: Text(
                                  "1 month",
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                                backgroundColor: Colors.white,
                                textColor: Colors.black.withOpacity(0.7),
                                height: 35),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 70,
                            child: CustomMaterialButton(
                                onPressed: () {
                                  filterRevenueStatus(context, 'yearly');
                                },
                                child: Text(
                                  "1 Year",
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                                backgroundColor: Colors.white,
                                textColor: Colors.black.withOpacity(0.7),
                                height: 35),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  // UpperBodyRevenue(), // Assuming this is styled appropriately elsewhere
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.monetization_on,
                              color: Colors
                                  .green[600]), // Updated color for clarity
                          title: Text(
                            'Total Revenue',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold), // Slightly bolder
                          ),
                          subtitle: Text(
                            '${data!['total_revenue']}',
                            style: TextStyle(
                                fontSize: 12), // Increased size for readability
                          ),
                        ),
                        Divider(
                            height: 32.0,
                            thickness: 1.0,
                            color: Colors
                                .grey[300]), // Added for visual separation
                        ListTile(
                          leading: Icon(Icons.trending_up,
                              color: Colors
                                  .blue[600]), // Updated color for distinction
                          title: Text(
                            'Average Revenue Per Booking',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            '${data['average_revenue_per_booking']}',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        Divider(
                            height: 32.0,
                            thickness: 1.0,
                            color: Colors.grey[300]),
                        Divider(
                            height: 32.0,
                            thickness: 1.0,
                            color: Colors.grey[300]),
                        Container(
                          height: 390,
                          child: DefaultTabController(
                            length: 2,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 50,
                                ),
                                TabBar(
                                  labelColor: Colors.black,
                                  tabs: [
                                    Tab(text: 'Pie Chart'),
                                    Tab(text: 'Bar Graph'),
                                  ],
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                                Expanded(
                                  child: TabBarView(
                                    // viewportFraction: ,
                                    physics: NeverScrollableScrollPhysics(),
                                    children: [
                                      DynamicPieChart(
                                          revenueByAccommodation:
                                              data['revenue_by_accommodation']),
                                      DynamicBarChart(
                                          revenueByAccommodation:
                                              data['revenue_by_accommodation']),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                            height: 32.0,
                            thickness: 1.0,
                            color: Colors.grey[
                                300]), // Visual separation inside container
                        ...data['revenue_by_accommodation']
                            .map<Widget>((accommodation) => ListTile(
                                  leading: Icon(Icons.hotel,
                                      color: Colors.purple[
                                          600]), // Updated color for visual interest
                                  title: Text(
                                      '${accommodation['room__accommodation__name']}',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold)),
                                  subtitle: Text(
                                      '${accommodation['total_revenue']}',
                                      style: TextStyle(fontSize: 12)),
                                ))
                            .toList(),
                        SizedBox(
                          height: 50,
                        ),
                        // Container(
                        //   decoration: BoxDecoration(
                        //     color: Colors
                        //         .grey[100], // Lighter color for a clean look
                        //     borderRadius: BorderRadius.circular(
                        //         8), // Rounded corners for modern appearance
                        //   ),
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(16.0),
                        //     child: Column(
                        //       children: [
                        //         SizedBox(
                        //             height: 200,
                        //             child: DynamicPieChart(
                        //                 revenueByAccommodation:
                        //                     data['revenue_by_accommodation'])),
                        //         Divider(
                        //             height: 32.0,
                        //             thickness: 1.0,
                        //             color: Colors.grey[
                        //                 300]), // Visual separation inside container
                        //         ...data['revenue_by_accommodation']
                        //             .map<Widget>((accommodation) => ListTile(
                        //                   leading: Icon(Icons.hotel,
                        //                       color: Colors.purple[
                        //                           600]), // Updated color for visual interest
                        //                   title: Text(
                        //                       '${accommodation['room__accommodation__name']}',
                        //                       style: TextStyle(
                        //                           fontSize: 12,
                        //                           fontWeight: FontWeight.bold)),
                        //                   subtitle: Text(
                        //                       '${accommodation['total_revenue']}',
                        //                       style: TextStyle(fontSize: 12)),
                        //                 ))
                        //             .toList(),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // Divider(
                        //     height: 32.0,
                        //     thickness: 1.0,
                        //     color: Colors.grey[
                        //         300]), // Visual separation before the next chart
                        // Text(
                        //   'Revenue by Accommodation (Bar Chart)',
                        //   style: TextStyle(
                        //       fontSize: 12, fontWeight: FontWeight.bold),
                        // ),
                        // SizedBox(
                        //   height: 300,
                        //   child: DynamicBarChart(
                        //       revenueByAccommodation:
                        //           data['revenue_by_accommodation']),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return Column(
            children: [
              // UpperBodyRevenue(),
            ],
          );
        },
      ),
    );
  }

  void filterRevenueStatus(BuildContext context, String sortStatus) {
    var loginState = context.read<LoginBloc>().state;
    if (loginState is LoginLoaded) {
      context.read<FetchRevenueDataCubit>()
        ..getRevenue(token: loginState.successModel.token!, period: sortStatus);
    }
  }
}

// class DynamicBarChart extends StatelessWidget {
//   final List<dynamic> revenueByAccommodation;

//   DynamicBarChart({Key? key, required this.revenueByAccommodation})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     List<BarChartGroupData> barGroups = [];
//     for (var i = 0; i < revenueByAccommodation.length; i++) {
//       var accommodation = revenueByAccommodation[i];
//       barGroups.add(
//         BarChartGroupData(
//           x: i,
//           barRods: [
//             BarChartRodData(
//               y: accommodation['total_revenue'] as double,
//               colors: [Color(0xFF546E7A)], // Consistent muted blue for bars
//               borderRadius: BorderRadius.circular(4),
//             ),
//           ],
//           showingTooltipIndicators: [0],
//         ),
//       );
//     }

//     return BarChart(
//       BarChartData(
//         barGroups: barGroups,
//         titlesData: FlTitlesData(
//           bottomTitles: SideTitles(
//             showTitles: true,
//             getTextStyles: (context, value) => const TextStyle(
//               fontSize: 9, // Further reduced font size for subtlety
//               color: Color(0xFF78909C), // Soft gray-blue for text
//             ),
//             margin: 8,
//             getTitles: (double value) {
//               return revenueByAccommodation[value.toInt()]
//                   ['room__accommodation__name'];
//             },
//           ),
//           leftTitles: SideTitles(
//             showTitles: true,
//             getTextStyles: (context, value) => const TextStyle(
//               fontSize: 9,
//               color: Color(0xFF78909C),
//             ),
//             margin: 5,
//             reservedSize: 28, // Ensure enough space for the smaller text
//           ),
//         ),
//         borderData: FlBorderData(
//           show: true,
//           border: Border.all(
//               color: Color(0xFFB0BEC5),
//               width: 0.5), // Lighter gray for a soft border
//         ),
//         gridData: FlGridData(
//           show: true,
//           drawVerticalLine: false,
//           horizontalInterval: 1,
//           getDrawingHorizontalLine: (value) => FlLine(
//             color: Color(0xFFB0BEC5),
//             strokeWidth: 0.5,
//           ),
//         ),
//         barTouchData: BarTouchData(
//           enabled: false, // Optional based on whether interaction is desired
//         ),
//       ),
//     );
//   }
// }

// class UpperBodyRevenue extends StatelessWidget {
//   const UpperBodyRevenue({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 170,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           SafeArea(
//             child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Text(
//                         "Stay",
//                         style: TextStyle(fontFamily: 'Slackey', fontSize: 24),
//                       ),
//                       CustomPoppinsText(
//                         fontSize: 22,
//                         fontWeight: FontWeight.w500,
//                         text: "finder",
//                       )
//                     ],
//                   ),
//                   CustomPoppinsText(
//                       text: "Revenue",
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500),
//                 ]),
//           ),
//           SafeArea(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 BlocBuilder<LoginBloc, LoginState>(
//                   builder: (context, state) {
//                     return InkWell(
//                       onTap: () {
//                         Navigator.pushNamed(context, "/profile");
//                       },
//                       child: BlocBuilder<FetchVendorProfileBloc,
//                           FetchVendorProfileState>(
//                         builder: (context, fetchVendorState) {
//                           if (fetchVendorState is FetchVendorProfileLoaded) {
//                             return Container(
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(200),
//                                   border: Border.all(
//                                       width: 2, color: Colors.black)),
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(200),
//                                 child: CachedNetworkImage(
//                                     width: 66,
//                                     height: 66,
//                                     fit: BoxFit.fill,
//                                     imageUrl:
//                                         "${getIpWithoutSlash()}${fetchVendorState.vendorProfile.profile_picture}"),
//                               ),
//                             );
//                           }
//                           return SizedBox();
//                         },
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//       margin: EdgeInsets.all(0.2),
//       decoration: BoxDecoration(
//           color: Color(0xffDAD7CD),
//           border: Border.all(
//             color: Color(
//               0xff29383F,
//             ),
//           ),
//           borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(
//                 50,
//               ),
//               bottomRight: Radius.circular(50))),
//     );
//   }
// }

class DynamicPieChart extends StatelessWidget {
  final List<dynamic>
      revenueByAccommodation; // Assume this comes from your JSON

  DynamicPieChart({Key? key, required this.revenueByAccommodation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<PieChartSectionData> sections =
        revenueByAccommodation.map((accommodation) {
      return PieChartSectionData(
        value: accommodation['total_revenue'] as double,
        title: accommodation['room__accommodation__name'],
        color: Colors.primaries[revenueByAccommodation.indexOf(accommodation) %
            Colors.primaries.length],
        radius: 50,
      );
    }).toList();

    return PieChart(
      PieChartData(sections: sections),
    );
  }
}

class DynamicBarChart extends StatelessWidget {
  final List<dynamic> revenueByAccommodation;

  DynamicBarChart({Key? key, required this.revenueByAccommodation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<BarChartGroupData> barGroups = [];
    for (var i = 0; i < revenueByAccommodation.length; i++) {
      var accommodation = revenueByAccommodation[i];
      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              y: accommodation['total_revenue'] as double,
              colors: [
                i % 2 == 0 ? Color(0xFF4CAF50) : Color(0xFF2196F3)
              ], // Alternating colors for bars
              borderRadius: BorderRadius.circular(4),
            ),
          ],
          showingTooltipIndicators: [0],
        ),
      );
    }

    return BarChart(
      BarChartData(
        barGroups: barGroups,
        titlesData: FlTitlesData(
          bottomTitles: SideTitles(
            showTitles: true,
            getTextStyles: (context, value) => const TextStyle(
              fontSize: 10,
              color: Color(0xFF616161), // Gray for text for readability
            ),
            margin: 10,
            getTitles: (double value) {
              return revenueByAccommodation[value.toInt()]
                  ['room__accommodation__name'];
            },
          ),
          leftTitles: SideTitles(
            showTitles: true,
            getTextStyles: (context, value) => const TextStyle(
              fontSize: 10,
              color: Color(0xFF616161),
            ),
            margin: 8,
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(
              color: Color(0xFFE0E0E0),
              width: 1), // Light gray border for subtle definition
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 1,
          getDrawingHorizontalLine: (value) => FlLine(
            color: Color(0xFFE0E0E0),
            strokeWidth: 1,
          ),
        ),
        barTouchData: BarTouchData(
          enabled: false,
        ),
      ),
    );
  }
}
