class InsuranceMaster {
  InsuranceMaster({
    this.insuranceTypes,
    this.userId,
    this.userName,
    this.userPhone,
    this.photo,
    this.tuId,
    this.tuName,
    this.tuPhone,
  });

  String insuranceTypes;
  int userId;
  String userName;
  String userPhone;
  String photo;
  int tuId;
  String tuName;
  String tuPhone;

  factory InsuranceMaster.fromJson(Map<String, dynamic> json) =>
      InsuranceMaster(
        insuranceTypes: json["insurance_types"],
        userId: json["user_id"] == null ? null : json["user_id"],
        userName: json["user_name"] == null ? null : json["user_name"],
        userPhone: json["user_phone"] == null ? null : json["user_phone"],
        photo: json["photo"] == null ? "no photo" : json["photo"],
        tuId: json["tu_id"] == null ? null : json["tu_id"],
        tuName: json["tu_name"] == null ? null : json["tu_name"],
        tuPhone: json["tu_phone"] == null ? null : json["tu_phone"],
      );

  Map<String, dynamic> toJson() => {
        "insurance_types": insuranceTypes,
        "user_id": userId == null ? null : userId,
        "user_name": userName == null ? null : userName,
        "user_phone": userPhone == null ? null : userPhone,
        "photo": photo == null ? null : photo,
        "tu_id": tuId == null ? null : tuId,
        "tu_name": tuName == null ? null : tuName,
        "tu_phone": tuPhone == null ? null : tuPhone,
      };
}

class Insurance {
  Insurance(
      {this.ilId,
      this.officialId,
      this.userId,
      this.createdAt,
      this.dateOfMaturity,
      this.amount,
      this.itId,
      this.accountNumber,
      this.dueInterval,
      this.isNotify,
      this.updatedAt,
      this.itName,
      this.term,
      this.status});

  int ilId;
  int officialId;
  int userId;
  DateTime createdAt;
  DateTime dateOfMaturity;
  String amount;
  int itId;
  String accountNumber;
  String dueInterval;
  int isNotify;
  DateTime updatedAt;
  String itName;
  String term;
  String status;

  factory Insurance.fromJson(Map<String, dynamic> json) => Insurance(
      ilId: json["il_id"],
      officialId: json["official_id"],
      userId: json["user_id"],
      createdAt: DateTime.parse(json["created_at"]),
      dateOfMaturity: DateTime.parse(json["date_of_maturity"]),
      amount: json["amount"],
      itId: json["it_id"],
      accountNumber: json["account_number"],
      dueInterval: json["due_interval"],
      isNotify: json["is_notify"],
      updatedAt: DateTime.parse(json["updated_at"]),
      itName: json["it_name"],
      term: json['term'].toString(),
      status: DateTime.parse(json["date_of_maturity"]).isBefore(DateTime.now())
          ? 'Closed'
          : 'Open');

  Map<String, dynamic> toJson() => {
        "il_id": ilId,
        "official_id": officialId,
        "user_id": userId,
        "created_at": createdAt.toIso8601String(),
        "date_of_maturity": dateOfMaturity.toIso8601String(),
        "amount": amount,
        "it_id": itId,
        "account_number": accountNumber,
        "due_interval": dueInterval,
        "is_notify": isNotify,
        "updated_at": updatedAt.toIso8601String(),
        "it_name": itName,
      };
}

class InsuranceType {
  InsuranceType({
    this.itId,
    this.itName,
    this.officialId,
    this.updatedAt,
  });

  int itId;
  String itName;
  int officialId;
  DateTime updatedAt;

  factory InsuranceType.fromJson(Map<String, dynamic> json) => InsuranceType(
        itId: json["it_id"],
        itName: json["it_name"],
        officialId: json["official_id"],
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "it_id": itId,
        "it_name": itName,
        "official_id": officialId,
        "updated_at": updatedAt.toIso8601String(),
      };
}

class InsuranceReport {
  InsuranceReport(
      {this.ilId,
      this.officialId,
      this.userId,
      this.createdAt,
      this.dateOfMaturity,
      this.amount,
      this.itId,
      this.accountNumber,
      this.dueInterval,
      this.isNotify,
      this.updatedAt,
      this.itName,
      this.userName,
      this.userPhone,
      this.photo,
      this.tuId,
      this.tuName,
      this.tuPhone,
      this.status});

  int ilId;
  int officialId;
  int userId;
  DateTime createdAt;
  DateTime dateOfMaturity;
  String amount;
  int itId;
  String accountNumber;
  String dueInterval;
  int isNotify;
  DateTime updatedAt;
  String itName;
  String userName;
  String userPhone;
  String photo;
  int tuId;
  String tuName;
  String tuPhone;
  String status;

  factory InsuranceReport.fromJson(Map<String, dynamic> json) =>
      InsuranceReport(
          ilId: json["il_id"],
          officialId: json["official_id"],
          userId: json["user_id"] == null ? null : json["user_id"],
          createdAt: DateTime.parse(json["created_at"]),
          dateOfMaturity: DateTime.parse(json["date_of_maturity"]),
          amount: json["amount"],
          itId: json["it_id"],
          accountNumber: json["account_number"],
          dueInterval: json["due_interval"],
          isNotify: json["is_notify"],
          updatedAt: DateTime.parse(json["updated_at"]),
          itName: json["it_name"],
          userName: json["user_name"] == null ? null : json["user_name"],
          userPhone: json["user_phone"] == null ? null : json["user_phone"],
          photo: json["photo"] == null ? null : json["photo"],
          tuId: json["tu_id"] == null ? null : json["tu_id"],
          tuName: json["tu_name"] == null ? null : json["tu_name"],
          tuPhone: json["tu_phone"] == null ? null : json["tu_phone"],
          status:
              DateTime.parse(json["date_of_maturity"]).isBefore(DateTime.now())
                  ? 'Closed'
                  : 'Open');

  Map<String, dynamic> toJson() => {
        "il_id": ilId,
        "official_id": officialId,
        "user_id": userId == null ? null : userId,
        "created_at": createdAt.toIso8601String(),
        "date_of_maturity": dateOfMaturity.toIso8601String(),
        "amount": amount,
        "it_id": itId,
        "account_number": accountNumber,
        "due_interval": dueInterval,
        "is_notify": isNotify,
        "updated_at": updatedAt.toIso8601String(),
        "it_name": itName,
        "user_name": userName == null ? null : userName,
        "user_phone": userPhone == null ? null : userPhone,
        "photo": photo == null ? null : photo,
        "tu_id": tuId == null ? null : tuId,
        "tu_name": tuName == null ? null : tuName,
        "tu_phone": tuPhone == null ? null : tuPhone,
      };
}
