import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jaansay_officials/api/models/catalog.dart';
import 'package:jaansay_officials/api/services/dio_service.dart';
import 'package:jaansay_officials/api/services/notification_service.dart';
import 'package:jaansay_officials/utils/misc_utils.dart';

class CatalogService {
  final officialId = GetStorage().read("official_id");
  DioService dioService = DioService();

  getAllCategories(List<Category> categories) async {
    final response = await dioService.getData("catalog/category/$officialId");
    if (response != null) {
      response['data']
          .map((e) => categories.add(Category.fromJson(e)))
          .toList();
    }
  }

  getProducts(
      List<Product> products, int ccId, String searchVal, int page) async {
    final response = await dioService.getData(
        "catalog/product/official/$officialId/category/$ccId/${searchVal.length == 0 ? 'ALL' : searchVal}/$page");
    if (response != null) {
      response['data'].map((e) => products.add(Product.fromJson(e))).toList();
      return response['next'];
    }
    return null;
  }

  getFeaturedProducts(List<Product> products) async {
    final response =
        await dioService.getData("catalog/product/featured/$officialId");
    if (response != null) {
      response['data'].map((e) => products.add(Product.fromJson(e))).toList();
    }
  }

  getAllOrdersByOfficial(List<Order> orders) async {
    final response =
        await dioService.getData("catalog/order/official/$officialId");
    if (response != null) {
      response['data'].map((e) => orders.add(Order.fromJson(e))).toList();
    }
  }

  getOrderDetails(String orderId, List<OrderDetail> orderDetails) async {
    final response = await dioService.getData("catalog/order/$orderId");
    if (response != null) {
      response['data']
          .map((e) => orderDetails.add(OrderDetail.fromJson(e)))
          .toList();
    }
  }

  updateOrderStatus(Order order) async {
    await dioService.patchData(
        "catalog/order", {"status_id": order.statusId, "id": order.id});
    NotificationService notificationService = NotificationService();
    await notificationService.sendNotificationToUser(
        "Order ${order.statusName}",
        "Your order with order ID: ${order.orderId.toUpperCase()} from ${GetStorage().read("official_name")} has been ${order.statusName}",
        order.userId.toString(),
        {"type": "order"});
  }

  addCategory(Category category, File image) async {
    String randomID = MiscUtils.getRandomId(6);

    final formData = FormData.fromMap({
      "cc_name": category.ccName,
      "official_id": officialId,
      "created_at": DateTime.now().toString(),
    });

    if (image != null) {
      formData.files.add(MapEntry(
          'media',
          await MultipartFile.fromFile(
            image.path,
            filename:
                "$randomID${officialId.toString().replaceAll(" ", "")}${DateTime.now().toString().replaceAll(" ", "")}.png",
          )));
    }
    await dioService.postFormData("catalog/category", formData);
  }

  addProduct(Product product, List<File> images) async {
    String productId = MiscUtils.getRandomId(12);
    String productUrl = await createShareLink(productId);

    final formData = FormData.fromMap({
      "cp_id": productId,
      "cc_id": product.ccId,
      "cp_cost": product.cpCost,
      "cp_discountCost": product.cpDiscountCost,
      "cp_description": product.cpDescription,
      "cp_name": product.cpName,
      "cp_priority": product.cpPriority,
      "cp_stock": product.cpStock,
      "cp_hide": product.cpHide,
      "official_id": officialId,
      "created_at": DateTime.now().toString(),
      "cp_url": productUrl
    });

    for (int i = 0; i < images.length; i++) {
      String randomID = MiscUtils.getRandomId(6);

      formData.files.add(
        MapEntry(
          'media',
          await MultipartFile.fromFile(
            images[i].path,
            filename:
                "$randomID${officialId.toString().replaceAll(" ", "")}${DateTime.now().toString().replaceAll(" ", "")}.png",
          ),
        ),
      );
    }

    await dioService.postFormData("catalog/product", formData);
  }

  addProductPhotos(String cpId, List<File> images) async {
    final formData = FormData.fromMap({
      "cp_id": cpId,
    });

    for (int i = 0; i < images.length; i++) {
      String randomID = MiscUtils.getRandomId(6);

      formData.files.add(
        MapEntry(
          'media',
          await MultipartFile.fromFile(
            images[i].path,
            filename:
                "$randomID${officialId.toString().replaceAll(" ", "")}${DateTime.now().toString().replaceAll(" ", "")}.png",
          ),
        ),
      );
    }
    await dioService.postFormData("catalog/productphoto", formData);
  }

  Future<String> createShareLink(String id) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://jaansay.page.link',
      link: Uri.parse('https://www.jaansay.com/product?id=$id'),
      androidParameters: AndroidParameters(
        packageName: 'com.dev.jaansay_public_user',
      ),
    );
    final dynamicUrl = await parameters.buildShortLink();
    return dynamicUrl.shortUrl.toString();
  }

  updateCategory(Category category, File image) async {
    String randomID = MiscUtils.getRandomId(6);
    String fileName =
        "$randomID${officialId.toString().replaceAll(" ", "")}${DateTime.now().toString().replaceAll(" ", "")}.png";

    final formData = FormData.fromMap({
      "cc_name": category.ccName,
      "cc_photo": category.ccPhoto.length == 0 ? fileName : category.ccPhoto,
      "cc_id": category.ccId,
    });

    if (image != null) {
      formData.files.add(MapEntry(
          'media',
          await MultipartFile.fromFile(
            image.path,
            filename: (category.ccPhoto.length == 0 && image == null)
                ? ''
                : category.ccPhoto.length == 0
                    ? fileName
                    : category.ccPhoto,
          )));
    }
    await dioService.patchFormData("catalog/category", formData);
  }

  updateProduct(Product product, List<File> image) async {
    final formData = FormData.fromMap({
      "cc_id": product.ccId,
      "cp_cost": product.cpCost,
      "cp_discountCost": product.cpDiscountCost,
      "cp_description": product.cpDescription,
      "cp_name": product.cpName,
      "cp_priority": product.cpPriority,
      "cp_stock": product.cpStock,
      "cp_hide": product.cpHide,
      "cp_id": product.cpId,
    });
    await dioService.patchFormData("catalog/product", formData);
  }

  deleteCategory(int ccId) async {
    await dioService.deleteData("catalog/category", data: {'cc_id': ccId});
  }

  deleteProduct(String cpId) async {
    await dioService.deleteData("catalog/product", data: {'cp_id': cpId});
  }

  deleteProductPhoto(int cpmId) async {
    await dioService
        .deleteData("catalog/productphoto", data: {'cpm_id': cpmId});
  }
}
