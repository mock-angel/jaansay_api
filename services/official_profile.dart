import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../../constants/constants.dart';
import '../models/official.dart';

class OfficialProfile {
  Dio dio = Dio();
  GetStorage box = GetStorage();

  Future<bool> updateProfile(Official official, File image) async {
    try {
      var isSuccess = false;

      FormData formData = FormData.fromMap({
        "officials_name": official.officialsName.toString(),
        "officials_description": official.officialsDescription.toString(),
        "officials_email": official.officialsEmail.toString(),
        "officials_phone": official.officialsPhone.toString(),
        "lattitude": official.lattitude.toString(),
        "longitude": official.longitude.toString(),
        "officials_address": official.officialsAddress.toString(),
        "business_hours": official.businessHours.toString(),
        "profile_photo": image != null ? "yes" : "no",
        "photo": official.photo,
        "type_id": official.typeId.toString(),
        "businesstype_id": official.businesstypeId.toString(),
        "officials_id": official.officialsId.toString(),
        "updated_at": DateTime.now().toString(),
      });

      if (image != null) {
        formData.files.add(
          MapEntry(
            'media',
            await MultipartFile.fromFile(
              image.path,
              filename:
                  "${box.read("official_name").toString().replaceAll(" ", "")}${DateTime.now().toString().replaceAll(" ", "")}.png",
            ),
          ),
        );
      }

      Response response = await dio.patch("${Constants.url}officials/",
          data: formData,
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer ${box.read("token")}"
          }));

      if (response.data["success"]) {
        if (image != null) {
          PaintingBinding.instance.imageCache.clear();
          box.write("photo",
              "${box.read("official_name").toString().replaceAll(" ", "")}${DateTime.now().toString().replaceAll(" ", "")}.png");
        }
        isSuccess = true;
      }
      return isSuccess;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
