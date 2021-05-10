import 'package:get_storage/get_storage.dart';
import 'package:jaansay_officials/api/models/customer.dart';
import 'package:jaansay_officials/api/services/dio_service.dart';

class FollowService {
  final officialId = GetStorage().read("official_id");
  DioService dioService = DioService();

  getFollowers(List<Customer> followers, String searchVal, int page) async {
    final response = await dioService.getData(
        "follow/$officialId/search/${searchVal.length == 0 ? 'ALL' : searchVal}/page/$page");
    if (response != null) {
      response['data']
          .map((val) => followers.add(Customer.fromJson(val)))
          .toList();
      return response['next'];
    } else {
      return null;
    }
  }

  getAllFollowers(List<Customer> followers) async {
    final response = await dioService.getData("follow/$officialId");
    if (response != null) {
      response['data']
          .map((val) => followers.add(Customer.fromJson(val)))
          .toList();
      return response['next'];
    } else {
      return null;
    }
  }

  getInAppFollowers(List<Customer> followers) async {
    final response = await dioService.getData("follow/app/$officialId");
    if (response != null) {
      response['data']
          .map((val) => followers.add(Customer.fromJson(val)))
          .toList();
      return;
    } else {
      return null;
    }
  }

  getFollowersByInsuranceType(
      List<Customer> followers, String insuranceType) async {
    final response = await dioService
        .getData("follow/$officialId/insurancetype/$insuranceType");
    if (response != null) {
      response['data']
          .map((val) => followers.add(Customer.fromJson(val)))
          .toList();
      return response['next'];
    } else {
      return null;
    }
  }

  Future<String> searchFollower(String phone) async {
    final response =
        await dioService.getData("publicusers/search/$officialId/$phone");
    if (response != null) {
      return response['data'][0]['user_name'];
    } else {
      return "";
    }
  }

  followUser(List<FollowUser> users) async {
    await dioService.postData("follow/addfollowers", {
      "official_id": "$officialId",
      "users": users.map((e) {
        return e.toJson();
      }).toList(),
      "is_follow": "1",
      "updated_at": DateTime.now().toString(),
      "send_sms": "1",
    });
  }

  Future<void> getFollowersByMonth(List<Customer> followers) async {
    final response = await dioService.getData("follow/$officialId");
    if (response != null) {
      return response['data']
          .map((val) => followers.add(Customer.fromJson(val)))
          .toList();
    } else {
      return null;
    }
  }

  getAllDocuments(List<CustomerDocument> customerDocuments) async {
    final response = await dioService.getData(
        "documents/alldocuments/documentsforapproval/official/$officialId");
    if (response != null) {
      response['data']
          .map((val) => customerDocuments.add(CustomerDocument.fromJson(val)))
          .toList();
    } else {
      return null;
    }
  }

  updateDocumentStatus(String docId, String isVerified) async {
    final response = await dioService.patchData("documents/verifyuserdocument",
        {"dou_id": docId, "is_verified": isVerified, "message": "Good"});
    if (response != null) {
      return;
    } else {
      return;
    }
  }
}
