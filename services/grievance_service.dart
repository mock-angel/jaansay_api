import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jaansay_officials/api/models/grievance.dart';
import 'package:jaansay_officials/api/services/dio_service.dart';

class GrievanceService {
  final officialId = GetStorage().read("official_id");
  DioService dioService = DioService();

  getAlLGrievances(List<GrievanceMaster> grievanceMasters) async {
    final response =
        await dioService.getData("grievances/official/$officialId");
    if (response != null) {
      response['data']
          .map((val) => grievanceMasters.add(GrievanceMaster.fromJson(val)))
          .toList();
    }
  }

  getAlLGrievancesByMasterId(
      List<GrievanceReply> grievanceReply, String masterId) async {
    final response = await dioService.getData("grievances/reply/$masterId");
    if (response != null) {
      response['data']
          .map((val) => grievanceReply.add(GrievanceReply.fromJson(val)))
          .toList();
    }
  }

  updateGrievance({int isPublic, int isClosed, int gmId}) async {
    await dioService.patchData("grievances/master",
        {"is_public": isPublic, "is_closed": isClosed, "gm_id": gmId});
  }

  addReply(List<File> files, String message, String gmId) async {
    final formData = FormData.fromMap({
      "message": message,
      "user_id": officialId,
      "gm_id": gmId,
      "content_type": 1
    });

    for (int i = 0; i < files.length; i++) {
      formData.files.addAll([
        MapEntry(
          "media",
          await MultipartFile.fromFile(
            files[i].path,
            filename: (DateTime.now().toString() +
                    i.toString() +
                    officialId.toString() +
                    files[i].path.toString())
                .toString()
                .replaceAll(" ", ""),
          ),
        ),
      ]);
    }

    await dioService.postFormData("grievances/reply", formData);
  }
}
