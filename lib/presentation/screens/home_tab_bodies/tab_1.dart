// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: must_be_immutable

import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

import 'package:stayfinder_vendor/data/model/model_exports.dart';
import 'package:stayfinder_vendor/logic/blocs/fetch_current_tier/fetch_current_tier_bloc.dart';
import 'package:stayfinder_vendor/logic/cubits/drop_down_value/drop_down_value_cubit.dart';

import '../../../constants/constants_exports.dart';
import '../../../logic/blocs/accommodation_addition/accommodation_addition_bloc.dart';
import '../../../logic/blocs/bloc_exports.dart';
import '../../../logic/blocs/fetch_added_accommodations/fetch_added_accommodations_bloc.dart';
import '../../widgets/widgets_exports.dart';

class TabBar1 extends StatelessWidget {
  const TabBar1({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.1,
      child: AnimationLimiter(
          child: AnimationConfiguration.staggeredList(
        position: 1,
        child: SlideAnimation(
          curve: Curves.easeInOut,
          duration: Duration(milliseconds: 500),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              BlocListener<FetchCurrentTierBloc, FetchCurrentTierState>(
                listener: (context, fetchTierState) {
                  if (fetchTierState is FetchCurrentTierError) {
                    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                      content: Text(fetchTierState.message),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      margin: EdgeInsets.only(
                          // bottom: MediaQuery.0,
                          bottom: 30,
                          right: 20,
                          left: 20),
                    ));
                  }
                },
                child: UpperHomeBody(),
              ),
              BlocBuilder<FetchCurrentTierBloc, FetchCurrentTierState>(
                builder: (context, currentTier) {
                  return BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      if (state is LoginLoaded) {
                        return MiddleHomeBody(loginState: state);
                      }
                      return SizedBox();
                    },
                  );
                },
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      )),
    );
  }
}

class MiddleHomeBody extends StatelessWidget {
  final LoginLoaded loginState;
  const MiddleHomeBody({super.key, required this.loginState});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7.2, vertical: 30),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomPoppinsText(
            text: "Your accomodations",
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          SizedBox(
            height: 10,
          ),
          BlocBuilder<FetchAddedAccommodationsBloc,
              FetchAddedAccommodationsState>(
            builder: (context, state) {
              if (state is FetchAddedAccommodationsLoaded) {
                bool verified = checkVerification(context, loginState);
                if (verified) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      height: 200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ListView.builder(
                            itemCount: state.accommodation.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                width: 157,
                                height: 197,
                                child: Card(
                                  elevation: 0,
                                  surfaceTintColor: Colors.white,
                                  shadowColor: Colors.white,
                                  color: Color(0xffdbd3cb),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: CachedNetworkImage(
                                            imageBuilder:
                                                (context, imageProvider) {
                                              return Container(
                                                width: 135,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(5),
                                                            topRight:
                                                                Radius.circular(
                                                                    5)),
                                                    image: DecorationImage(
                                                        alignment:
                                                            Alignment.center,
                                                        image: imageProvider,
                                                        fit: BoxFit.cover)),
                                              );
                                            },
                                            width: 167,
                                            fit: BoxFit.cover,
                                            alignment: Alignment.center,
                                            imageUrl:
                                                "${getIp()}${state.accommodation[index].image.toString()}",
                                            height: 95,
                                            placeholder: (context, url) =>
                                                CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CustomPoppinsText(
                                            text: state
                                                .accommodation[index].name
                                                .toString(),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700),
                                        // Text(
                                        //   state.accommodation[index].name
                                        //       .toString(),
                                        //   style: TextStyle(
                                        //       fontWeight: FontWeight.w700,
                                        //       fontSize: 12),
                                        // ),
                                        Expanded(
                                          child: Text(
                                            state.accommodation[index].address
                                                .toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff9DA8C3),
                                                fontSize: 11),
                                          ),
                                        ),
                                      ]),
                                ),
                              );
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomAddAccommodationButton(
                                  loginState: loginState),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomAddAccommodationButton(loginState: loginState),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class CustomAddAccommodationButton extends StatelessWidget {
  const CustomAddAccommodationButton({
    super.key,
    required this.loginState,
  });

  final LoginLoaded loginState;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        bool verified = checkVerification(context, loginState);
        bool checkStatus = checkLimit(context, loginState);
        if (verified && checkStatus) {
          context.read<DropDownValueCubit>().instantiateDropDownValue(
            items: ['rent_room', 'hotel', 'hostel'],
          );
          context.read<AccommodationAdditionBloc>()
            ..add(AccommodationClearEvent());
          context.read<DropDownValueCubit>()..changeDropDownValue('rent_room');
          Navigator.pushNamed(context, "accommodationMain");
        }
      },
      child: Container(
        width: 157,
        height: 197,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
                width: 2, color: Color(0xff29383F).withOpacity(0.5))),
        child: Icon(
          Icons.add,
          size: 50,
          color: Color(0xff29383F).withOpacity(0.5),
        ),
      ),
    );
  }
}

