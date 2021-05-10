class GrievanceMaster {
  GrievanceMaster({
    this.id,
    this.message,
    this.ticketNumber,
    this.isPublic,
    this.isClosed,
    this.link,
    this.createdAt,
    this.officialsId,
    this.officialsName,
    this.officialsPhone,
    this.photo,
    this.typeName,
    this.userId,
    this.userName,
    this.userPhone,
    this.media,
    this.contentType,
  });

  int id;
  String message;
  String ticketNumber;
  int isPublic;
  int isClosed;
  String link;
  DateTime createdAt;
  int officialsId;
  String officialsName;
  String officialsPhone;
  String photo;
  String typeName;
  int userId;
  String userName;
  String userPhone;
  List<String> media;
  List<int> contentType;

  factory GrievanceMaster.fromJson(Map<String, dynamic> json) =>
      GrievanceMaster(
        id: json["id"],
        message: json["message"],
        ticketNumber: json["ticket_number"],
        isPublic: json["is_public"],
        isClosed: json["is_closed"],
        link: json["link"],
        createdAt: DateTime.parse(json["created_at"]),
        officialsId: json["officials_id"],
        officialsName: json["officials_name"],
        officialsPhone: json["officials_phone"],
        photo: json["photo"],
        typeName: json["type_name"],
        userId: json["user_id"],
        userName: json["user_name"],
        userPhone: json["user_phone"],
        media: json["media"] == null ? [] : json["media"].toString().split(","),
        contentType: json["content_type"] == null
            ? []
            : json["content_type"]
                .toString()
                .split(",")
                .map((e) => int.parse(e))
                .toList(),
      );
}

class GrievanceReply {
  GrievanceReply({
    this.message,
    this.createdAt,
    this.officialsId,
    this.officialsName,
    this.officialsPhoto,
    this.officialsPhone,
    this.userId,
    this.userName,
    this.userPhone,
    this.userPhoto,
    this.media,
    this.contentType,
  });

  String message;
  DateTime createdAt;
  int officialsId;
  String officialsName;
  String officialsPhoto;
  String officialsPhone;
  int userId;
  String userName;
  String userPhone;
  String userPhoto;
  List<String> media;
  List<int> contentType;

  factory GrievanceReply.fromJson(Map<String, dynamic> json) => GrievanceReply(
        message: json["message"],
        createdAt: DateTime.parse(json["created_at"]),
        officialsId: json["officials_id"] == null ? null : json["officials_id"],
        officialsName:
            json["officials_name"] == null ? null : json["officials_name"],
        officialsPhoto:
            json["officials_photo"] == null ? null : json["officials_photo"],
        officialsPhone:
            json["officials_phone"] == null ? null : json["officials_phone"],
        userId: json["user_id"] == null ? null : json["user_id"],
        userName: json["user_name"] == null ? null : json["user_name"],
        userPhone: json["user_phone"] == null ? null : json["user_phone"],
        userPhoto: json["user_photo"] == null ? null : json["user_photo"],
        media: json["media"] == null ? [] : json["media"].toString().split(","),
        contentType: json["content_type"] == null
            ? []
            : json["content_type"]
                .toString()
                .split(",")
                .map((e) => int.parse(e))
                .toList(),
      );
}
