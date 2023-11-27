import '../../../constants/constants_exports.dart';
import '../../../logic/blocs/bloc_exports.dart';
import '../../widgets/widgets_exports.dart';

class TabBar2 extends StatelessWidget {
  const TabBar2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FetchTierBloc, FetchTierState>(
        listener: (context, state) {
      if (state is TierErrorState) {
        customScaffold(
            context: context,
            title: "Oh snap!",
            message: state.errorMessage,
            contentType: ContentType.failure);
      }
    }, builder: (context, state) {
      if (state is FetchTierLoadingState) {
        return Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 6,
                  ),
                  Text("Hold on, we are loading data"),
                  SizedBox(
                    height: 20,
                  ),
                  CircularProgressIndicator(
                    color: Color(0xff29383F).withOpacity(0.8),
                  ),
                ],
              )
            ],
          ),
        );
      }
      if (state is FetchTierLoadedState) {
        return AnimationLimiter(
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: state.tierList.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredGrid(
                position: index,
                columnCount: 2,
                duration: Duration(seconds: 2),
                child: SlideAnimation(
                  child: SlideAnimation(
                    delay: Duration(seconds: 1),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: SizedBox(
                        // height: 190,
                        child: Card(
                          elevation: 0,
                          surfaceTintColor: Colors.white,
                          shadowColor: Colors.white,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(children: [
                              CachedNetworkImage(
                                imageUrl:
                                    "${getIp()}${state.tierList[index].image.toString()}",
                                width: 95,
                                height: 95,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                state.tierList[index].name.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 12),
                              ),
                              Expanded(
                                child: Text(
                                  state.tierList[index].description.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff9DA8C3),
                                      fontSize: 11),
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      } else {
        return Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (state is TierErrorState)
                  ? Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 6,
                        ),
                        Text("Connection Error "),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 140.0),
                            child: CustomMaterialButton(
                              onPressed: () {
                                final state =
                                    BlocProvider.of<FetchTierBloc>(context);
                                print(state.state);
                                final state2 =
                                    BlocProvider.of<LoginBloc>(context).state;
                                if (state2 is LoginLoaded) {
                                  return context.read<FetchTierBloc>().add(
                                      FetchTierHitEvent(
                                          token: state2.successModel.token!));
                                }
                              },
                              child: Text("Retry"),
                              backgroundColor: Color(0xff29383f),
                              textColor: Colors.white,
                              height: 40,
                            ))
                      ],
                    )
                  : Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 6,
                        ),
                        Text("Connection Error "),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 140.0),
                          child: CustomMaterialButton(
                              onPressed: () {},
                              child: Text("Retry"),
                              backgroundColor: Color(0xff546464),
                              textColor: Colors.white,
                              height: 40),

                          // MaterialButton(
                          //   onPressed: () {
                          //     // context.read<FetchTierBloc>(context)
                          //     final state =
                          //         BlocProvider.of<FetchTierBloc>(context);
                          //     print(state.state);
                          //     final state2 =
                          //         BlocProvider.of<LoginBloc>(context).state;
                          //     if (state2 is LoginLoaded) {
                          //       return context.read<FetchTierBloc>().add(
                          //           FetchTierHitEvent(
                          //               token: state2.successModel.token!));
                          //     }
                          //   },
                          //   minWidth: MediaQuery.of(context).size.width,
                          //   height: 48,
                          //   shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(5)),
                          //   textColor: Colors.white,
                          //   color: Color(0xff546464),
                          //   child: Text("Retry"),
                          // ),
                        ),
                      ],
                    )
            ],
          ),
        );
      }
    });
  }
}
