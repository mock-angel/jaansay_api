import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jaansay_officials/api/models/coupon.dart';
import 'package:jaansay_officials/api/services/dio_service.dart';
import 'package:jaansay_officials/api/services/notification_service.dart';
import 'package:jaansay_officials/utils/misc_utils.dart';

class CouponService {
  final officialId = GetStorage().read("official_id");
  DioService dioService = DioService();

  getCoupons(List<Coupon> coupons) async {
    final response = await dioService.getData("coupon/official/$officialId");
    if (response != null) {
      response['data'].map((e) => coupons.add(Coupon.fromJson(e))).toList();
    }
  }

  getCouponUsers(List<CouponUser> couponUsers, String couponId) async {
    final response = await dioService.getData("coupon/users/$couponId");
    if (response != null) {
      response['data']
          .map((e) => couponUsers.add(CouponUser.fromJson(e)))
          .toList();
    }
  }

  getCouponDetails(String couponId) async {
    final response = await dioService.getData("coupon/$couponId");
    if (response != null) {
      return Coupon.fromJson(response['data'][0]);
    }
  }

  addCoupon(Coupon coupon) async {
    String couponCode = MiscUtils.getRandomId(8);
    String couponUrl = await createShareLink(couponCode);

    await dioService.postData("coupon/master", {
      "official_id": officialId,
      "cm_code": couponCode,
      "title": coupon.title,
      "description": coupon.description,
      "cm_url": couponUrl,
      "created_at": DateTime.now().toString(),
      "is_public": 0,
      "total_coupon": coupon.totalCoupon,
      "expire_on": coupon.expireOn.toString()
    });
  }

  addCouponUsers(String couponId, List<String> userIds) async {
    await dioService
        .postData("coupon/users", {"users": userIds, "cm_id": couponId});
    NotificationService notificationService = NotificationService();
    await notificationService.sendNotificationToGroupOfUser(
        GetStorage().read("official_name"),
        "Has gifted you a new coupon. Use this coupon and get offers and discounts.",
        userIds,
        {"type": "coupon"});
  }

  addCouponAccept(String userId, String couponCode) async {
    final response = await dioService
        .postData("coupon/accept", {"user_id": userId, "cm_code": couponCode});

    if (response != null) {
      return true;
    } else {
      return false;
    }
  }

  updateUserPoints(int points, String userId) async {
    await dioService
        .patchData("publicusers/points", {"user_id": userId, "points": points});
  }

  Future<String> createShareLink(String id) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://jaansay.page.link',
      link: Uri.parse('https://www.jaansay.com/coupon?id=$id'),
      androidParameters: AndroidParameters(
        packageName: 'com.dev.jaansay_public_user',
      ),
    );
    final dynamicUrl = await parameters.buildShortLink();
    return dynamicUrl.shortUrl.toString();
  }
}
