import 'package:get_storage/get_storage.dart';
import 'package:jaansay_officials/api/models/message.dart';
import 'package:jaansay_officials/api/services/dio_service.dart';

class AWService {
  final officialId = GetStorage().read("official_id");
  DioService dioService = DioService();

  getAllAW(List<Message> workflows) async {
    final response =
        await dioService.getData("messages/allmessages/$officialId/scheduled");
    if (response != null) {
      return response['data']
          .map((val) => workflows.add(Message.fromJson(val)))
          .toList();
    }
  }

  deleteService(String awId) async {
    final response =
        await dioService.deleteData("messages/groupmessages/$awId");
    if (response != null) {
      return;
    }
  }
}
