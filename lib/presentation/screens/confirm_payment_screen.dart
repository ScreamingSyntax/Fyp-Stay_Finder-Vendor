import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stayfinder_vendor/constants/ip.dart';
import '../../data/model/model_exports.dart';
import '../../logic/blocs/bloc_exports.dart';
import '../../logic/cubits/cubit_exports.dart';
import '../widgets/widgets_exports.dart';

class ConfirmPaymentScreen extends StatelessWidget {
  final Tier tier;
  final String checkOutDate;
  final int stayingMonths;

  ConfirmPaymentScreen({
    super.key,
    required this.tier,
    required this.checkOutDate,
    required this.stayingMonths,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Confirm Payment',
            style: TextStyle(color: Colors.black, fontSize: 12)),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(30),
        child: BlocBuilder<RadioListTileCubit, RadioListTileState>(
          builder: (_, radiolistTileState) {
            return ElevatedButton(
              onPressed: () {
                payWithKhaltiInApp(
                    paidAmount: (stayingMonths * int.parse(tier.price!)),
                    context: context,
                    tier: tier,
                    paidTill: checkOutDate);
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xff32454D),
                padding: EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                "Confirm Payment",
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CachedNetworkImage(
                          imageUrl: "${getIpWithoutSlash()}${tier.image}",
                          height: 100,
                          width: 100,
                        ),
                      ),
                      SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _InfoWithIcon(
                            icon: Icons.category,
                            title: "Tier",
                            value: tier.name!,
                          ),
                          _InfoWithIcon(
                            icon: Icons.attach_money,
                            title: "Price",
                            value: "Rs ${tier.price}",
                          ),
                        ],
                      ),
                      Divider(color: Colors.grey, height: 32),
                      Text(
                        "Details",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff29383F)),
                      ),
                      SizedBox(height: 8),
                      _DetailText(
                          icon: Boxicons.bx_crop,
                          label: "Staying for",
                          value: "${stayingMonths} months"),
                      _DetailText(
                          icon: FontAwesomeIcons.calendarDays,
                          label: "Checkout Date",
                          value: "$checkOutDate"),
                      _DetailText(
                          icon: Boxicons.bx_dollar,
                          label: "Total Price",
                          value:
                              "Rs ${stayingMonths * int.parse(tier.price!)}"),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              PaymentMethods(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _TierInfo({required String title, required String value}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xff29383F))),
        SizedBox(height: 8),
        Text(value, style: TextStyle(fontSize: 16, color: Color(0xff29383F))),
      ],
    );
  }
}

class PaymentMethods extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Payment Methods",
            style: TextStyle(
                fontSize: 16,
                color: Color(0xff29383F),
                fontWeight: FontWeight.bold)),
        SizedBox(height: 20),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _PaymentMethodCard(
                imageName: "assets/images/khalti_logo.png",
                label: "Khalti",
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _PaymentMethodCard(
      {required String imageName, required String label}) {
    return Container(
      width: 170,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Color(0xff29383F), width: 1),
      ),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Image.asset(imageName, width: 100, height: 60),
          Expanded(
            child: Text(label, style: TextStyle(color: Color(0xff29383F))),
          ),
        ],
      ),
    );
  }
}

Widget _InfoWithIcon(
    {required IconData icon, required String title, required String value}) {
  return Column(
    children: [
      Icon(icon, color: Color(0xff29383F)),
      SizedBox(height: 8),
      Text(title,
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xff29383F))),
      Text(value, style: TextStyle(fontSize: 14, color: Color(0xff29383F))),
    ],
  );
}

Widget _DetailText(
    {required String label, required String value, required IconData icon}) {
  return Padding(
    padding: const EdgeInsets.only(top: 4.0, bottom: 10),
    child: Row(
      children: [
        Icon(
          icon,
          size: 16,
        ),
        SizedBox(
          width: 20,
        ),
        Text("$label  ",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xff29383F))),
        Text(value, style: TextStyle(fontSize: 12, color: Color(0xff29383F))),
      ],
    ),
  );
}
