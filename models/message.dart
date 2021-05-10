import '../../constants/constants.dart';

class MessageMaster {
  MessageMaster(
      {this.mmId,
      this.userId,
      this.userName,
      this.userPhone,
      this.photo,
      this.message,
      this.messageType});

  int mmId;
  int userId;
  String userName;
  String userPhone;
  String photo;
  String message;
  int messageType;

  factory MessageMaster.fromJson(Map<String, dynamic> json) => MessageMaster(
      mmId: json["mm_id"],
      userId: json["user_id"],
      userName: json["user_name"],
      userPhone: json["user_phone"],
      photo: json["photo"],
      message: json['message'],
      messageType: json['message_type']);
}

class Message {
  Message({
    this.messageId,
    this.mmId,
    this.message,
    this.userId,
    this.updatedAt,
    this.surveyId,
    this.type,
    this.messageType,
    this.userName,
    this.photo,
    this.officialsName,
  });

  int messageId;
  int mmId;
  String message;
  int userId;
  DateTime updatedAt;
  String surveyId;
  CustomMessageType type;
  CustomContentType messageType;
  String userName;
  String photo;
  String officialsName;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        messageId: json["message_id"],
        mmId: json["mm_id"],
        message: json["message"],
        userId: json["user_id"],
        updatedAt: DateTime.parse(json["updated_at"])
            .add(Duration(hours: 5, minutes: 30)),
        surveyId:
            json["survey_id"] == null ? null : json['survey_id'].toString(),
        type: CustomMessageType.values[json["type"]],
        messageType: CustomContentType.values[json["message_type"]],
        userName: json["user_name"] == null ? null : json["user_name"],
        photo: json["photo"] == null ? null : json["photo"],
        officialsName:
            json["officials_name"] == null ? null : json["officials_name"],
      );
}

class TemplateMessage {
  TemplateMessage(
      {this.tmId,
      this.message,
      this.tmtId,
      this.updatedAt,
      this.isSelected,
      this.parameter,
      this.templateId,
      this.header,
      this.name});

  int tmId;
  String message;
  int tmtId;
  DateTime updatedAt;
  int isSelected;
  int parameter;
  String templateId;
  String header;
  String name;

  factory TemplateMessage.fromJson(Map<String, dynamic> json) =>
      TemplateMessage(
          tmId: json["tm_id"],
          message: json["message"],
          tmtId: json["tmt_id"],
          updatedAt: DateTime.parse(json["updated_at"]),
          isSelected: json["is_selected"],
          parameter: json["parameter"],
          templateId: json['template_id'],
          name: json['template_name'],
          header: json['header']);

  Map<String, dynamic> toJson() => {
        "tm_id": tmId,
        "message": message,
        "tmt_id": tmtId,
        "updated_at": updatedAt.toIso8601String(),
        "is_selected": isSelected,
      };
}

class TemplateParameter {
  TemplateParameter({
    this.tpId,
    this.tpName,
    this.tmtId,
  });

  int tpId;
  String tpName;
  int tmtId;

  factory TemplateParameter.fromJson(Map<String, dynamic> json) =>
      TemplateParameter(
        tpId: json["tp_id"],
        tpName: json["tp_name"],
        tmtId: json["tmt_id"],
      );

  Map<String, dynamic> toJson() => {
        "tp_id": tpId,
        "tp_name": tpName,
        "tmt_id": tmtId,
      };
}

class SMSCount {
  SMSCount({
    this.scId,
    this.total,
    this.sent,
    this.updatedAt,
    this.createdAt,
    this.officialId,
  });

  int scId;
  int total;
  int sent;
  DateTime updatedAt;
  DateTime createdAt;
  int officialId;

  factory SMSCount.fromJson(Map<String, dynamic> json) => SMSCount(
        scId: json["sc_id"],
        total: json["total"],
        sent: json["remaining"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        officialId: json["official_id"],
      );

  Map<String, dynamic> toJson() => {
        "sc_id": scId,
        "total": total,
        "remaining": sent,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "official_id": officialId,
      };
}
