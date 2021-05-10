import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get_storage/get_storage.dart';
import '../models/review.dart';
import 'dio_service.dart';
import '../models/official.dart';

class OfficialService {
  // -- Commons
  final officialId = GetStorage().read("official_id");
  DioService dioService = DioService();

  // -- Official app
  getOfficialProfile() async {
    final response =
        await dioService.getData("officials/$officialId/$officialId");
    if (response != null) {
      return Official.fromJson(response['data']);
    }
  }

  getReviews(List<Review> reviews) async {
    final response = await dioService.getData("ratings/$officialId");

    if (response != null) {
      response['data'].map((val) => reviews.add(Review.fromJson(val))).toList();
    }
  }

  Future<void> getReviewsByMonth(List<Review> reviews, String date) async {
    final response =
        await dioService.getData("ratings/$officialId/month/$date");

    if (response != null) {
      response['data'].map((val) => reviews.add(Review.fromJson(val))).toList();
    }
  }

  updatePasscode(String passcode) async {
    await dioService.patchData("officials/passcode", {
      "officials_phone": GetStorage().read("official_phone"),
      "passcode": passcode
    });
  }

  // -- Admin app
  /// Gets list of all officials and their details.
  getAllOfficials(List<Official> officials) async {
    final response = await dioService.getData("officials");

    if (response != null) {
      response['data'].map((officialJson) {
        officials.add(Official.fromJson(officialJson));
      }).toList();
      return;
    }
  }

  Future<Map<String, String>> _updateProfileLink(
      String referenceId, String officialId) async {
    String profileLink = await _createOfficialLink(officialId);
    Map<String, String> map = {
      'reference_id': referenceId,
      'profile_link': profileLink
    };
    await dioService.patchData("officials/updateprofilelink", map);
    return map;
  }

  Future<String> _createOfficialLink(String id) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://jaansay.page.link',
      link: Uri.parse('https://www.jaansay.com/official?id=$id'),
      androidParameters: AndroidParameters(
        packageName: 'com.dev.jaansay_public_user',
      ),
    );
    final dynamicUrl = await parameters.buildShortLink();
    return dynamicUrl.shortUrl.toString();
  }

  String _generatePassCode() {
    int min = 100000;
    int max = 999999;
    Random random = new Random();
    int randomNumber = min + random.nextInt(max - min);
    return randomNumber.toString();
  }

  Future<Map<String, String>> addOfficial(
      String name,
      String description,
      String email,
      String phone,
      String latitude,
      String longitude,
      String address,
      String pinCode,
      String website,
      String businessHour,
      File photo,
      int typeId,
      int businessTypeId) async {
    final formData = FormData.fromMap({
      "officials_name": name,
      "officials_description": description,
      "officials_email": email,
      "officials_phone": phone,
      "officials_pincode": pinCode,
      "lattitude": latitude,
      "longitude": longitude,
      "officials_address": address,
      "officials_website": website,
      "business_hours": businessHour,
      "type_id": typeId.toString(),
      "businesstype_id": businessTypeId.toString(),
      "updated_at": DateTime.now().toString(),
      "passcode": _generatePassCode(),
    });

    if (photo != null) {
      formData.files.add(
        MapEntry(
          "media",
          await MultipartFile.fromFile(
            photo.path,
            filename: (DateTime.now().toString() +
                    "1" +
                    officialId.toString() +
                    photo.path.toString())
                .toString()
                .replaceAll(" ", ""),
          ),
        ),
      );
    }

    final response = await dioService.postFormData("officials", formData);

    if (response != null) {
      return await _updateProfileLink(
          response['data']['reference_id'].toString(),
          response['data']['official_id'].toString());
    }
  }
}
