import 'package:get_storage/get_storage.dart';
import 'package:jaansay_officials/api/models/loyalty.dart';
import 'package:jaansay_officials/api/services/dio_service.dart';

class LoyaltyService {
  final officialId = GetStorage().read("official_id");
  DioService dioService = DioService();

  getLoyaltyMaster() async {
    final response =
        await dioService.getData("loyalty/master/official/$officialId");
    if (response != null) {
      return LoyaltyMaster.fromJson(response['data']);
    }
    return null;
  }

  addLoyalty(int userId, int score) async {
    await dioService.postData("loyalty/add/user",
        {"official_id": officialId, "user_id": userId, "score": score});
  }
}
