import 'package:get_storage/get_storage.dart';
import 'package:jaansay_officials/api/models/insurance.dart';
import 'package:jaansay_officials/api/services/dio_service.dart';

class InsuranceService {
  final officialId = GetStorage().read("official_id");
  DioService dioService = DioService();

  getInsuranceMasters(List<InsuranceMaster> insuranceMasters, String searchVal,
      int page) async {
    final response = await dioService.getData(
        "insurance/allinsurances/official/$officialId/search/${searchVal.length == 0 ? 'ALL' : searchVal}/page/$page");
    if (response != null) {
      response['data'].map((e) {
        insuranceMasters.add(InsuranceMaster.fromJson(e));
      }).toList();
      return response['next'];
    }
    return null;
  }

  getUserInsurances(List<Insurance> insurances, String userId, String year,
      String insuranceType) async {
    final response = await dioService.getData(
        "insurance/allinsurances/user/$userId/official/$officialId/year/${year + '-01-01'}/insurancetype/$insuranceType");
    print(response);
    if (response != null) {
      response['data'].map((e) {
        insurances.add(Insurance.fromJson(e));
      }).toList();
    }
  }

  addUserInsurance(Insurance insurance) async {
    await dioService.postData("insurance/addinsurance", {
      "official_id": officialId.toString(),
      "user_id": insurance.userId.toString(),
      "created_at": insurance.createdAt.toString(),
      "date_of_maturity": insurance.dateOfMaturity.toString(),
      "amount": insurance.amount.toString(),
      "it_id": insurance.itId.toString(),
      "account_number": insurance.accountNumber.toString(),
      "due_interval": insurance.dueInterval.toString(),
      "is_notify": insurance.isNotify.toString(),
      "term": insurance.term.toString(),
    });
  }

  addPolicyType(String policyName) async {
    await dioService.postData("insurance/addinsurancetype",
        {"official_id": officialId, "it_name": policyName});
  }

  updateUserInsurance(Insurance insurance) async {
    await dioService.patchData("insurance/updateinsurance", {
      "official_id": officialId.toString(),
      "user_id": insurance.userId.toString(),
      "created_at": insurance.createdAt.toString(),
      "date_of_maturity": insurance.dateOfMaturity.toString(),
      "amount": insurance.amount.toString(),
      "it_id": insurance.itId.toString(),
      "account_number": insurance.accountNumber.toString(),
      "due_interval": insurance.dueInterval.toString(),
      "is_notify": insurance.isNotify.toString(),
      "il_id": insurance.ilId.toString(),
      "term": insurance.term.toString(),
    });
  }

  deleteUserInsurance(String insuranceId) async {
    await dioService.deleteData("insurance/deleteinsurance",
        data: {"il_id": insuranceId.toString()});
  }

  getInsuranceTypes(List<InsuranceType> insuranceTypes) async {
    final response = await dioService
        .getData("insurance/allinsurancetypes/official/$officialId");
    if (response != null) {
      response['data'].map((e) {
        insuranceTypes.add(InsuranceType.fromJson(e));
      }).toList();
      return;
    }
  }

  getInsurancesByMonth(
      List<InsuranceReport> insurances, String date, String typeId) async {
    final response = await dioService.getData(
        "insurance/allinsurances/month/$date/official/$officialId/insurancetype/$typeId");
    if (response != null) {
      response['data'].map((e) {
        insurances.add(InsuranceReport.fromJson(e));
      }).toList();
      return;
    }
  }
}