class UpperHomeBody extends StatelessWidget {
  const UpperHomeBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, loginState) {
        return BlocConsumer<FetchVendorProfileBloc, FetchVendorProfileState>(
          listener: (context, state) {
            if (state is FetchVendorProfileLoaded) {
              return;
            }
            if (state is FetchVendorProfileError) {
              ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                content: Text(state.errorMessage),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                margin: EdgeInsets.only(
                    // bottom: MediaQuery.0,
                    bottom: 30,
                    right: 20,
                    left: 20),
              ));
            }
          },
          builder: (context, profileState) {
            if (profileState is FetchVendorProfileLoaded) {
              if (profileState.vendorProfile.is_verified == "True") {
                if (loginState is LoginLoaded) {
                  context.read<FetchAddedAccommodationsBloc>().add(
                      FetchAddedAccommodationHitEvent(
                          token: loginState.successModel.token!));
                  context.read<FetchCurrentTierBloc>().add(
                      FetchCurrentTierHitEvent(
                          token: loginState.successModel.token!));
                }
              }
            }
            if (profileState is! FetchVendorProfileLoaded) {
              if (loginState is LoginLoaded) {
                context.read<FetchVendorProfileBloc>().add(
                    HitFetchVendorProfileEvent(
                        token: loginState.successModel.token!));
              }
            }
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color(0xffC9C9C9),
              ),
              padding: EdgeInsets.all(10),
              height: 153,
              child: BlocBuilder<FetchCurrentTierBloc, FetchCurrentTierState>(
                builder: (context, currentTierState) {
                  return BlocBuilder<FetchTierBloc, FetchTierState>(
                    builder: (context, state) {
                      if (state is FetchTierLoadedState &&
                          currentTierState is FetchCurrentTierLoaded) {
                        Tier tier = state.tierList
                            .where((element) =>
                                element.id == currentTierState.currentTier.tier)
                            .first;
                        print(tier);
                        return upperBodyWhenVerifiedandCurrentTier(
                            tier: tier,
                            currentTier: currentTierState.currentTier);
                      }
                      if (state is FetchTierLoadedState) {
                        print("This is tier list ${state.tierList}");

                        return upperBodyWhenNotVerified(
                            tier: state.tierList[0]);
                      }
                      return CustomCircularBar(message: "Getting Data");
                    },
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}

class upperBodyWhenVerifiedandCurrentTier extends StatelessWidget {
  upperBodyWhenVerifiedandCurrentTier({
    super.key,
    required this.tier,
    required this.currentTier,
  });
  DateTime now = DateTime.now();
  final Tier tier;

  final TierTransaction currentTier;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 20,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CachedNetworkImage(
              imageUrl: "${getIp()}${tier.image}",
              width: 95,
              height: 95,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            CustomPoppinsText(
              text: "${tier.name} (Current)",
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        SizedBox(
          width: 15,
        ),
        Container(
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomPoppinsText(
                  text: "${tier.description}",
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.center,
                  color: Color(0xff383a3f),
                ),
                BlocBuilder<FetchCurrentTierBloc, FetchCurrentTierState>(
                  builder: (context, currenTierState) {
                    return BlocBuilder<FetchVendorProfileBloc,
                        FetchVendorProfileState>(
                      builder: (context, state) {
                        if (state is FetchVendorProfileLoaded) {
                          if (state.vendorProfile.is_verified == 'True') {
                            return Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Builder(builder: (context) {
                                  DateTime now = DateTime.now();
                                  DateTime paid_till =
                                      DateTime.parse(currentTier.paid_till!);
                                  if (now.isAfter(paid_till)) {
                                    return Column(
                                      children: [
                                        CustomPoppinsText(
                                          text:
                                              "Ended : ${DateFormat('yyyy-MM-dd').format(DateTime.parse(currentTier.paid_till!))}",
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: CustomMaterialButton(
                                              onPressed: () {
                                                var state = context
                                                    .read<LoginBloc>()
                                                    .state;
                                                if (state is LoginLoaded) {
                                                  context
                                                      .read<
                                                          FetchTransactionHistoryBloc>()
                                                      .add(
                                                          FetchTransactionHistoryHitEvent(
                                                              token: state
                                                                  .successModel
                                                                  .token!));
                                                  Navigator.pushNamed(context,
                                                      "/renewSubscription");
                                                }
                                              },
                                              child: Text("Renew"),
                                              backgroundColor:
                                                  Color(0xff29383f),
                                              textColor: Colors.white,
                                              height: 40),
                                        )
                                      ],
                                    );
                                  }
                                  return CustomPoppinsText(
                                    textAlign: TextAlign.center,
                                    text:
                                        " Ends: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(currentTier.paid_till!))}",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff383A3F),
                                  );
                                })
                              ],
                            );
                          }
                          return Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              CustomMaterialButton(
                                  onPressed: () {
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
                                  child: Text("Get Verified"),
                                  backgroundColor: Color(0xff29383f),
                                  textColor: Colors.white,
                                  height: 40),
                            ],
                          );
                        }
                        return SizedBox();
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 0,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }
}

class upperBodyWhenNotVerified extends StatelessWidget {
  const upperBodyWhenNotVerified({
    super.key,
    required this.tier,
  });

  final Tier tier;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 20,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CachedNetworkImage(
              imageUrl: "${getIp()}${tier.image}",
              width: 95,
              height: 95,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            CustomPoppinsText(
                text: "${tier.name} (Current)",
                fontSize: 12,
                fontWeight: FontWeight.w700),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        SizedBox(
          width: 15,
        ),
        Container(
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomPoppinsText(
                  textAlign: TextAlign.center,
                  text: "${tier.description}",
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff383A3F),
                ),
                BlocBuilder<FetchVendorProfileBloc, FetchVendorProfileState>(
                  builder: (context, state) {
                    if (state is FetchVendorProfileLoaded) {
                      if (state.vendorProfile.is_verified == 'True') {
                        return SizedBox();
                      }
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomMaterialButton(
                          onPressed: () {
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
                          child: CustomPoppinsText(
                              text: "Get Verified",
                              fontSize: 12,
                              fontWeight: FontWeight.normal),
                          backgroundColor: Color(0xff29383f),
                          textColor: Colors.white,
                          height: 40,
                        ),
                      );
                    }
                    return SizedBox();
                  },
                ),
                SizedBox(
                  height: 0,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
