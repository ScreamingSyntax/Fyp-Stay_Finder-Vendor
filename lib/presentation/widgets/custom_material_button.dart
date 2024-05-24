// ignore: must_be_immutable
import '../../constants/constants_exports.dart';
import '../../logic/blocs/bloc_exports.dart';
import 'widgets_exports.dart';

// ignore: must_be_immutable
class CustomMaterialButton extends StatelessWidget {
  final Widget child;

  Function() onPressed;
  final Color backgroundColor;
  final double height;
  final Color textColor;
  CustomMaterialButton({
    Key? key,
    required this.onPressed,
    required this.child,
    required this.backgroundColor,
    required this.textColor,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      minWidth: MediaQuery.of(context).size.width,
      height: height,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      textColor: textColor,
      color: backgroundColor,
      child: child,
    );
  }
}

class UpperBody extends StatelessWidget {
  const UpperBody({
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
                    Text(
                      "Stay",
                      style: TextStyle(
                        fontFamily: 'Slackey',
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                    CustomPoppinsText(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      text: "finder",
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<VendorDataProviderBloc,
                        VendorDataProviderState>(builder: (context, state) {
                      if (state is VendorLoaded) {
                        return CustomPoppinsText(
                            text: "Hi ${state.vendorModel.fullName}",
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.normal);
                      }
                      return CustomPoppinsText(
                          text: "Hi There,",
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.normal);
                    }),
                    CustomPoppinsText(
                        text: "Good Morning",
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w700)
                    // Text("Good Morning",)
                  ],
                ),
              ],
            ),
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
                                      width: 2, color: Colors.white)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(200),
                                child: CachedNetworkImage(
                                    width: 88,
                                    height: 88,
                                    fit: BoxFit.fill,
                                    errorWidget: (context, url, error) {
                                      return SizedBox(
                                        height: 0,
                                      );
                                    },
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
          color: Color(0xff37474F),
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
