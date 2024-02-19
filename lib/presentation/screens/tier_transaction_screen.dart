import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stayfinder_vendor/data/model/model_exports.dart';
import 'package:stayfinder_vendor/presentation/screens/confirm_payment_screen.dart';
import 'package:stayfinder_vendor/presentation/widgets/widgets_exports.dart';
import '../../constants/constants_exports.dart';

class TierTransactionScreen extends StatelessWidget {
  final Tier tier;

  TierTransactionScreen({super.key, required this.tier});

  final _formKey = GlobalKey<FormState>();

  TextEditingController _monthsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Transaction Details",
          style: TextStyle(fontSize: 12),
        ),
        // backgroundColor: Color(0xff514f53),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                CachedNetworkImage(
                  imageUrl: "${getIpWithoutSlash()}${tier.image}",
                  height: 200,
                  width: 200,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                SizedBox(
                  height: 40,
                ),
                ListTile(
                  title: CustomPoppinsText(
                      text: "${tier.name}",
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                  subtitle: CustomPoppinsText(
                      text: "${tier.price} per month",
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                  trailing: Icon(FontAwesomeIcons.moneyBillWave,
                      color: Colors.green[800]),
                ),
                ListTile(
                  title: CustomPoppinsText(
                      text: "Accommodations Limit",
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                  subtitle: CustomPoppinsText(
                      text: "${tier.accomodationLimit}",
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                  trailing:
                      Icon(FontAwesomeIcons.house, color: Colors.green[800]),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
                  child: TextFormField(
                    controller: _monthsController,
                    decoration: InputDecoration(
                      isDense: true,
                      labelText: "Months to Pay For",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.calendar_today),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a number of months';
                      }
                      if (int.parse(value) <= 0) {
                        return "Cannot buy tier for ${value} months";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 14),
                  child: CustomMaterialButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          String calculation = calculateDateFromMonths(
                              DateTime.now().toString(),
                              int.parse(_monthsController.text));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ConfirmPaymentScreen(
                                      tier: tier,
                                      checkOutDate: calculation,
                                      stayingMonths:
                                          int.parse(_monthsController.text))));
                          // print("This is the calculation ${calculation}");
                        }
                      },
                      child: Text("Confirm Payment"),
                      backgroundColor: Color(0xff514f53),
                      textColor: Colors.white,
                      height: 50),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
