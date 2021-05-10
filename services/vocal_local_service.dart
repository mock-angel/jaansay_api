import '../models/vocal_local.dart';
import 'dio_service.dart';

class VocalLocalService {
  DioService dioService = DioService();

  getAllVocalLocal(List<VocalLocal> vocalLocals) async {
    final response = await dioService.getData("vocalforlocal");
    if (response != null) {
      response['data'].map((e) {
        vocalLocals.add(VocalLocal.fromJson(e));
      }).toList();
    }
  }
}
