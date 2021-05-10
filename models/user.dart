class User {
  var userId;
  var userName;
  var userGender;
  var userDob;
  var userPincode;
  var userPhone;
  var photo;
  var panchayatName;
  var typeName;
  var isFollow;

  User(
      {this.userId,
      this.userName,
      this.userGender,
      this.userDob,
      this.userPincode,
      this.userPhone,
      this.photo,
      this.panchayatName,
      this.typeName,
      this.isFollow});

  User.fromMap(Map<String, dynamic> map) {
    this.userId = map['user_id'];
    this.userName = map['user_name'];
    this.userGender = map['user_gender'];
    this.userDob = map['user_dob'];
    this.userPincode = map['user_pincode'];
    this.userPhone = map['user_phone'];
    this.photo = map['photo'];
    this.panchayatName = map['panchayat_name'];
    this.typeName = map['type_name'];
    this.isFollow = map['is_follow'];
  }
}
