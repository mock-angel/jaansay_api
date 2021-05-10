class FeedbackMaster {
  FeedbackMaster({
    this.id,
    this.officialId,
    this.message,
    this.createdAt,
    this.mediaUrls,
    this.contentTypes,
  });

  int id;
  int officialId;
  String message;
  DateTime createdAt;
  List<String> mediaUrls;
  List<int> contentTypes;

  factory FeedbackMaster.fromJson(Map<String, dynamic> json) => FeedbackMaster(
        id: json["id"],
        officialId: json["official_id"],
        message: json["message"],
        createdAt: DateTime.parse(json["created_at"]),
        mediaUrls: json["media_urls"] == null
            ? []
            : json["media_urls"].toString().split(","),
        contentTypes: json["content_types"] == null
            ? []
            : json["content_types"]
                .toString()
                .split(",")
                .map((e) => int.parse(e))
                .toList(),
      );
}

class FeedbackAnswer {
  FeedbackAnswer({
    this.id,
    this.masterId,
    this.userId,
    this.message,
    this.userName,
    this.photo,
    this.userPhone,
    this.tuId,
    this.tuPhone,
    this.tuName,
  });

  int id;
  int masterId;
  int userId;
  String message;
  String userName;
  String photo;
  String userPhone;
  int tuId;
  String tuPhone;
  String tuName;

  factory FeedbackAnswer.fromJson(Map<String, dynamic> json) => FeedbackAnswer(
        id: json["id"],
        masterId: json["master_id"],
        userId: json["user_id"],
        message: json["message"],
        userName: json["user_name"],
        photo: json["photo"],
        userPhone: json["user_phone"],
        tuId: json["tu_id"],
        tuPhone: json["tu_phone"],
        tuName: json["tu_name"],
      );
}
