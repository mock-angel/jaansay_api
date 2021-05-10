class Customer {
  Customer({
    this.score,
    this.userId,
    this.userName,
    this.userPhone,
    this.photo,
    this.tuId,
    this.tuPhone,
    this.tuName,
    this.medium,
    this.optionId,
    this.optionName,
    this.keyMasterId,
  });

  int score;
  int userId;
  String userName;
  String userPhone;
  String photo;
  int tuId;
  String tuPhone;
  String tuName;
  String medium;
  List<int> optionId;
  List<String> optionName;
  List<int> keyMasterId;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        score: json["score"],
        userId: json["user_id"] == null ? null : json["user_id"],
        userName: json["user_name"] == null ? null : json["user_name"],
        userPhone: json["user_phone"] == null ? null : json["user_phone"],
        photo: json["photo"] == null ? null : json["photo"],
        tuId: json["tu_id"] == null ? null : json["tu_id"],
        tuPhone: json["tu_phone"] == null ? null : json["tu_phone"],
        tuName: json["tu_name"] == null ? null : json["tu_name"],
        medium: json["medium"] == null ? null : json["medium"],
        optionId: json["option_id"] == null
            ? []
            : json["option_id"]
                .toString()
                .split(",")
                .map((e) => int.parse(e))
                .toList(),
        optionName: json["option_name"] == null
            ? []
            : json["option_name"].toString().split(","),
        keyMasterId: json["key_master_id"] == null
            ? []
            : json["key_master_id"]
                .toString()
                .split(",")
                .map((e) => int.parse(e))
                .toList(),
      );
}

class FollowUser {
  FollowUser({
    this.userName,
    this.userPhone,
    this.userGender,
    this.userDob,
  });

  String userName;
  String userPhone;
  String userGender;
  String userDob;

  factory FollowUser.fromJson(Map<String, dynamic> json) => FollowUser(
        userName: json["user_name"],
        userPhone: json["user_phone"],
        userGender: json["user_gender"],
        userDob: json["user_dob"],
      );

  Map<String, dynamic> toJson() => {
        "user_name": userName,
        "user_phone": userPhone,
        "user_gender": userGender ?? "",
        "user_dob": userDob ?? "",
        "medium": 'IN APP'
      };
}

class CustomerDocument {
  CustomerDocument({
    this.douId,
    this.userName,
    this.photo,
    this.userPhone,
    this.docName,
    this.docUrl,
  });

  int douId;
  String userName;
  String photo;
  String userPhone;
  String docName;
  String docUrl;

  factory CustomerDocument.fromJson(Map<String, dynamic> json) =>
      CustomerDocument(
        douId: json["dou_id"],
        userName: json["user_name"],
        photo: json["photo"],
        userPhone: json["user_phone"],
        docName: json["doc_name"],
        docUrl: json["doc_url"],
      );

  Map<String, dynamic> toJson() => {
        "dou_id": douId,
        "user_name": userName,
        "photo": photo,
        "user_phone": userPhone,
        "doc_name": docName,
        "doc_url": docUrl,
      };
}
