class QRCodeData {
  QRCodeData({this.userId, this.code, this.type});

  String userId;
  String code;
  String type;

  factory QRCodeData.fromJson(Map<String, dynamic> json) => QRCodeData(
      userId: json['user_id'], code: json['code'], type: json['type']);
}
