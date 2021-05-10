import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jaansay_officials/api/models/message.dart';
import 'package:jaansay_officials/api/services/dio_service.dart';
import 'package:jaansay_officials/api/services/notification_service.dart';

class MessageService {
  final officialId = GetStorage().read("official_id");
  DioService dioService = DioService();

  Future<void> getMessageMasters(List<MessageMaster> messageMasters) async {
    final response = await dioService.getData("messages/officials/$officialId");
    if (response != null) {
      response['data'].map((val) {
        messageMasters.add(MessageMaster.fromJson(val));
      }).toList();
    }
  }

  Future<bool> sendMessage(String message, String userId, String type) async {
    final response = await dioService.postFormData(
        "messages/addmessage",
        FormData.fromMap({
          "message": message,
          "user_id": userId.toString(),
          "official_id": officialId.toString(),
          "sender_id": officialId.toString(),
          "type": type,
          'message_type': 0,
          "updated_at": DateTime.now().toString()
        }));

    if (response != null) {
      NotificationService notificationService = NotificationService();
      await notificationService.sendNotificationToUser(
          GetStorage().read("official_name"),
          message,
          userId.toString(),
          {"type": "message"});
      return true;
    }

    return false;
  }

  Future<void> getAllMessagesUsingUserId(
      List<Message> messages, String userId) async {
    final response = await dioService.getData(
        "messages/allmessages/official/$officialId/user/$userId/type/0");

    if (response != null) {
      response['data'].map((val) {
        messages.add(Message.fromJson(val));
      }).toList();
    }
  }
}
