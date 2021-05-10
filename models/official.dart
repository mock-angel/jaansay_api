class Official {
  Official({
    this.officialsId,
    this.officialsName,
    this.officialsDescription,
    this.officialsEmail,
    this.officialsPhone,
    this.officialsDesignation,
    this.lattitude,
    this.longitude,
    this.officialsAddress,
    this.officialsWebsite,
    this.businessHours,
    this.photo,
    this.averageRating,
    this.totalRating,
    this.typeName,
    this.businesstypeName,
    this.isFollow,
    this.isRating,

    //Officials
    this.isPrivate,
    this.typeId,
    this.businesstypeId,
    this.isReferral,
    this.profileLink,
  });

  int officialsId;
  String officialsName;
  String officialsDescription;
  String officialsEmail;
  String officialsPhone;
  String officialsDesignation;
  String lattitude;
  String longitude;
  String officialsAddress;
  String officialsWebsite;
  String businessHours;
  String photo;
  double averageRating;
  int totalRating;
  String typeName;
  String businesstypeName;
  dynamic isFollow;
  int isRating;

  // Officials
  int isPrivate;
  int typeId;
  int businesstypeId;
  int isReferral;
  String profileLink;

  factory Official.fromJson(Map<String, dynamic> json) => Official(
        officialsId: json["officials_id"],
        officialsName: json["officials_name"],
        officialsDescription: json["officials_description"],
        officialsEmail: json["officials_email"],
        officialsPhone: json["officials_phone"],
        officialsDesignation: json["officials_designation"],
        lattitude: json["lattitude"],
        longitude: json["longitude"],
        officialsAddress: json["officials_address"],
        officialsWebsite: json["officials_website"],
        businessHours: json["business_hours"],
        photo: json["photo"] == null ? 'no photo' : json["photo"],
        averageRating: json["average_rating"] == null
            ? 0
            : json["average_rating"].toDouble(),
        totalRating: json["total_rating"],
        typeName: json["type_name"],
        businesstypeName: json["businesstype_name"],
        isFollow: json["is_follow"],
        isRating: json["is_rating"],

        //Officials
        typeId: json["type_id"],
        businesstypeId: json["businesstype_id"],
        isReferral: json["rm_id"] ?? 0,
        isPrivate: json["is_private"],
        profileLink: json['profile_link'],
      );

  // -- Admin app
  Map<String, dynamic> toJson() => {
        "officials_id": officialsId,
        "officials_name": officialsName,
        "officials_description": officialsDescription,
        "officials_email": officialsEmail,
        "officials_phone": officialsPhone,
        "officials_designation": officialsDesignation,
        "lattitude": lattitude,
        "longitude": longitude,
        "officials_address": officialsAddress,
        "officials_website": officialsWebsite,
        "business_hours": businessHours,
        "photo": photo,
        "average_rating": averageRating,
        "total_rating": totalRating,
        "type_name": typeName,
        "businesstype_name": businesstypeName,
        "is_follow": isFollow,
        "is_rating": isRating,

        //Officials
        "type_id": typeId,
        "businesstype_id": businesstypeId,
        "rm_id": isReferral,
        "is_private": isPrivate,
        "profile_link": profileLink,
      };
}

// From officials
class OfficialUtility {
  OfficialUtility({
    this.utilityId,
    this.utilityName,
  });

  int utilityId;
  String utilityName;

  factory OfficialUtility.fromJson(Map<String, dynamic> json) =>
      OfficialUtility(
        utilityId: json["utility_id"],
        utilityName: json["utility_name"],
      );
}
