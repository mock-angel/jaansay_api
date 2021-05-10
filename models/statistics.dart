class Statistic {
  Statistic({
    this.likes,
    this.totalProfileVisitors,
    this.totalSurveySent,
    this.totalSurveyAnswers,
    this.totalFeedback,
    this.totalBroadcast,
    this.averageRating,
    this.totalRating,
    this.totalGrievances,
    this.totalFollowers,
    this.totalFeeds,
  });

  int likes;
  int totalProfileVisitors;
  int totalSurveySent;
  int totalSurveyAnswers;
  int totalFeedback;
  int totalBroadcast;
  int averageRating;
  int totalRating;
  int totalGrievances;
  int totalFollowers;
  int totalFeeds;

  factory Statistic.fromJson(List json) => Statistic(
        likes: json[0][0]["likes"] == null ? 0 : json[0][0]["likes"],
        totalProfileVisitors: json[1][0]["total_profile_visitors"] == null
            ? 0
            : json[1][0]["total_profile_visitors"],
        totalSurveySent: json[2][0]["total_survey_sent"] == null
            ? 0
            : json[2][0]["total_survey_sent"],
        totalSurveyAnswers: json[3] == null ? 0 : json[3].length,
        totalFeedback: json[4][0]["total_feedback"] == null
            ? 0
            : json[4][0]["total_feedback"],
        totalBroadcast: json[5][0]["total_broadcast"] == null
            ? 0
            : json[5][0]["total_broadcast"],
        averageRating: json[6][0]["average_rating"] == null
            ? 0
            : json[6][0]["average_rating"],
        totalRating:
            json[7][0]["total_rating"] == null ? 0 : json[7][0]["total_rating"],
        totalGrievances: json[8][0]["total_grievances"] == null
            ? 0
            : json[8][0]["total_grievances"],
        totalFollowers: json[9][0]["total_followers"] == null
            ? 0
            : json[9][0]["total_followers"],
        totalFeeds: json.length > 9 || json[10][0]["total_feeds"] == null
            ? 0
            : json[10][0]["total_feeds"],
      );
}
