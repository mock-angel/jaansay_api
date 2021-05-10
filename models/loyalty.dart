class LoyaltyMaster {
  LoyaltyMaster({
    this.id,
    this.officialId,
    this.pointPerRupees,
    this.updatedAt,
  });

  int id;
  int officialId;
  double pointPerRupees;
  DateTime updatedAt;

  factory LoyaltyMaster.fromJson(Map<String, dynamic> json) => LoyaltyMaster(
        id: json["id"],
        officialId: json["official_id"],
        pointPerRupees: json["point_per_rupees"].toDouble(),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "official_id": officialId,
        "point_per_rupees": pointPerRupees,
        "updated_at": updatedAt.toIso8601String(),
      };
}
