class KeyMaster {
  KeyMaster(
      {this.kmId,
      this.name,
      this.description,
      this.ktId,
      this.isGeneral,
      this.optionIds,
      this.options,
      this.officialId,
      this.keyTypeName});

  int kmId;
  String name;
  String description;
  String keyTypeName;
  int ktId;
  int isGeneral;
  int officialId;
  List<int> optionIds;
  List<String> options;

  factory KeyMaster.fromJson(Map<String, dynamic> json) => KeyMaster(
      kmId: json["km_id"],
      name: json["name"],
      description: json["description"],
      ktId: json["kt_id"],
      isGeneral: json["is_general"],
      optionIds: json["option_ids"] == null
          ? []
          : json["option_ids"]
              .toString()
              .split(",")
              .map((e) => int.parse(e))
              .toList(),
      options:
          json["options"] == null ? [] : json["options"].toString().split(","),
      officialId: json["official_id"],
      keyTypeName: json["key_type_name"]);
}

class KeyType {
  KeyType({
    this.ktId,
    this.name,
  });

  int ktId;
  String name;

  factory KeyType.fromJson(Map<String, dynamic> json) => KeyType(
        ktId: json["kt_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "kt_id": ktId,
        "name": name,
      };
}

class KeyAnswer {
  KeyAnswer({
    this.kaId,
    this.koptId,
    this.answer,
    this.userName,
    this.photo,
    this.userPhone,
    this.tuId,
    this.tuPhone,
    this.tuName,
  });

  int kaId;
  int koptId;
  String answer;
  String userName;
  String photo;
  String userPhone;
  int tuId;
  String tuPhone;
  String tuName;

  factory KeyAnswer.fromJson(Map<String, dynamic> json) => KeyAnswer(
        kaId: json["ka_id"],
        koptId: json["kopt_id"],
        answer: json["answer"],
        userName: json["user_name"] == null ? null : json["user_name"],
        photo: json["photo"] == null ? null : json["photo"],
        userPhone: json["user_phone"] == null ? null : json["user_phone"],
        tuId: json["tu_id"] == null ? null : json["tu_id"],
        tuPhone: json["tu_phone"] == null ? null : json["tu_phone"],
        tuName: json["tu_name"] == null ? null : json["tu_name"],
      );
}

class AnswerCount {
  AnswerCount({
    this.koId,
    this.kmId,
    this.name,
    this.answerCount,
  });

  int koId;
  int kmId;
  String name;
  int answerCount;

  factory AnswerCount.fromJson(Map<String, dynamic> json) => AnswerCount(
        koId: json["ko_id"],
        kmId: json["km_id"],
        name: json["name"],
        answerCount: json["answer_count"],
      );

  Map<String, dynamic> toJson() => {
        "ko_id": koId,
        "km_id": kmId,
        "name": name,
        "answer_count": answerCount,
      };
}

class KeyOption {
  KeyOption({
    this.koId,
    this.kmId,
    this.name,
    this.officialId,
    this.status,
  });

  int koId;
  int kmId;
  String name;
  int officialId;
  int status;

  factory KeyOption.fromJson(Map<String, dynamic> json) => KeyOption(
        koId: json["ko_id"],
        kmId: json["km_id"],
        name: json["name"],
        officialId: json["official_id"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "ko_id": koId,
        "km_id": kmId,
        "name": name,
        "official_id": officialId,
        "status": status,
      };
}
