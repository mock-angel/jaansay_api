import 'package:get_storage/get_storage.dart';
import '../models/referral.dart';
import 'dio_service.dart';

class ReferralService {
  final officialId = GetStorage().read("official_id");
  DioService dioService = DioService();

  getReferralMaster() async {
    final response = await dioService.getData("referral/master/$officialId");
    if (response != null) {
      return ReferralMaster.fromJson(response['data'][0]);
    }
    return null;
  }

  getAcceptedReferrals(List<AcceptedReferral> acceptedReferrals) async {
    final response = await dioService.getData("referral/$officialId");
    if (response != null) {
      response['data']
          .map((e) => acceptedReferrals.add(AcceptedReferral.fromJson(e)))
          .toList();
    }
  }

  addReferralMaster(ReferralMaster referralMaster) async {
    final response = await dioService.postData("referral/master", {
      "official_id": officialId,
      "description": referralMaster.description,
      "referrer_cost": referralMaster.referrerCost,
      "referrer_description": referralMaster.referrerDescription,
      "referred_cost": referralMaster.referredCost,
      "referred_description": referralMaster.referredDescription,
      "created_at": DateTime.now().toString()
    });
    if (response != null) {
      return true;
    } else {
      return false;
    }
  }

  acceptReferralCode(String userId, String rcCode) async {
    final response = await dioService.postData("referral/codeaccept",
        {"official_id": officialId, "user_id": userId, "rc_code": rcCode});
    if (response != null) {
      return true;
    } else {
      return false;
    }
  }
}
