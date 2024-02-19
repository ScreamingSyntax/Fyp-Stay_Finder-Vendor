import 'package:stayfinder_vendor/data/model/notification_model.dart';
import 'package:stayfinder_vendor/logic/blocs/bloc_exports.dart';

import '../../logic/cubits/cubit_exports.dart';
import '../../presentation/widgets/widgets_exports.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffECEFF1),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Notifications",
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        backgroundColor: Color(0xff37474F),
      ),
      body: BlocBuilder<FetchNotificationsCubit, FetchNotificationsState>(
        builder: (context, state) {
          if (state is FetchNotificationsLoading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Fetching Notifications")
                ],
              ),
            );
          }
          if (state is FetchNotificationsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(state.error),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 4,
                    child: CustomMaterialButton(
                      onPressed: () {
                        callNotificationsMethod(context);
                      },
                      child: Text("Retry"),
                      backgroundColor: Color(0xff514f53),
                      textColor: Colors.white,
                      height: 45,
                    ),
                  )
                ],
              ),
            );
          }
          if (state is FetchNotificationsSuccess) {
            return RefreshIndicator(
              onRefresh: () async {
                callNotificationsMethod(context);
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    ListView.builder(
                      itemCount: state.notifications.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        NotificationModel notificationModel =
                            state.notifications[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6.0, horizontal: 15),
                          child: Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                color: Color(0xffF5F5F5),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                ListTile(
                                  leading: Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.fitHeight,
                                            image:
                                                fetchNotificationStatusImages(
                                                    status: notificationModel
                                                        .notification_type!)),
                                        // color: Colors.black,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                  ),
                                  title: Text(
                                    notificationModel.description!,
                                    style: TextStyle(
                                        fontSize: 12, color: Color(0xff2E3D49)),
                                  ),
                                  subtitle: Text(
                                    formatDateTimeinMMMMDDYYY(
                                      notificationModel.added_date!,
                                    ),
                                    style: TextStyle(
                                        fontSize: 10, color: Color(0xff607D8B)),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            );
          }
          if (state is FetchNotificationsInitial) {
            callNotificationsMethod(context);
          }
          return Column(
            children: [
              Center(
                child: Text('Notification Screen'),
              ),
            ],
          );
        },
      ),
    );
  }

  AssetImage fetchNotificationStatusImages({required String status}) {
    if (status == "warning") {
      return AssetImage("assets/icons/warning.png");
    }
    if (status == "info") {
      return AssetImage("assets/icons/info.png");
    }
    if (status == "success") {
      return AssetImage("assets/icons/success.png");
    }
    if (status == "failure") {
      return AssetImage("assets/icons/error.png");
    }
    return AssetImage("assets/icons/error.png");
  }
}
