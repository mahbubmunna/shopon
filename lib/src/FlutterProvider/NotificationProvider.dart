import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:sunbulahome/src/configs/strings.dart';
import 'package:sunbulahome/src/models/Notification.dart';

class Notificationprovider extends ChangeNotifier {
  NotificationModel _notification;

  NotificationModel get notification => _notification;

  Notificationprovider() {
    /*getAllNotification().then((value) {
      _notification = value;

      notifyListeners();
    });*/
  }

  Future<NotificationModel> getAllNotification() async {
    NotificationModel notification;

    await http.get("${notification_base_url}notification/user").then((value) {
      if (value.statusCode == 200) {
        print("Notification   ${value.body}");

        notification = NotificationModel.fromJson(json.decode(value.body));
      }
    }).catchError((err) => print(err));

    return notification;
  }
}
