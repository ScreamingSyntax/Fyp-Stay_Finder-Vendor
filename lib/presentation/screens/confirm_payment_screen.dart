import 'package:stayfinder_vendor/constants/ip.dart';

import '../../data/model/model_exports.dart';
import '../../logic/blocs/bloc_exports.dart';
import '../../logic/cubits/cubit_exports.dart';
import '../widgets/widgets_exports.dart';

class ConfirmPaymentScreen extends StatelessWidget {
  final Tier tier;

  const ConfirmPaymentScreen({super.key, required this.tier});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8.0),
        child: BlocBuilder<RadioListTileCubit, RadioListTileState>(
          builder: (_, radiolistTileState) {
            return CustomMaterialButton(
                onPressed: () {
                  payWithKhaltiInApp(context: context, tier: this.tier);
                },
                child: Text("Confirm Payment"),
                backgroundColor: Color(0xff32454D),
                textColor: Colors.white,
                height: 50);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            SafeArea(
              child: Container(
                height: 220,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        color: Color(
                          0xff29383F,
                        ),
                        width: 1)),
                // color: Colors.green,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CachedNetworkImage(
                        imageUrl: "${getIp()}${tier.image}",
                        height: 100,
                        width: 100,
                      ),
                    ),
                    Expanded(
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            width: MediaQuery.of(context).size.width / 2.3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomPoppinsText(
                                    text: "Tier",
                                    fontSize: 20,
                                    color: Color(
                                      0xff29383F,
                                    ),
                                    fontWeight: FontWeight.w600),
                                CustomPoppinsText(
                                    text: "${tier.name!}",
                                    fontSize: 16,
                                    color: Color(
                                      0xff29383F,
                                    ),
                                    fontWeight: FontWeight.w400),
                                Text("")
                              ],
                            ),
                          ),
                          Container(
                            height: 50,
                            child: VerticalDivider(
                              color: Colors.black,
                              thickness: 1,
                              width: 2,
                            ),
                          ),
                          Container(
                              // color: Colors.green,
                              padding: EdgeInsets.symmetric(vertical: 12),
                              width: MediaQuery.of(context).size.width / 2.3,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomPoppinsText(
                                      text: "Price",
                                      fontSize: 20,
                                      color: Color(
                                        0xff29383F,
                                      ),
                                      fontWeight: FontWeight.w600),
                                  CustomPoppinsText(
                                      text: "Rs ${tier.price!}",
                                      fontSize: 16,
                                      color: Color(
                                        0xff29383F,
                                      ),
                                      fontWeight: FontWeight.w400),
                                  // SizedBox()
                                  Text("")
                                ],
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                  activeColor: Color(
                    0xff29383F,
                  ),
                  value: true,
                  toggleable: false,
                  splashRadius: 0,
                  groupValue: true,
                  onChanged: (value) {},
                )
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomPoppinsText(
                      text: "Payment Methods",
                      fontSize: 16,
                      color: Color(
                        0xff29383F,
                      ),
                      fontWeight: FontWeight.w400),
                  SizedBox(
                    height: 30,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          width: 170,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: Color(
                                    0xff29383F,
                                  ),
                                  width: 1)),
                          child: Row(
                            children: [
                              Container(
                                width: 110,
                                height: 60,
                                child: Image.asset(
                                    "assets/images/khalti_logo.png"),
                              ),
                              Radio(
                                activeColor: Color(
                                  0xff29383F,
                                ),
                                value: true,
                                toggleable: false,
                                splashRadius: 0,
                                groupValue: true,
                                onChanged: (value) {},
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: 170,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: Color(
                                    0xff29383F,
                                  ),
                                  width: 1)),
                          child: Row(
                            children: [
                              Container(
                                  width: 166,
                                  height: 60,
                                  // color: Colors.amber,
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text("Coming soon"),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
