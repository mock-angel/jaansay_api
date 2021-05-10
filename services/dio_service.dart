import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData;
import 'package:get_storage/get_storage.dart';
import '../../constants/constants.dart';

class DioService {
  GetStorage box = GetStorage();

  Dio dio = new Dio(BaseOptions(headers: {
    HttpHeaders.authorizationHeader: "Bearer ${GetStorage().read("token")}",
  }, baseUrl: Constants.url));

  Future getData(String url,
      {String errorMessage = "Oops something went wrong"}) async {
    try {
      final response = await dio.get(
        url,
      );
      if (response.data["success"] && response.data['data'] != null) {
        return response.data;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      if (e is DioError) {
        if (e.type == DioErrorType.CONNECT_TIMEOUT) {
          Get.rawSnackbar(
              message:
                  "Internet unavailable. Please check your internet connection.");
        }
      }
      return null;
    }
  }

  Future postData(String url, Map data,
      {String errorMessage = "Oops something went wrong"}) async {
    try {
      final response = await dio.post(url, data: data);
      if (response.data["success"] && response.data['data'] != null) {
        return response.data;
      } else {
        return null;
      }
    } catch (e) {
      if (e is DioError) {
        if (e.type == DioErrorType.CONNECT_TIMEOUT) {
          Get.rawSnackbar(
              message:
                  "Internet unavailable. Please check your internet connection.");
        } else {
          Get.rawSnackbar(message: errorMessage);
        }
      } else {
        Get.rawSnackbar(message: errorMessage);
      }
      return null;
    }
  }

  Future postFormData(String url, FormData data,
      {String errorMessage = "Oops something went wrong"}) async {
    try {
      final response = await dio.post(
        url,
        data: data,
      );
      if (response.data["success"] && response.data['data'] != null) {
        return response.data;
      } else {
        return null;
      }
    } catch (e) {
      if (e is DioError) {
        if (e.type == DioErrorType.CONNECT_TIMEOUT) {
          Get.rawSnackbar(
              message:
                  "Internet unavailable. Please check your internet connection.");
        } else {
          Get.rawSnackbar(message: errorMessage);
        }
      } else {
        Get.rawSnackbar(message: errorMessage);
      }
      return null;
    }
  }

  Future patchData(String url, Map data,
      {String errorMessage = "Oops something went wrong"}) async {
    try {
      final response = await dio.patch(url, data: data);
      if (response.data["success"] && response.data['data'] != null) {
        return response.data;
      } else {
        return null;
      }
    } catch (e) {
      if (e is DioError) {
        if (e.type == DioErrorType.CONNECT_TIMEOUT) {
          Get.rawSnackbar(
              message:
                  "Internet unavailable. Please check your internet connection.");
        } else {
          Get.rawSnackbar(message: errorMessage);
        }
      } else {
        Get.rawSnackbar(message: errorMessage);
      }
      return null;
    }
  }

  Future patchFormData(String url, FormData data,
      {String errorMessage = "Oops something went wrong"}) async {
    try {
      final response = await dio.patch(
        url,
        data: data,
      );
      if (response.data["success"] && response.data['data'] != null) {
        return response.data;
      } else {
        return null;
      }
    } catch (e) {
      if (e is DioError) {
        if (e.type == DioErrorType.CONNECT_TIMEOUT) {
          Get.rawSnackbar(
              message:
                  "Internet unavailable. Please check your internet connection.");
        } else {
          Get.rawSnackbar(message: errorMessage);
        }
      } else {
        Get.rawSnackbar(message: errorMessage);
      }
      return null;
    }
  }

  Future deleteData(String url,
      {Map data = const {},
      String errorMessage = "Oops something went wrong"}) async {
    try {
      final response = await dio.delete(url, data: data);
      if (response.data["success"] && response.data['data'] != null) {
        return response.data;
      } else {
        return null;
      }
    } catch (e) {
      if (e is DioError) {
        if (e.type == DioErrorType.CONNECT_TIMEOUT) {
          Get.rawSnackbar(
              message:
                  "Internet unavailable. Please check your internet connection.");
        } else {
          Get.rawSnackbar(message: errorMessage);
        }
      } else {
        Get.rawSnackbar(message: errorMessage);
      }
      return null;
    }
  }
}
