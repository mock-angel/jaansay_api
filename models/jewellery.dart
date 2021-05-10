class GoldRate {
  GoldRate({
    this.jgrId,
    this.officialId,
    this.goldRate,
    this.updatedAt,
  });

  int jgrId;
  int officialId;
  String goldRate;
  DateTime updatedAt;

  factory GoldRate.fromJson(Map<String, dynamic> json) => GoldRate(
        jgrId: json["jgr_id"],
        officialId: json["official_id"],
        goldRate: json["gold_rate"],
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "jgr_id": jgrId,
        "official_id": officialId,
        "gold_rate": goldRate,
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Rate {
  Rate({
    this.jrId,
    this.officialId,
    this.goldRate,
    this.silverRate,
    this.updatedAt,
  });

  int jrId;
  int officialId;
  int goldRate;
  int silverRate;
  DateTime updatedAt;

  factory Rate.fromJson(Map<String, dynamic> json) => Rate(
        jrId: json["jr_id"],
        officialId: json["official_id"],
        goldRate: json["gold_rate"],
        silverRate: json["silver_rate"],
        updatedAt: DateTime.parse(json["updated_at"]),
      );
}

class SilverRate {
  SilverRate({
    this.jgrId,
    this.officialId,
    this.silverRate,
    this.updatedAt,
  });

  int jgrId;
  int officialId;
  String silverRate;
  DateTime updatedAt;

  factory SilverRate.fromJson(Map<String, dynamic> json) => SilverRate(
        jgrId: json["jgr_id"],
        officialId: json["official_id"],
        silverRate: json["silver_rate"],
        updatedAt: DateTime.parse(json["updated_at"]),
      );
}

class JewelleryGroup {
  JewelleryGroup({
    this.jgId,
    this.groupName,
    this.officialId,
    this.details,
    this.updatedAt,
  });

  int jgId;
  String groupName;
  int officialId;
  String details;
  DateTime updatedAt;

  factory JewelleryGroup.fromJson(Map<String, dynamic> json) => JewelleryGroup(
        jgId: json["jg_id"],
        groupName: json["group_name"],
        officialId: json["official_id"],
        details: json["details"],
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "jg_id": jgId,
        "group_name": groupName,
        "official_id": officialId,
        "details": details,
        "updated_at": updatedAt.toIso8601String(),
      };
}

class JewelleryGroupMember {
  JewelleryGroupMember({
    this.userName,
    this.userPhone,
    this.photo,
    this.tuName,
    this.tuPhone,
    this.schemeNumber,
  });

  String userName;
  String userPhone;
  String photo;
  dynamic tuName;
  dynamic tuPhone;
  String schemeNumber;

  factory JewelleryGroupMember.fromJson(Map<String, dynamic> json) =>
      JewelleryGroupMember(
        userName: json["user_name"],
        userPhone: json["user_phone"],
        photo: json["photo"] == null ? "no photo" : json["photo"],
        tuName: json["tu_name"],
        tuPhone: json["tu_phone"],
        schemeNumber: json["scheme_number"],
      );

  Map<String, dynamic> toJson() => {
        "user_name": userName,
        "user_phone": userPhone,
        "photo": photo,
        "tu_name": tuName,
        "tu_phone": tuPhone,
        "scheme_number": schemeNumber,
      };
}

class JewelleryWinning {
  JewelleryWinning({
    this.jgId,
    this.groupName,
    this.jlwId,
    this.schemeNumber,
    this.isSent,
    this.userName,
    this.userPhone,
    this.photo,
    this.tuName,
    this.tuPhone,
  });

  int jgId;
  String groupName;
  int jlwId;
  String schemeNumber;
  int isSent;
  String userName;
  String userPhone;
  String photo;
  dynamic tuName;
  dynamic tuPhone;

  factory JewelleryWinning.fromJson(Map<String, dynamic> json) =>
      JewelleryWinning(
        jgId: json["jg_id"],
        groupName: json["group_name"],
        jlwId: json["jlw_id"] == null ? null : json["jlw_id"],
        schemeNumber:
            json["scheme_number"] == null ? null : json["scheme_number"],
        isSent: json["is_sent"] == null ? null : json["is_sent"],
        userName: json["user_name"] == null ? null : json["user_name"],
        userPhone: json["user_phone"] == null ? null : json["user_phone"],
        photo: json["photo"] == null ? null : json["photo"],
        tuName: json["tu_name"],
        tuPhone: json["tu_phone"],
      );

  Map<String, dynamic> toJson() => {
        "jg_id": jgId,
        "group_name": groupName,
        "jlw_id": jlwId == null ? null : jlwId,
        "scheme_number": schemeNumber == null ? null : schemeNumber,
        "is_sent": isSent == null ? null : isSent,
        "user_name": userName == null ? null : userName,
        "user_phone": userPhone == null ? null : userPhone,
        "photo": photo == null ? null : photo,
        "tu_name": tuName,
        "tu_phone": tuPhone,
      };
}
