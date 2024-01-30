import 'package:stayfinder_vendor/logic/cubits/cubit_exports.dart';
import 'package:stayfinder_vendor/presentation/screens/confirm_payment_screen.dart';
import 'package:stayfinder_vendor/presentation/widgets/widgets_exports.dart';

import '../../constants/constants_exports.dart';
import '../../logic/blocs/bloc_exports.dart';

class RenewSubscriptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8.0),
        child: BlocBuilder<RadioListTileCubit, RadioListTileState>(
          builder: (_, radiolistTileState) {
            return CustomMaterialButton(
                onPressed: () {
                  // payWithKhaltiInApp(
                  //     context: context, tier: radiolistTileState.currentValue!);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ConfirmPaymentScreen(
                              tier: radiolistTileState.currentValue!)));
                },
                child: Text("Continue to Payment"),
                backgroundColor: Color(0xff32454D),
                textColor: Colors.white,
                height: 50);
          },
        ),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            UpperRenewSubscriptionBody(),
            BlocBuilder<FetchTierBloc, FetchTierState>(
              builder: (context, fetchTierState) {
                if (fetchTierState is FetchTierLoadedState) {
                  context
                      .read<RadioListTileCubit>()
                      .instantiateOptionList(option: fetchTierState.tierList);
                  return BlocBuilder<RadioListTileCubit, RadioListTileState>(
                    builder: (context, radioState) {
                      print(radioState.currentValue);
                      print(radioState.groupValue);
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: radioState.groupValue!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  shape: BeveledRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  leading: CircleAvatar(
                                    child: CachedNetworkImage(
                                      width: 100,
                                      height: 100,
                                      imageUrl:
                                          "${getIpWithoutSlash()}${radioState.groupValue![index].image}",
                                    ),
                                  ),
                                  title: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: CustomPoppinsText(
                                      text:
                                          "${radioState.groupValue![index].name!}",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff32454D).withOpacity(0.8),
                                      // color: Colors.blue, // Example text color
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: CustomPoppinsText(
                                      text:
                                          "${radioState.groupValue![index].description!} at only ${radioState.groupValue![index].price} Rupee.",
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xff32454D).withOpacity(0.8),
                                    ),
                                  ),
                                  trailing: Radio(
                                    fillColor: MaterialStatePropertyAll(
                                      Color(0xff32454D).withOpacity(0.8),
                                    ),
                                    overlayColor: MaterialStatePropertyAll(
                                      Color(0xff32454D).withOpacity(0.8),
                                    ),
                                    // value: radioState.currentValue,
                                    value: radioState.groupValue![index],

                                    groupValue: radioState.currentValue,
                                    onChanged: (value) {
                                      if (value == radioState.groupValue![0]) {
                                        return customScaffold(
                                            context: context,
                                            title: "Unavailable",
                                            message:
                                                "Free tier is only available for a month after you join stayfinder",
                                            contentType: ContentType.warning);
                                      }
                                      context
                                          .read<RadioListTileCubit>()
                                          .changeCurrentOption(
                                              option: value!,
                                              optionList:
                                                  radioState.groupValue!);
                                    },
                                    activeColor: Color(0xffDAD7CD),
                                  ),
                                ),
                              );
                            },
                          ),

                          // SizedBox(
                          //   height: 10,
                          // ),
                          //
                        ],
                      );
                    },
                  );
                }
                if (fetchTierState is FetchTierInitialState) {
                  var loginState = context.read<LoginBloc>().state;
                  if (loginState is LoginLoaded) {
                    context.read<FetchTierBloc>().add(FetchTierHitEvent(
                        token: loginState.successModel.token!));
                  }
                  return CustomCircularBar(message: "Loading Please Wait");
                }
                return SizedBox();
              },
            )
          ],
        ),
      ),
    );
  }
}

class UpperRenewSubscriptionBody extends StatelessWidget {
  const UpperRenewSubscriptionBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270,
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
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
                          CustomPoppinsText(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            text: "finder",
                          )
                        ],
                      ),
                      CustomPoppinsText(
                          text: "Renew Subscription",
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ]),
              ),
              SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "/profile");
                          },
                          child: BlocBuilder<FetchVendorProfileBloc,
                              FetchVendorProfileState>(
                            builder: (context, fetchVendorState) {
                              if (fetchVendorState
                                  is FetchVendorProfileLoaded) {
                                return Container(
                                  margin: EdgeInsets.symmetric(vertical: 3),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(200),
                                      border: Border.all(
                                          width: 2, color: Colors.black)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(200),
                                    child: CachedNetworkImage(
                                        width: 88,
                                        height: 88,
                                        fit: BoxFit.fill,
                                        imageUrl:
                                            "${getIpWithoutSlash()}${fetchVendorState.vendorProfile.profile_picture}"),
                                  ),
                                );
                              }
                              return SizedBox();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
          Container(
            height: 100,
            // color: Colors.black,
            child: BlocBuilder<FetchTransactionHistoryBloc,
                FetchTransactionHistoryState>(
              builder: (context, fetchTransactionState) {
                if (fetchTransactionState is FetchTransactionHistoryLoading) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                      ],
                    ),
                  );
                }
                if (fetchTransactionState is FetchTransactionHistoryLoaded) {
                  double sumTotalMoney() {
                    double sum = 0;
                    fetchTransactionState.transactionHistory.forEach((element) {
                      sum += double.parse(element.paid_amount!);
                    });
                    return sum;
                  }

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomPoppinsText(
                            text: "Last Month",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(
                              0xff29383F,
                            ),
                          ),
                          CustomPoppinsText(
                              text:
                                  "Rs ${fetchTransactionState.transactionHistory.last.paid_amount!}",
                              fontSize: 14,
                              fontWeight: FontWeight.w300),
                        ],
                      ),
                      Container(
                        height: 20,
                        child: VerticalDivider(
                          color: Color(
                            0xff29383F,
                          ),
                          thickness: 1,
                          width: 1,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomPoppinsText(
                            text: "Total Paid",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(
                              0xff29383F,
                            ),
                          ),
                          CustomPoppinsText(
                              text: "Rs ${sumTotalMoney()}",
                              fontSize: 14,
                              fontWeight: FontWeight.w300),
                          // Divider()
                        ],
                      ),
                    ],
                  );
                }
                return SizedBox();
              },
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
