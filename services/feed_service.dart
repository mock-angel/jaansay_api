import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get_storage/get_storage.dart';
import '../models/feed.dart';
import '../models/customer.dart';
import '../models/user.dart';
import 'dio_service.dart';
import 'follow_service.dart';
import 'notification_service.dart';
import '../../utils/misc_utils.dart';

class FeedService {
  final officialId = GetStorage().read("official_id");
  DioService dioService = DioService();

  Future<bool> addFeed(
      var files, String description, int regionId, int categoryId) async {
    String feedId = MiscUtils.getRandomId(12);
    String shareLink = await createShareLink(feedId);
    List<File> compressedFiles = [];
    Directory directory = await getTemporaryDirectory();

    final formData = FormData.fromMap({
      "feed_id": "$feedId",
      "feed_title": "$shareLink",
      "feed_description": description.length == 0 ? '' : description,
      "user_id": officialId.toString(),
      "doc_id": "1",
      "region_id": regionId,
      "category_id": categoryId,
      "updated_at": "${DateTime.now()}",
    });

    for (int i = 0; i < files.length; i++) {
      var result = await FlutterImageCompress.compressAndGetFile(files[i].path,
          (directory.path + '/' + files[i].name).toString().replaceAll(" ", ""),
          minWidth: 1000,
          minHeight: 1000,
          quality: 80,
          format: files[i].extension == 'png'
              ? CompressFormat.png
              : CompressFormat.jpeg);
      compressedFiles.add(result);
      formData.files.addAll([
        MapEntry(
          "media",
          await MultipartFile.fromFile(
            compressedFiles[i].path,
            filename: (DateTime.now().toString() +
                    i.toString() +
                    officialId.toString() +
                    compressedFiles[i].path.toString())
                .toString()
                .replaceAll(" ", ""),
          ),
        ),
      ]);
    }

    final response = await dioService.postFormData("feeds", formData);

    if (response != null) {
      FollowService followService = FollowService();
      NotificationService notificationService = NotificationService();
      List<Customer> customers = [];
      await followService.getInAppFollowers(
        customers,
      );
      await notificationService.sendNotificationToGroupOfUser(
          GetStorage().read("official_name"),
          "A new post has been added",
          customers.map((e) => e.userId.toString()).toList(),
          {"type": "feed"});

      return true;
    }
    return false;
  }

  Future<String> createShareLink(String id) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://jaansay.page.link',
      link: Uri.parse('https://www.jaansay.com/feed?id=$id'),
      androidParameters: AndroidParameters(
        packageName: 'com.dev.jaansay_public_user',
      ),
    );
    final dynamicUrl = await parameters.buildShortLink();
    return dynamicUrl.shortUrl.toString();
  }

  getFeed(List<Feed> feeds, int page) async {
    final response = await dioService.getData("feeds/$officialId/page/$page");
    if (response != null) {
      response['data'].map((val) => feeds.add(Feed.fromJson(val))).toList();
      return response['next'];
    } else {
      return null;
    }
  }

  getFeedLikes(List<User> users, String feedId) async {
    final response = await dioService.getData("feeds/$feedId/likedusers");
    if (response != null) {
      response['data'].map((val) => users.add(User.fromMap(val))).toList();
    }
  }

  deleteFeed(String feedId) async {
    await dioService.deleteData("feeds/$feedId");
  }

  getFeedByMonth(String date, List<Feed> feeds, int page) async {
    final response =
        await dioService.getData("feeds/$officialId/month/$date/page/$page");
    if (response != null) {
      response['data'].map((val) => feeds.add(Feed.fromJson(val))).toList();
      return response['next'];
    } else {
      return null;
    }
  }

  getFeedFilters(List<FeedFilter> feedFilters) async {
    final response = await dioService.getData("feeds/filters");
    if (response != null) {
      response['data']
          .map((val) => feedFilters.add(FeedFilter.fromJson(val)))
          .toList();
    }
  }
}
