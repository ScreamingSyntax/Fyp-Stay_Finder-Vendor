import '../../../constants/constants_exports.dart';
import '../../../logic/blocs/bloc_exports.dart';
import '../../widgets/widgets_exports.dart';

class TabBar1 extends StatelessWidget {
  const TabBar1({
    super.key,
  });

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
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0xffC9C9C9),
                ),
                padding: EdgeInsets.all(10),
                height: 153,
                child: BlocBuilder<FetchTierBloc, FetchTierState>(
                  builder: (context, state) {
                    if (state is FetchTierLoaedState) {
                      return Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CachedNetworkImage(
                                imageUrl:
                                    "${getIp()}${state.tierList[0].image}",
                                width: 95,
                                height: 95,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                              Text(
                                "${state.tierList[0].name} (Current)",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w700),
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
                                  Text(
                                    "${state.tierList[0].description}.",
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(
                                        color: Color(0xff383A3F),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  BlocBuilder<FetchVendorProfileBloc,
                                      FetchVendorProfileState>(
                                    builder: (context, state) {
                                      if (state is FetchVendorProfileLoaded) {
                                        if (state.vendorProfile.is_verified ==
                                            'True') {
                                          return SizedBox();
                                        }
                                        return MaterialButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          color: Color(0xff29383F)
                                              .withOpacity(0.8),
                                          textColor: Color(0xffFFFCFC),
                                          onPressed: () {
                                            var state =
                                                context.read<LoginBloc>().state;
                                            if (state is LoginLoaded) {
                                              context.read<
                                                  FetchVendorProfileBloc>()
                                                ..add(
                                                    HitFetchVendorProfileEvent(
                                                        token: state
                                                            .successModel
                                                            .token!));
                                              Navigator.pushNamed(
                                                  context, "/info");
                                            }
                                            context
                                                .read<DocumentDetailDartBloc>()
                                                .add(DocumentDataClearEvent());
                                          },
                                          minWidth: 50,
                                          disabledColor: Color(0xff29383F)
                                              .withOpacity(0.8),
                                          focusColor: Color(0xff29383F)
                                              .withOpacity(0.8),
                                          child: Text("Get Verified"),
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
                    return SizedBox();
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 7.2, vertical: 30),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Your accomodations",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                    // textAlign: TextAlign.start,
                  ),
                ),
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
