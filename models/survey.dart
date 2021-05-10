class Survey {
  Survey({
    this.sqId,
    this.surveyId,
    this.sqQuestion,
    this.soId,
    this.soOption,
  });

  int sqId;
  int surveyId;
  String sqQuestion;
  List soId;
  List soOption;

  factory Survey.fromJson(Map<String, dynamic> json) => Survey(
        sqId: json["sq_id"],
        surveyId: json["survey_id"],
        sqQuestion: json["sq_question"],
        soId: json["so_id"].toString().split(",").toList(),
        soOption: json["so_option"].toString().split(",").toList(),
      );

  Map<String, dynamic> toJson() => {
        "sq_id": sqId,
        "survey_id": surveyId,
        "sq_question": sqQuestion,
        "so_id": soId,
        "so_option": soOption,
      };
}

class SurveyMaster {
  SurveyMaster({
    this.surveyId,
    this.surveyTitle,
    this.surveyDescription,
    this.officialId,
    this.updatedAt,
    this.totalUsers,
  });

  int surveyId;
  String surveyTitle;
  String surveyDescription;
  int officialId;
  DateTime updatedAt;
  int totalUsers;

  factory SurveyMaster.fromJson(Map<String, dynamic> json) => SurveyMaster(
        surveyId: json["survey_id"],
        surveyTitle: json["survey_title"],
        surveyDescription: json["survey_description"],
        officialId: json["official_id"],
        updatedAt: DateTime.parse(json["updated_at"]),
        totalUsers: json["total_users"] == null
            ? 0
            : json['total_users'].toString().split(",").length,
      );
}

class SurveyAnswer {
  int optionId;
  int answerCount;

  SurveyAnswer({this.optionId, this.answerCount});

  factory SurveyAnswer.fromJson(Map<String, dynamic> json) =>
      SurveyAnswer(answerCount: json['answers'], optionId: json['options']);
}
