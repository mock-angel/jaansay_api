class ProfileVisitor {
  int totalProfileVisits;
  int userId;
  String userName;
  String photo;
  String phone;
  int followId;

  ProfileVisitor(
      {this.totalProfileVisits,
      this.userId,
      this.userName,
      this.photo,
      this.phone,
      this.followId});

  factory ProfileVisitor.fromJson(Map<String, dynamic> json) => ProfileVisitor(
      photo: json['photo'],
      userName: json['user_name'],
      userId: json['user_id'],
      totalProfileVisits: json['total_profile_visits'],
      followId: json['follow_id'],
      phone: json["user_phone"]);
}
