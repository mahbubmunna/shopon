import 'package:provider/provider.dart';
import 'package:smartcommercebd/src/FlutterProvider/NotificationProvider.dart';
import 'package:smartcommercebd/src/models/Notification.dart';
import 'package:smartcommercebd/src/widgets/EmptyNotificationsWidget.dart';
import 'package:smartcommercebd/src/widgets/NotificationItemWidget.dart';
import 'package:smartcommercebd/src/widgets/SearchBarWidget.dart';
import 'package:flutter/material.dart';

class NotificationsWidget extends StatefulWidget {
  @override
  _NotificationsWidgetState createState() => _NotificationsWidgetState();
}

class _NotificationsWidgetState extends State<NotificationsWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Notificationprovider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 7),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            /* Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SearchBarWidget(),
            ),*/

            FutureBuilder(
              future: provider.getAllNotification(),
              builder:
                  (context, AsyncSnapshot<NotificationModel> notification) {
                // print("Data  ${notification.data.success}");


                    if(notification.data == null){

                      return Center(child: CircularProgressIndicator());
                    }

                if (notification.data.success) {
                  return ListView.separated(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shrinkWrap: true,
                    primary: false,
                    itemCount: notification.data.results.data.length,
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 7);
                    },
                    itemBuilder: (context, index) {
                      return NotificationItemWidget(
                        notification: notification.data.results.data[index],
                        /* onDismissed: (notification) {
                       setState(() {
                         provider.notification.results.data.removeAt(index);
                       });
                     },*/
                      );
                    },
                  );
                } else if (notification.data.success == false) {
                  return EmptyNotificationsWidget();
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),

            /*  Offstage(
              offstage: provider.notification.results.data.isNotEmpty,
              child: EmptyNotificationsWidget(),
            )*/
          ],
        ),
      ),
    );
  }
}
