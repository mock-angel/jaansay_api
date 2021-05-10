import 'dart:convert';
import 'dart:io';
import 'package:get_storage/get_storage.dart';
import 'dio_service.dart';

class MiscService {
  final officialId = GetStorage().read("official_id");
  DioService dioService = DioService();

  Future<void> addFeedback({
    String message,
    var files,
  }) async {
    List _media = [];

    for (var i = 0; i < files.length; i++) {
      File file = File(files[i].path);

      _media.add(
        {
          "file_name": files[i].name,
          "file": base64Encode(
            file.readAsBytesSync(),
          ),
        },
      );
    }

    await dioService.postData("grievances", {
      "user_id": officialId,
      "grievance_message": "$message",
      "lattitude": "0",
      "longitude": "0",
      "status_id": "0",
      "updated_at": "${DateTime.now()}",
      "is_feedback": "1",
      "doc_id": "2",
      "media": (_media.length == 0 || _media == null) ? "no media" : _media,
    });
  }
}
