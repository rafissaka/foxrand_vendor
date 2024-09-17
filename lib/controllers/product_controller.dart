import 'package:get/get.dart';
import 'package:vendor/models/addon_models.dart';

class ProductController extends GetxController {
  Map<String, dynamic>? productData = {"publish": false};
  getFormData({
    //Restaurant
    String? foodName,
    String? desc,
    String? foodCat,
    int? foodPrice,
    RxList<Addon>? addOns,
    String? addOnImage,
    String? addOnName,
    int? addOnPrice,
    String? foodUrl,
    String? productId,
    //Shop
    String? productName,
    String? category,
    String? description,
    DateTime? scheduleDate,
    String? brand,
    List? sizeList,
    String? otherDetails,
    String? unit,
    List? imageUrls,
    Map<String, dynamic>? seller,
  }) {
    //Restaurant

    if (seller != null) {
      productData!['seller'] = seller;
    }
    if (addOns != null) {
      productData!['addOns'] = addOns;
    }
    if (foodName != null) {
      productData!["foodName"] = foodName;
    }
    if (desc != null) {
      productData!["desc"] = desc;
    }
    if (foodCat != null) {
      productData!["foodCat"] = foodCat;
    }
    if (addOnImage != null) {
      productData!["addOnImage"] = addOnImage;
    }
    if (foodPrice != null) {
      productData!["foodPrice"] = foodPrice;
    }
    if (addOnPrice != null) {
      productData!["addOnPrice"] = addOnPrice;
    }
    if (addOnName != null) {
      productData!["addOnName"] = addOnName;
    }
    if (foodUrl != null) {
      productData!["foodUrl"] = foodUrl;
    }
    if (productId != null) {
      productData!["productId"] = productId;
    }
    //Shop

    if (productName != null) {
      productData!["productName"] = productName;
    }

    if (category != null) {
      productData!["category"] = category;
    }
    if (description != null) {
      productData!["description"] = description;
    }
    if (scheduleDate != null) {
      productData!["scheduleDate"] = scheduleDate;
    }
    if (brand != null) {
      productData!["brand"] = brand;
    }
    if (sizeList != null) {
      productData!["sizeList"] = sizeList;
    }
    if (otherDetails != null) {
      productData!["otherDetails"] = otherDetails;
    }
    if (unit != null) {
      productData!["unit"] = unit;
    }
    if (imageUrls != null) {
      productData!["imageUrls"] = imageUrls;
    }
    if (seller != null) {
      productData!["seller"] = seller;
    }
    update();
  }
}
