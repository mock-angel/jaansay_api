import 'package:get_storage/get_storage.dart';
import 'package:jaansay_officials/api/models/key.dart';
import 'package:jaansay_officials/api/services/dio_service.dart';
import 'package:jaansay_officials/api/services/notification_service.dart';

class KeyService {
  final officialId = GetStorage().read("official_id");
  DioService dioService = DioService();

  getKeysByOfficialId(List<KeyMaster> keys) async {
    final response = await dioService.getData("keys/official/$officialId");
    if (response != null) {
      response['data'].map((e) {
        keys.add(KeyMaster.fromJson(e));
      }).toList();
    }
  }

  getOptionsByOfficialId(List<KeyOption> keyOptions) async {
    final response =
        await dioService.getData("keys/option/official/$officialId");
    if (response != null) {
      response['data'].map((e) {
        keyOptions.add(KeyOption.fromJson(e));
      }).toList();
    }
  }

  getGeneralKeys(List<KeyMaster> keys) async {
    final response =
        await dioService.getData("keys/general/official/$officialId");
    if (response != null) {
      response['data'].map((e) {
        keys.add(KeyMaster.fromJson(e));
      }).toList();
    }
  }

  getKeyTypes(List<KeyType> keyTypes) async {
    final response = await dioService.getData("keys/types");
    if (response != null) {
      response['data'].map((e) {
        keyTypes.add(KeyType.fromJson(e));
      }).toList();
    }
    if (response['next'] != null) {
      return response['next']['page'];
    }
  }

  getAnswerByKey(List<KeyAnswer> keyAnswers, int kmId, int page) async {
    final response =
        await dioService.getData("keys/$kmId/page/$page/official/$officialId");
    if (response != null) {
      response['data'].map((e) {
        keyAnswers.add(KeyAnswer.fromJson(e));
      }).toList();
    }
  }

  getAnswerCount(List<AnswerCount> answerCounts, int kmId) async {
    final response = await dioService.getData("keys/answer/$kmId");
    if (response != null) {
      response['data'].map((e) {
        answerCounts.add(AnswerCount.fromJson(e));
      }).toList();
    }
  }

  addKeyMaster(KeyMaster key) async {
    NotificationService notificationService = NotificationService();
    await notificationService.sendNotificationToUser(
        GetStorage().read("official_name"),
        "Has requested to add a key. Key name: ${key.name}",
        "admin",
        {"type": "key"});
    await dioService.postData("keys/master", {
      "name": key.name,
      "description": key.description,
      "official_id": officialId,
      "options": key.options,
      "kt_id": key.ktId,
      "km_id": key.kmId
    });
  }

  addKeyOption(String name, int kmId) async {
    await dioService.postData("keys/option", {"km_id": kmId, "name": name});
  }

  updateKeyMaster(KeyMaster key, String name, String description) async {
    await dioService.patchData(
        "keys/", {"name": name, "description": description, "km_id": key.kmId});
  }

  deleteKeyMaster(KeyMaster key) async {
    await dioService.deleteData("keys/",
        data: {"official_id": officialId, "km_id": key.kmId});
  }

  deleteKeyOption(KeyMaster key, int optionId) async {
    await dioService.deleteData("keys/option",
        data: {"km_id": key.kmId, "ko_id": optionId});
  }
}
