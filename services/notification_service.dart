import 'dart:io';

import 'package:dio/dio.dart';
import '../../constants/constants.dart';

class NotificationService {
  Dio dio = new Dio();
  String serverCode = Constants.notificationServerCode;

  Future sendNotificationToUser(
    String title,
    String message,
    String userId,
    Map data,
  ) async {
    await dio.post(
      "https://fcm.googleapis.com/fcm/send",
      data: {
        "notification": {
          "title": title,
          "body": message,
          "click_action": "FLUTTER_NOTIFICATION_CLICK",
          "icon": "http://jaansay.com/logo.png"
        },
        "to": "/topics/$userId",
        "data": data
      },
      options: Options(
        headers: {
          HttpHeaders.authorizationHeader: serverCode,
        },
      ),
    );
    return;
  }

  Future sendNotificationToGroupOfUser(
      String title, String message, List<String> users, Map data) async {
    String condition;

    if (users.length < 2) {
      return;
    }

    condition = users
        .map((e) {
          if (users.indexOf(e) != users.length - 1) {
            return "'$e' in topics || ";
          } else {
            return "'$e' in topics";
          }
        })
        .toString()
        .replaceAll(', ', "");

    await dio.post(
      "https://fcm.googleapis.com/fcm/send",
      data: {
        "notification": {
          "title": title,
          "body": message,
          "click_action": "FLUTTER_NOTIFICATION_CLICK",
          "icon": "http://jaansay.com/logo.png"
        },
        "condition": condition,
        "data": data
      },
      options: Options(
        headers: {
          HttpHeaders.authorizationHeader: serverCode,
        },
      ),
    );
    return;
  }
}
