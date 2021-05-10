class VocalLocal {
  VocalLocal({
    this.vflId,
    this.userId,
    this.shopName,
    this.lattitude,
    this.longitude,
    this.phone,
    this.userName,
    this.userPhone,
    this.userPassword,
    this.districtId,
    this.photo,
    this.typeId,
  });

  int vflId;
  int userId;
  String shopName;
  String lattitude;
  String longitude;
  String phone;
  String userName;
  String userPhone;
  String userPassword;
  int districtId;
  String photo;
  int typeId;

  factory VocalLocal.fromJson(Map<String, dynamic> json) => VocalLocal(
        vflId: json["vfl_id"],
        userId: json["user_id"],
        shopName: json["shop_name"],
        lattitude: json["lattitude"],
        longitude: json["longitude"],
        phone: json["phone"],
        userName: json["user_name"],
        userPhone: json["user_phone"],
        userPassword: json["user_password"],
        districtId: json["district_id"],
        photo: json["photo"],
        typeId: json["type_id"],
      );

  Map<String, dynamic> toJson() => {
        "vfl_id": vflId,
        "user_id": userId,
        "shop_name": shopName,
        "lattitude": lattitude,
        "longitude": longitude,
        "phone": phone,
        "user_name": userName,
        "user_phone": userPhone,
        "user_password": userPassword,
        "district_id": districtId,
        "photo": photo,
        "type_id": typeId,
      };
}
