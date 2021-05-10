import 'package:get_storage/get_storage.dart';
import 'package:jaansay_officials/api/models/group.dart';
import 'package:jaansay_officials/api/services/dio_service.dart';

class GroupService {
  final officialId = GetStorage().read("official_id");
  DioService dioService = DioService();

  GetStorage box = GetStorage();

  //Ranks
  getAllRanks(List<Rank> ranks) async {
    final response =
        await dioService.getData("groups/allranks/official/$officialId");

    if (response != null) {
      response['data'].map((e) {
        ranks.add(Rank.fromJson(e));
      }).toList();
    } else {}
  }

  addRank(String rankName) async {
    await dioService.postData("groups/addrank", {
      "rank_name": rankName,
      "official_id": officialId,
      "updated_at": DateTime.now().toString()
    });
  }

  editRank(String rankName, Rank rank) async {
    await dioService.postData("groups/updaterank", {
      "rank_name": rankName,
      "official_id": rank.officialId.toString(),
      "updated_at": DateTime.now().toString(),
      "rank_id": rank.rankId.toString()
    });
  }

  deleteRank(Rank rank) async {
    await dioService.deleteData("groups/deleterank",
        data: {"rank_id": rank.rankId.toString()});
  }

  //Groups
  getGroups(List<Group> groups, String rankId, String upperGroupId,
      String tier) async {
    final response = await dioService.getData(
        "groups/allgroups/rank/$rankId/official/$officialId/tier/$tier/uppergroup/$upperGroupId");

    if (response != null) {
      response['data'].map((e) {
        groups.add(Group.fromJson(e));
      }).toList();
    }
  }

  addGroup(String groupName, String groupDescription, String rankId,
      String tier, String upperGroupId, String refId) async {
    await dioService.postData("groups/addgroup", {
      "group_name": groupName,
      "group_description": groupDescription,
      "official_id": officialId,
      "rank_id": rankId,
      "tier": tier,
      "upper_group_id": upperGroupId,
      "updated_at": DateTime.now().toString(),
      "ref_id": refId
    });
  }

  editGroup(String groupName, String groupDescription, Group group) async {
    await dioService.patchData("groups/allgroups/group", {
      "group_name": groupName,
      "group_description": groupDescription,
      "official_id": officialId,
      "rank_id": group.rankId.toString(),
      "tier": group.tier.toString(),
      "upper_group_id": group.upperGroupId.toString(),
      "updated_at": DateTime.now().toString(),
      "group_id": group.groupId.toString()
    });
  }

  deleteGroup(Group group) async {
    await dioService.deleteData("groups/allgroups/group",
        data: {"group_id": group.groupId.toString()});
  }

  //Group Members
  getGroupMembers(List<GroupMember> groupMembers, String groupId) async {
    final response = await dioService.getData("groups/allusers/group/$groupId");

    if (response != null) {
      response['data'].map((e) {
        groupMembers.add(GroupMember.fromJson(e));
      }).toList();
    }
  }

  addGroupMember(String userId, String designationId, String groupId) async {
    await dioService.postData("groups/addusers", {
      "group_id": groupId,
      "users": [
        {"user_id": userId, "designation_id": designationId},
      ],
      "updated_at": DateTime.now().toString()
    });
  }

  editGroupMember(String designationId, GroupMember groupMember) async {
    dioService.patchData("groups/allgroups/group/groupuser", {
      "group_id": groupMember.groupId.toString(),
      "user_id": groupMember.userId.toString(),
      "designation_id": designationId.toString(),
      "updated_at": DateTime.now().toString(),
      "gu_id": groupMember.guId.toString()
    });
  }

  deleteGroupMember(String memberId) async {
    await dioService
        .deleteData("groups/allusers/groupuser", data: {"gu_id": memberId});
  }

  //Designation
  getAllDesignations(List<Designation> designations) async {
    final response = await dioService
        .getData("groups/allusers/designation/official/$officialId");

    if (response != null) {
      response['data'].map((e) {
        designations.add(Designation.fromJson(e));
      }).toList();
    }
  }

  //Group Misc
  getAllGroupUsers(List references, List designations) async {
    final response = await dioService.postData("groups/allgroups/allusers",
        {"references": references, "designation_list": designations});
    if (response != null) {
      return response['data'].split(",");
    } else {
      return [];
    }
  }

  Future<List<String>> getAllRankUsers(List<String> ranks) async {
    final response = await dioService.postData("groups/allgroups/rank/allusers",
        {"official_id": officialId.toString(), "rank_list": ranks});

    if (response != null) {
      return response['data'][0]['users'].split(",");
    } else {
      return [];
    }
  }
}
