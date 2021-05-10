import 'package:get_storage/get_storage.dart';
import '../models/profile_visitor.dart';
import '../models/statistics.dart';
import 'dio_service.dart';

class StatService {
  final officialId = GetStorage().read("official_id");
  DioService dioService = DioService();

  /// Officials
  getStatsForMonth(String month) async {
    final response = await dioService
        .getData("profilevisitors/month/$month/official/$officialId");
    if (response != null) {
      return Statistic.fromJson(response['data']);
    }
  }

  /// Officials
  Future<void> getProfileVisitors(
      List<ProfileVisitor> profileVisitors, String date) async {
    final response = await dioService.getData(
        "profilevisitors/month/$date/official/$officialId/profilevisitors");
    if (response != null) {
      return response['data']
          .map((val) => profileVisitors.add(ProfileVisitor.fromJson(val)))
          .toList();
    }
  }

  /// Admin: Gets statistics for specific month (yyyy-mm)
  ///
  /// [month] : is in the expected format yyyy-mm.
  getStatsForMonthAdmin(String month, String officialId) async {
    final response = await dioService
        .getData("profilevisitors/month/$month/official/$officialId");
    if (response != null) {
      return Statistic.fromJson(response['data']);
    }
  }

  /// Admin: Gets statistics for specific date (yyyy-mm-dd)
  ///
  /// [date] : is in the expected format yyyy-mm-dd.
  getStatsForDate(String date, String officialId) async {
    final response = await dioService
        .getData("profilevisitors/date/$date/official/$officialId");
    print("profilevisitors/date/$date/official/$officialId");
    if (response != null) {
      print(response);
      return Statistic.fromJson(response['data']);
    }
  }
}
