import 'package:get_storage/get_storage.dart';
import 'dio_service.dart';

class CustomerService {
  final officialId = GetStorage().read("official_id");
  DioService dioService = DioService();

  Future<bool> addCustomer({
    String phone,
    String name,
  }) async {
    final response = await dioService.postData("mycustomers/", {
      "official_id": officialId,
      "customers": [
        {
          "customer_name": name,
          "customer_phone": phone,
        }
      ]
    });
    if (response != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> searchCustomer(String phone) async {
    final response =
        await dioService.getData("publicusers/search/$officialId/$phone");
    if (response != null) {
      return response['data'][0]['user_name'];
    } else {
      return "";
    }
  }
}
