import 'package:get_storage/get_storage.dart';
import 'package:jaansay_officials/constants/constants.dart';
import 'package:jaansay_officials/api/models/customer.dart';
import 'package:jaansay_officials/api/models/jewellery.dart';
import 'package:jaansay_officials/api/models/message.dart';
import 'package:jaansay_officials/api/services/dio_service.dart';
import 'package:jaansay_officials/api/services/follow_service.dart';
import 'package:jaansay_officials/api/services/group_message_service.dart';

class JewelleryService {
  final officialId = GetStorage().read("official_id");
  DioService dioService = DioService();

  getRate() async {
    final response =
        await dioService.getData("jewellery/todaysrate/official/$officialId");
    if (response != null && response['data'].length > 0) {
      return Rate.fromJson(response['data']);
    }
  }

  updateRate(String goldRate, String silverRate, String message) async {
    final response = await dioService.patchData("jewellery/todaysrate", {
      "official_id": officialId,
      "gold_rate": goldRate,
      "silver_rate": silverRate,
      "updated_at": DateTime.now().toString()
    });

    if (response != null) {
      FollowService followService = FollowService();
      List<Customer> followers = [];
      await followService.getAllFollowers(followers);
    }
  }

  selectTemplateMessage(String messageId) async {
    await dioService.patchData("templatemessages/selectedmessage",
        {"official_id": officialId, "tm_id": messageId});
  }

  createGroup(String groupName, String details) async {
    await dioService.postData("jewellery/creategroup", {
      "official_id": officialId,
      "group_name": groupName,
      "details": details
    });
  }

  deleteGroup(String jgId) async {
    await dioService.deleteData("jewellery/deletegroup", data: {"jg_id": jgId});
  }

  editGroup(
      String groupName, String details, JewelleryGroup jewelleryGroup) async {
    await dioService.patchData("jewellery/updategroup", {
      "official_id": officialId,
      "group_name": groupName,
      "details": details,
      "jg_id": jewelleryGroup.jgId.toString()
    });
  }

  getGroups(List<JewelleryGroup> jewelleryGroups) async {
    final response =
        await dioService.getData("jewellery/allgroups/official/$officialId");
    if (response != null) {
      response['data'].map((e) {
        jewelleryGroups.add(JewelleryGroup.fromJson(e));
      }).toList();
    }
  }

  addGroupMember(String groupId, String userId, String schemeNumber) async {
    await dioService.postData("jewellery/addusers", {
      "group_id": groupId,
      "users": [
        {"user_id": userId, "scheme_number": schemeNumber},
      ]
    });
  }

  removeGroupMember(String groupId, String schemeNumber) async {
    await dioService.deleteData("jewellery/group/removeuser",
        data: {"group_id": groupId, "scheme_number": schemeNumber});
  }

  getJewelleryGroupMembers(
      List<JewelleryGroupMember> jewelleryGroupMembers, String groupId) async {
    final response = await dioService
        .getData("jewellery/allgroups/groupmembers/group/$groupId");
    if (response != null) {
      response['data'].map((e) {
        jewelleryGroupMembers.add(JewelleryGroupMember.fromJson(e));
      }).toList();
    }
  }

  getJewelleryWinnings(
      List<JewelleryWinning> jewelleryWinning, String date) async {
    final response = await dioService
        .getData("jewellery/lotterywinners/month/$date/official/$officialId");
    if (response != null) {
      response['data'].map((e) {
        jewelleryWinning.add(JewelleryWinning.fromJson(e));
      }).toList();
    }
  }

  addJewelleryWinner(String groupId, String schemeNumber, String date) async {
    await dioService.postData("jewellery/lotterywinners", {
      "group_id": groupId,
      "scheme_number": schemeNumber,
      'updated_at': date
    });
  }

  updateJewelleryWinner(
      String jwlId, String schemeNumber, String isSent) async {
    await dioService.patchData("jewellery/lotterywinners",
        {"jlw_id": jwlId, "scheme_number": schemeNumber, "is_sent": isSent});
  }

  getAllGroupMembers(List<Customer> customers) async {
    final response = await dioService
        .getData("jewellery/allgroups/groupmembers/official/$officialId");
    if (response != null) {
      response['data'].map((e) {
        customers.add(Customer.fromJson(e));
      }).toList();
    }
  }

  sendWinningMessage(
      TemplateMessage templateMessage,
      List<JewelleryWinning> jewelleryWinnings,
      List<Customer> customers) async {
    GroupMessageService groupMessageService = GroupMessageService();
    await groupMessageService.broadcastTemplate(templateMessage, [], customers,
        CustomMessageType.PRIVATE, DateTime.now());
    jewelleryWinnings.map((e) async {
      if (e.jlwId != null) {
        await updateJewelleryWinner(
            e.jlwId.toString(), e.schemeNumber.toString(), "1");
      }
    }).toList();
  }
}
