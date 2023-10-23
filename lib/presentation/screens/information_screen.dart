import 'package:stayfinder_vendor/logic/blocs/bloc_exports.dart';
import 'package:stayfinder_vendor/logic/cubits/cubit_exports.dart';
import 'package:stayfinder_vendor/presentation/widgets/widgets_exports.dart';

import '../../constants/constants_exports.dart';

class InformationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FetchVendorProfileBloc, FetchVendorProfileState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is FetchVendorProfileLoaded) {
          var custoDecoration = OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: Color(0xff29383F),
              ),
              borderRadius: BorderRadius.circular(
                5,
              ));
          return Scaffold(
            appBar: AppBar(
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Container(
                      width: 120,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Color(
                            0xffDAD7CD,
                          ),
                          borderRadius: BorderRadius.circular(50)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            (state.vendorProfile.is_verified == "True")
                                ? Icons.verified
                                : Icons.error,
                            size: 20,
                          ),
                          (state.vendorProfile.is_verified == "True")
                              ? Text("Verified")
                              : Text("Unverified")
                        ],
                      )),
                )
              ],
              title: Text(
                "My Information",
                style: TextStyle(fontSize: 16),
              ),
            ),
            body: Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Color(
                    0xffDAD7CD,
                  ),
                  borderRadius: BorderRadius.circular(5)),
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Document Details",
                        style: TextStyle(
                            color: Color(0xff29383F),
                            fontSize: 16,
                            fontWeight: FontWeight.w700)),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Profile Photo",
                        style: TextStyle(
                            color: Color(0xff29383F),
                            fontSize: 12,
                            fontWeight: FontWeight.w500)),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Color(0xff29383F).withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CachedNetworkImage(
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.fill,
                                      imageUrl:
                                          "${getIp()}${state.vendorProfile.profile_picture}"),
                                ),
                              )
                            ])),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Citizenship Photo",
                        style: TextStyle(
                            color: Color(0xff29383F),
                            fontSize: 14,
                            fontWeight: FontWeight.w700)),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Front",
                        style: TextStyle(
                            color: Color(0xff29383F),
                            fontSize: 12,
                            fontWeight: FontWeight.w500)),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xff29383F).withOpacity(0.5)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CachedNetworkImage(
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.fill,
                                    imageUrl:
                                        "${getIp()}${state.vendorProfile.citizenship_front}"),
                              )
                            ])),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Back",
                        style: TextStyle(
                            color: Color(0xff29383F),
                            fontSize: 12,
                            fontWeight: FontWeight.w500)),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xff29383F).withOpacity(0.5)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CachedNetworkImage(
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.fill,
                                    imageUrl:
                                        "${getIp()}${state.vendorProfile.citizenship_back}"),
                              )
                            ])),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Enter Address",
                        style: TextStyle(
                            color: Color(0xff29383F),
                            fontSize: 12,
                            fontWeight: FontWeight.w500)),
                    SizedBox(
                      height: 5,
                    ),
                    BlocProvider(
                      create: (context) => ClickedItemCubit(),
                      child: BlocBuilder<ClickedItemCubit, ClickedItemState>(
                        builder: (context, state) {
                          return TextFormField(
                            enabled: state.clicked,
                            decoration: InputDecoration(
                              hintText: "Address",
                              suffixIcon: InkWell(
                                  onTap: () {
                                    context.read<ClickedItemCubit>()
                                      ..clickedUnique(!state.clicked);
                                  },
                                  child: Icon(Icons.edit)),
                              isDense: true,
                              focusedBorder: custoDecoration,
                              enabledBorder: custoDecoration,
                              disabledBorder: custoDecoration,
                              border: custoDecoration,
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    AnimatedContainer(
                      duration: Duration(seconds: 2),
                      width: MediaQuery.of(context).size.width,
                      child: MaterialButton(
                        onPressed: () {},
                        minWidth: MediaQuery.of(context).size.width,
                        height: 48,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        textColor: Colors.white,
                        color: Color(0xff546464),
                        child: Text("Submit for verification"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return Scaffold(
            body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [CustomCircularBar(message: "Fetching ")],
          ),
        ));
      },
    );
  }
}
