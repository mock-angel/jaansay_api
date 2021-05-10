class Rank {
  Rank({
    this.rankId,
    this.rankName,
    this.officialId,
    this.updatedAt,
  });

  int rankId;
  String rankName;
  int officialId;
  DateTime updatedAt;

  factory Rank.fromJson(Map<String, dynamic> json) => Rank(
        rankId: json["rank_id"],
        rankName: json["rank_name"],
        officialId: json["official_id"],
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "rank_id": rankId,
        "rank_name": rankName,
        "official_id": officialId,
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Group {
  Group(
      {this.groupId,
      this.groupName,
      this.groupDescription,
      this.rankId,
      this.officialId,
      this.tier,
      this.upperGroupId,
      this.updatedAt,
      this.refId});

  int groupId;
  String groupName;
  String groupDescription;
  int rankId;
  int officialId;
  int tier;
  int upperGroupId;
  dynamic refId;
  DateTime updatedAt;

  factory Group.fromJson(Map<String, dynamic> json) => Group(
      groupId: json["group_id"],
      groupName: json["group_name"],
      groupDescription: json["group_description"],
      rankId: json["rank_id"],
      officialId: json["official_id"],
      tier: json["tier"],
      upperGroupId: json["upper_group_id"],
      updatedAt: DateTime.parse(json["updated_at"]),
      refId: json["ref_id"]);

  Map<String, dynamic> toJson() => {
        "group_id": groupId,
        "group_name": groupName,
        "group_description": groupDescription,
        "rank_id": rankId,
        "official_id": officialId,
        "tier": tier,
        "upper_group_id": upperGroupId,
        "updated_at": updatedAt.toIso8601String(),
      };
}

class GroupMember {
  GroupMember({
    this.guId,
    this.userId,
    this.groupId,
    this.designationId,
    this.updatedAt,
    this.designation,
    this.level,
    this.userName,
    this.userPhone,
    this.photo,
    this.tuName,
    this.tuPhone,
  });

  int guId;
  int userId;
  int groupId;
  int designationId;
  DateTime updatedAt;
  String designation;
  int level;
  String userName;
  String userPhone;
  String photo;
  String tuName;
  String tuPhone;

  factory GroupMember.fromJson(Map<String, dynamic> json) => GroupMember(
        guId: json["gu_id"],
        userId: json["user_id"],
        groupId: json["group_id"],
        designationId: json["designation_id"],
        updatedAt: DateTime.parse(json["updated_at"]),
        designation: json["designation"],
        level: json["level"],
        userName: json["user_name"],
        userPhone: json["user_phone"],
        photo: json["photo"] ?? 'no photo',
        tuName: json["tu_name"],
        tuPhone: json["tu_phone"],
      );

  Map<String, dynamic> toJson() => {
        "gu_id": guId,
        "user_id": userId,
        "group_id": groupId,
        "designation_id": designationId,
        "updated_at": updatedAt.toIso8601String(),
        "designation": designation,
        "level": level,
        "user_name": userName,
        "user_phone": userPhone,
        "photo": photo,
        "tu_name": tuName,
        "tu_phone": tuPhone,
      };
}

class Designation {
  Designation({
    this.designationId,
    this.designation,
    this.officialId,
    this.level,
    this.updatedAt,
  });

  int designationId;
  String designation;
  int officialId;
  int level;
  DateTime updatedAt;

  factory Designation.fromJson(Map<String, dynamic> json) => Designation(
        designationId: json["designation_id"],
        designation: json["designation"],
        officialId: json["official_id"],
        level: json["level"],
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "designation_id": designationId,
        "designation": designation,
        "official_id": officialId,
        "level": level,
        "updated_at": updatedAt.toIso8601String(),
      };
}
