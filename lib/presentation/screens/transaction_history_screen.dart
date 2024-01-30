import 'package:stayfinder_vendor/presentation/widgets/widgets_exports.dart';

import '../../constants/constants_exports.dart';
import '../../logic/blocs/bloc_exports.dart';
import 'package:intl/intl.dart';

class TransactionHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: BlocConsumer<FetchTransactionHistoryBloc,
            FetchTransactionHistoryState>(
          listener: (context, state) {
            if (state is FetchTransactionHistoryError) {
              Navigator.pop(context);
              return customScaffold(
                  context: context,
                  title: "Error",
                  message: state.message,
                  contentType: ContentType.failure);
            }
          },
          builder: (context, transactionHistoryState) {
            if (transactionHistoryState is FetchTransactionHistoryLoading) {
              return CustomCircularBar(message: "Fetching payment history bro");
            }
            if (transactionHistoryState is FetchTransactionHistoryLoaded) {
              return Column(
                children: [
                  UpperBodyTransaction(),
                  Builder(builder: (context) {
                    var tierState = context.read<FetchTierBloc>().state;
                    if (tierState is FetchTierLoadedState) {
                      return Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                        margin: EdgeInsets.all(0.2),
                        child: Column(
                          children: [
                            ListView.builder(
                              itemCount: transactionHistoryState
                                  .transactionHistory.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5.0),
                                  child: ListTile(
                                      tileColor:
                                          Color(0xff29383f).withOpacity(0.3),
                                      dense: true,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      leading: CircleAvatar(
                                        child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl:
                                                "${getIpWithoutSlash()}${tierState.tierList[0].image!}"),
                                      ),
                                      title: Text(
                                          "${tierState.tierList.where((element) => element.id == transactionHistoryState.transactionHistory[index].tier).first.name}"),
                                      subtitle: Text(
                                          "${DateFormat('yyyy-MM-dd').format(DateTime.parse(transactionHistoryState.transactionHistory[index].paid_date!))}"),
                                      trailing: Text(
                                          "${transactionHistoryState.transactionHistory[index].paid_amount}")),
                                );
                              },
                            )
                          ],
                        ),
                      );
                    }
                    return SizedBox();
                  })
                ],
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}

class UpperBodyTransaction extends StatelessWidget {
  const UpperBodyTransaction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
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
                        style: TextStyle(fontFamily: 'Slackey', fontSize: 24),
                      ),
                      CustomPoppinsText(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        text: "finder",
                      )
                    ],
                  ),
                  CustomPoppinsText(
                      text: "Transactions",
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
                          if (fetchVendorState is FetchVendorProfileLoaded) {
                            return Container(
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
