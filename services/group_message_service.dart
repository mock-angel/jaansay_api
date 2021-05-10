import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jaansay_officials/constants/constants.dart';
import '../models/customer.dart';
import '../models/message.dart';
import 'dio_service.dart';
import 'notification_service.dart';
import '../../utils/misc_utils.dart';

class GroupMessageService {
  final officialId = GetStorage().read("official_id");
  DioService dioService = DioService();

  Future<bool> broadcastMessage(
      String message,
      List<String> userList,
      CustomMessageType messageType,
      List<PlatformFile> files,
      CustomContentType fileType,
      DateTime date) async {
    Directory directory = await getTemporaryDirectory();
    String groupId = MiscUtils.getRandomNumberId(8);
    List<File> compressedFiles = [];

    final formData = FormData.fromMap({
      "message": message,
      "users": userList,
      "official_id": officialId.toString(),
      "sender_id": officialId.toString(),
      "type": messageType.index,
      "message_type": files.length == 0 ? 0 : fileType.index,
      "group_id": groupId,
      "updated_at": date.toString()
    });

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

    final response =
        await dioService.postFormData("messages/addbroadcastmessage", formData);
    if (response != null) {
      if (message.length != 0 && files.length != 0) {
        final formData = FormData.fromMap({
          "message": message,
          "users": userList,
          "official_id": officialId.toString(),
          "sender_id": officialId.toString(),
          "type": messageType.index,
          "message_type": "0",
          "group_id": groupId,
          "updated_at": date.toString()
        });
        final response = await dioService.postFormData(
            "messages/addbroadcastmessage", formData);

        if (response['success']) {
          await sendNotificationToUsers(message, userList, date);
          return true;
        } else {
          return false;
        }
      } else {
        await sendNotificationToUsers(message, userList, date);

        return true;
      }
    }
    return false;
  }

  broadcastTemplate(
      TemplateMessage templateMessage,
      List<TemplateParameter> templateParameters,
      List<Customer> users,
      CustomMessageType messageType,
      DateTime updatedAt) async {
    String groupId = MiscUtils.getRandomId(12);
    List<String> userIds = [];
    List<Customer> appCustomers = [];
    users.map((e) {
      if (e.userId == null) {
        userIds.add(e.tuId.toString());
      } else {
        userIds.add(e.userId.toString());
        appCustomers.add(e);
      }
    }).toList();
    await dioService.postData("templatemessages", {
      "message": templateMessage.message,
      "users": userIds,
      "official_id": officialId,
      "sender_id": officialId,
      "type": messageType.index,
      "message_type": "0",
      "updated_at": updatedAt.toString(),
      "group_id": groupId,
      "parameter_count": templateMessage.parameter,
      "parameters": templateParameters?.map((e) => e.tpId)?.toList() ?? [],
      "template_id": templateMessage.templateId,
      "header": templateMessage.header
    });

    await sendNotificationToUsers(templateMessage.message,
        appCustomers.map((e) => e.userId.toString()).toList(), updatedAt);
  }

  getSMSCount() async {
    final res = await dioService.getData("templatemessages/$officialId");
    if (res == null) {
      return null;
    } else {
      return res['data'][0];
    }
  }

  updateSMSCount(int smsCount) async {
    await dioService.patchData("templatemessages/count",
        {"official_id": officialId, "smscount": smsCount});
  }

  sendNotificationToUsers(
      String message, List<String> userList, DateTime date) async {
    if (date.isBefore(DateTime.now().add(Duration(minutes: 2)))) {
      NotificationService notificationService = NotificationService();
      await notificationService.sendNotificationToGroupOfUser(
          GetStorage().read("official_name"),
          message,
          userList,
          {"type": "message"});
    }
    return;
  }

  getAllFeedback(List<Message> messages, String date) async {
    final response = await dioService
        .getData("messages/allfeedback/$officialId/month/$date");
    if (response != null) {
      response['data'].map((val) {
        messages.add(Message.fromJson(val));
      }).toList();
    }
  }

  getAllBroadcast(List<Message> messages, String date) async {
    final response = await dioService
        .getData("messages/allbroadcast/$officialId/month/$date");
    if (response != null) {
      response['data'].map((val) {
        messages.add(Message.fromJson(val));
      }).toList();
    }
  }

  getTemplateMessages(List<TemplateMessage> templateMessage,
      {int id = 1}) async {
    final response = await dioService
        .getData("templatemessages/type/$id/official/$officialId");
    if (response != null) {
      response['data'].map((e) {
        templateMessage.add(TemplateMessage.fromJson(e));
      }).toList();
    }
  }

  getTemplateParameters(List<TemplateParameter> templateParameters) async {
    final response = await dioService
        .getData("templatemessages/parameter/type/1/official/$officialId");
    if (response != null) {
      response['data'].map((e) {
        templateParameters.add(TemplateParameter.fromJson(e));
      }).toList();
    }
  }
}
