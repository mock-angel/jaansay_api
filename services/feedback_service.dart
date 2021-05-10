import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get_storage/get_storage.dart';
import '../../constants/constants.dart';
import '../models/feedback.dart';
import 'dio_service.dart';
import 'notification_service.dart';
import '../../utils/misc_utils.dart';

class FeedbackService {
  final officialId = GetStorage().read("official_id");
  DioService dioService = DioService();

  Future<bool> addFeedbackMaster(
      String message,
      List<String> userList,
      CustomMessageType messageType,
      List<PlatformFile> files,
      CustomContentType fileType,
      DateTime date) async {
    Directory directory = await getTemporaryDirectory();
    List<File> compressedFiles = [];

    final formData = FormData.fromMap(
      {
        "message": message,
        "users": userList,
        "official_id": officialId.toString(),
        "content_type": fileType.index
      },
    );

    for (int i = 0; i < files.length; i++) {
      String fileName = (DateTime.now().toString() +
              i.toString() +
              officialId.toString() +
              files[i].name.toString())
          .toString()
          .replaceAll(" ", "");

      if (fileType == CustomContentType.IMAGE) {
        var result = await MiscUtils.compressImage(
            files[i].path,
            (directory.path + '/' + files[i].name)
                .toString()
                .replaceAll(" ", ""),
            files[i].extension);
        compressedFiles.add(result);
        formData.files.addAll([
          MapEntry(
            "media",
            await MultipartFile.fromFile(
              compressedFiles[i].path,
              filename: fileName,
            ),
          ),
        ]);
      } else {
        // final info = await VideoCompress.compressVideo(
        //   files[i].path,
        //   quality: VideoQuality.MediumQuality,
        //   deleteOrigin: false,
        //   includeAudio: true,
        // );

        formData.files.addAll([
          MapEntry(
            "media",
            await MultipartFile.fromFile(
              files[i].path,
              filename: fileName,
            ),
          ),
        ]);
      }
    }

    final response = await dioService.postFormData("feedback/master", formData);
    if (response != null) {
      if (response['success']) {
        await sendNotificationToUsers(message, userList, date);
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  getAllFeedback(List<FeedbackMaster> feedback) async {
    final response = await dioService.getData("feedback/official/$officialId");
    if (response != null) {
      response['data']
          .map(
            (val) => feedback.add(
              FeedbackMaster.fromJson(val),
            ),
          )
          .toList();
    }
  }

  getAnswersByFeedbackId(
      List<FeedbackAnswer> feedbackAnswers, int feedbackId) async {
    final response = await dioService.getData("feedback/answers/$feedbackId");
    if (response != null) {
      response['data']
          .map(
            (val) => feedbackAnswers.add(
              FeedbackAnswer.fromJson(val),
            ),
          )
          .toList();
    }
  }

  sendNotificationToUsers(
      String message, List<String> userList, DateTime date) async {
    if (date.isBefore(DateTime.now().add(Duration(minutes: 2)))) {
      NotificationService notificationService = NotificationService();
      await notificationService.sendNotificationToGroupOfUser(
          GetStorage().read("official_name"),
          message,
          userList,
          {"type": "feedback"});
    }
    return;
  }
}
