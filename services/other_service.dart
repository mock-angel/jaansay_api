import 'dio_service.dart';

class OtherService {
  DioService dioService = DioService();

  /// Gets list of all officials and their details.
  getBusinessTypes() async {
    final response = await dioService.getData("utility/allbusinesstypes");

    if (response != null) {
      print("printing response");
      print(response['data']);
      return response['data'];
    }
  }
}
