import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_storage/get_storage.dart';
import '../../constants/constants.dart';
import '../models/official.dart';

class AuthService {
  loginUser(String phone, String passcode) async {
    Dio dio = new Dio();

    try {
      Response response = await dio.post(
        "${Constants.url}officials/login",
        data: {"officials_phone": phone, "passcode": passcode},
      );

      if (response.data['success']) {
        Official official = Official.fromJson(response.data['data']);
        if (response.data['data']['status'] == 'ACTIVE') {
          GetStorage box = GetStorage();
          box.write("token", response.data['token']);
          box.write("passcode", passcode);
          box.write("official_phone", official.officialsPhone);
          box.write("official_name", official.officialsName);
          box.write("photo", official.photo);
          box.write("official_id", official.officialsId);
          box.write("official_type", official.typeName);
          box.write("rm_id", official.isReferral);
          box.write("profile_link", official.profileLink);
          FirebaseMessaging fbm = FirebaseMessaging.instance;
          fbm.subscribeToTopic(box.read("official_id").toString());
          Dio dio = new Dio();
          response = await dio.get(
            "${Constants.url}utility/official/${official.officialsId}",
            options: Options(
              headers: {
                HttpHeaders.authorizationHeader: "Bearer ${box.read("token")}",
              },
            ),
          );
          if (response.data['success']) {
            if (response.data['data'] != null) {
              List<OfficialUtility> officialUtilities = [];
              response.data['data']
                  .map(
                      (e) => officialUtilities.add(OfficialUtility.fromJson(e)))
                  .toList();
              box.write("permission", officialUtilities);
            }
          }
          return true;
        } else {
          return false;
        }
      } else {
        print("Failed");
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
