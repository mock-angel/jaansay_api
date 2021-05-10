class Coupon {
  Coupon({
    this.cmId,
    this.officialId,
    this.cmCode,
    this.title,
    this.description,
    this.cmUrl,
    this.createdAt,
    this.expireOn,
    this.totalCoupon,
    this.couponCount,
    this.isPublic,
  });

  int cmId;
  int officialId;
  String cmCode;
  String title;
  String description;
  String cmUrl;
  DateTime createdAt;
  DateTime expireOn;
  int totalCoupon;
  int couponCount;
  int isPublic;

  factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
        cmId: json["cm_id"],
        officialId: json["official_id"],
        cmCode: json["cm_code"],
        title: json["title"],
        description: json["description"],
        cmUrl: json["cm_url"],
        totalCoupon: json['total_coupon'],
        couponCount: json['coupon_count'],
        isPublic: json['is_public'],
        createdAt: DateTime.parse(json["created_at"]),
        expireOn: DateTime.parse(
          json["expire_on"],
        ),
      );
}

class CouponUser {
  CouponUser({
    this.cuId,
    this.cuCreatedAt,
    this.caCreatedAt,
    this.userId,
    this.userName,
    this.userPhone,
    this.photo,
    this.tuId,
    this.tuName,
    this.tuPhone,
  });

  int cuId;
  DateTime cuCreatedAt;
  DateTime caCreatedAt;
  int userId;
  String userName;
  String userPhone;
  String photo;
  int tuId;
  String tuName;
  String tuPhone;

  factory CouponUser.fromJson(Map<String, dynamic> json) => CouponUser(
        cuId: json["cu_id"],
        cuCreatedAt: DateTime.parse(json["cu_created_at"]),
        caCreatedAt: json["ca_created_at"] == null
            ? null
            : DateTime.parse(json["ca_created_at"]),
        userId: json["user_id"] == null ? null : json["user_id"],
        userName: json["user_name"] == null ? null : json["user_name"],
        userPhone: json["user_phone"] == null ? null : json["user_phone"],
        photo: json["photo"] == null ? null : json["photo"],
        tuId: json["tu_id"] == null ? null : json["tu_id"],
        tuName: json["tu_name"] == null ? null : json["tu_name"],
        tuPhone: json["tu_phone"] == null ? null : json["tu_phone"],
      );

  Map<String, dynamic> toJson() => {
        "cu_id": cuId,
        "cu_created_at": cuCreatedAt.toIso8601String(),
        "ca_created_at":
            caCreatedAt == null ? null : caCreatedAt.toIso8601String(),
        "user_id": userId == null ? null : userId,
        "user_name": userName == null ? null : userName,
        "user_phone": userPhone == null ? null : userPhone,
        "photo": photo == null ? null : photo,
        "tu_id": tuId == null ? null : tuId,
        "tu_name": tuName == null ? null : tuName,
        "tu_phone": tuPhone == null ? null : tuPhone,
      };
}
