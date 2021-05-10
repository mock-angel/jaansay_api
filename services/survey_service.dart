import 'package:get_storage/get_storage.dart';
import 'package:jaansay_officials/api/models/customer.dart';
import 'package:jaansay_officials/api/models/survey.dart';
import 'package:jaansay_officials/api/services/dio_service.dart';
import 'package:jaansay_officials/api/services/notification_service.dart';

class SurveyService {
  final officialId = GetStorage().read("official_id");
  DioService dioService = DioService();

  Future<bool> sendSurvey(List surveyDetails, List<Customer> followers) async {
    final response = await dioService.postData("survey/", {
      "official_id": officialId,
      "survey_title": surveyDetails[0],
      "survey_description": surveyDetails[1],
      "updated_at": DateTime.now().toString(),
      "survey_questions": surveyDetails[2].map((e) {
        int index = surveyDetails[2].indexOf(e);
        return {"question": e, "question_options": surveyDetails[3][index]};
      }).toList(),
    });

    if (response != null) {
      final userSurveyResponse = await dioService.postData("survey/users", {
        "survey_id": response['survey_id'].toString(),
        "survey_users": followers.map((e) {
          print(e.userId);
          return e.userId.toString();
        }).toList(),
      });

      if (userSurveyResponse != null) {
        final messageSurveyResponse =
            await dioService.postData("survey/message", {
          "sender_id": officialId,
          "official_id": officialId,
          "message": "${surveyDetails[0]}: ${surveyDetails[1]}",
          "users": followers.map((e) {
            return e.userId.toString();
          }).toList(),
          "survey_id": response['survey_id'].toString(),
          "type": "4",
          "updated_at": DateTime.now().toString(),
        });

        if (messageSurveyResponse != null) {
          NotificationService notificationService = NotificationService();
          await notificationService.sendNotificationToGroupOfUser(
              GetStorage().read("official_name"),
              surveyDetails[0],
              followers.map((e) {
                return e.userId.toString();
              }).toList(),
              {"type": "message"});
          return true;
        }
      }
    }
    return false;
  }

  Future<bool> sendGroupSurvey(
      String surveyTitle,
      String surveyDescription,
      List<String> _questions,
      List<List<String>> _options,
      List<String> users) async {
    final response = await dioService.postData("survey/", {
      "official_id": officialId,
      "survey_title": surveyTitle,
      "survey_description": surveyDescription,
      "updated_at": DateTime.now().toString(),
      "survey_questions": _questions.map((e) {
        int index = _questions.indexOf(e);
        return {"question": e, "question_options": _options[index]};
      }).toList(),
    });

    if (response != null) {
      final userSurveyResponse = await dioService.postData("survey/users", {
        "survey_id": response['survey_id'].toString(),
        "survey_users": users,
      });

      if (userSurveyResponse != null) {
        final messageSurveyResponse =
            await dioService.postData("survey/message", {
          "sender_id": officialId,
          "official_id": officialId,
          "message": "$surveyTitle: $surveyDescription",
          "users": users,
          "survey_id": response['survey_id'].toString(),
          "type": "4",
          "updated_at": DateTime.now().toString(),
        });

        if (messageSurveyResponse != null) {
          NotificationService notificationService = NotificationService();
          await notificationService.sendNotificationToGroupOfUser(
              GetStorage().read("official_name"),
              surveyTitle,
              users,
              {"type": "message"});
          return true;
        }
      }
    }
    return false;
  }

  Future<void> getAllSurveysMonth(
      List<SurveyMaster> surveyMasters, String date) async {
    final response =
        await dioService.getData("survey/allsurvey/$officialId/month/$date");

    if (response != null) {
      response['data'].map((val) {
        surveyMasters.add(SurveyMaster.fromJson(val));
      }).toList();
    }
  }

  Future<void> getSurvey(List<Survey> surveys, String surveyId) async {
    final response = await dioService.getData("survey/$surveyId");

    if (response != null) {
      response['data'].map((val) {
        surveys.add(Survey.fromJson(val));
      }).toList();
    }
  }

  getSurveyAnswers(List<SurveyAnswer> surveyAnswers, String surveyId) async {
    final response =
        await dioService.getData("survey/allsurvey/$surveyId/answers");

    if (response != null) {
      response['data'].map((val) {
        surveyAnswers.add(SurveyAnswer.fromJson(val));
      }).toList();
    }
  }
}
