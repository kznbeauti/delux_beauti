import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kozarni_ecome/controller/home_controller.dart';
import 'package:uuid/uuid.dart';

import '../../../data/constant.dart';
import '../../../model/review.dart';
import '../../../model/user.dart';
import '../../../service/database.dart';

enum RC {
  Excellent,
  Good,
  Average,
  BelowAverage,
  Poor,
}

class ProductDetailController extends GetxController {
  final Database _database = Database();
  final HomeController homeController = Get.find();
  var ratingMap = {
    RC.Excellent: 0,
    RC.Good: 0,
    RC.Average: 0,
    RC.BelowAverage: 0,
    RC.Poor: 0,
  }.obs;
  //**For Review */
  final TextEditingController ratingController = TextEditingController();
  final TextEditingController reviewController = TextEditingController();
/*   RxList<Review> reviewsList = <Review>[].obs; */
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var isWritingReviewLoading = false.obs;
  var rating = 0.0.obs;
  var rateError = false.obs;
  var reviewError = false.obs;
  var firstTimePressed = false.obs;

  void changeRating(double value) {
    rating.value = value;
    ratingController.text = value.toString();
  }

  Future<void> writeReiew(String productId, AuthUser currentUser) async {
    firstTimePressed.value = true;
    if (isWritingReviewLoading.value) {
      return;
    }
    if (checkValidate()) {
      isWritingReviewLoading.value = true;
      final review = Review(
        id: Uuid().v1(),
        productId: productId,
        user: currentUser,
        rating: rating.value,
        reviewMessage: reviewController.text,
        dateTime: DateTime.now(),
      );
      try {
        await _database.write(
          reviewCollection,
          path: review.id,
          data: review.toJson(),
        );
        await updateRating(productId);
        isWritingReviewLoading.value = false;
        clearAll();
        /* reviewsList.add(review);
        reviewsList
            .sort((v1, v2) => v1.dateTime.millisecondsSinceEpoch.compareTo(
                  v2.dateTime.millisecondsSinceEpoch,
                ));
        reviewsList.value = reviewsList.reversed.toList();
        log("******Review List: ${reviewsList.length}"); */
      } catch (e) {
        log("*****Review Write Failed!: $e..");
        isWritingReviewLoading.value = false;
      }
    }
  }

  void clearAll() {
    rating.value = 0.0;
    ratingController.clear();
    reviewController.clear();
  }

  Future<void> updateRating(String productId) async {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final secureSnapshot = await transaction.get(
          FirebaseFirestore.instance.collection(itemCollection).doc(productId));
      double previousRating = 0.0;
      try {
        previousRating = secureSnapshot.get("reviewCount");
      } catch (e) {
        previousRating = 0.0;
      }
      try {
        transaction.set(
          secureSnapshot.reference,
          {
            "reviewCount": previousRating + 1,
          },
          SetOptions(merge: true),
        );
      } catch (e) {
        log("****Update Review Error: $e");
      }
    });
  }

  bool checkValidate() {
    if (validateReview() && validateRating()) {
      return true;
    } else {
      return false;
    }
  }

  bool validateReview() {
    if (reviewController.text.isEmpty) {
      reviewError.value = true;
      return false;
    } else {
      reviewError.value = false;
      return true;
    }
  }

  bool validateRating() {
    if (rating.value < 0 || rating.value == 0) {
      rateError.value = true;
      return false;
    } else {
      rateError.value = false;
      return true;
    }
  }
  //**End */

  /*  @override
  Future<void> onInit() async {
    FirebaseFirestore.instance
        .collection(reviewCollection)
        .where("productId", isEqualTo: dataController.selectedProduct.value!.id)
        .get()
        .then((value) {
      reviewsList.value = value.docs.map((e) {
        return Review.fromJson(e.data());
      }).toList();
    });
    super.onInit();
  }
 */

  @override
  void onInit() {
    calculateAverageRatings();
    super.onInit();
  }

  var totalRating = 0.0.obs;
  var ratingCount = 0.obs;

  Future<void> calculateAverageRatings() async {
    //1.find all review is equal to current product's id
    final snapshot = await FirebaseFirestore.instance
        .collection(reviewCollection)
        .withConverter<Review>(
          fromFirestore: (review, __) => Review.fromJson(review.data()!),
          toFirestore: (review, __) => review.toJson(),
        )
        .where("productId", isEqualTo: homeController.editItem.value!.id)
        .get();
    //2.loop all review and map with raring map
    for (var element in snapshot.docs) {
      var rate = element.data().rating;
      totalRating.value += rate;
      ratingCount.value += 1;
      var category = mapRatingValueToCategory(rate);
      ratingMap[category] = (ratingMap[category] as int) + 1;
    }
  }

  RC mapRatingValueToCategory(double ratingValue) {
    if (ratingValue >= 5) {
      return RC.Excellent;
    } else if (ratingValue >= 4) {
      return RC.Good;
    } else if (ratingValue >= 3) {
      return RC.Average;
    } else if (ratingValue >= 2) {
      return RC.BelowAverage;
    } else {
      return RC.Poor;
    }
  }

  String categoryToString(RC category) {
    switch (category) {
      case RC.Excellent:
        return 'Excellent';
      case RC.Good:
        return 'Good';
      case RC.Average:
        return 'Average';
      case RC.BelowAverage:
        return 'Below Average';
      case RC.Poor:
        return 'Poor';
    }
  }

  Color categoryToColor(RC category) {
    switch (category) {
      case RC.Excellent:
        return Colors.green;
      case RC.Good:
        return Colors.lightGreen;
      case RC.Average:
        return Colors.yellow;
      case RC.BelowAverage:
        return Colors.amber;
      case RC.Poor:
        return Colors.red;
    }
  }
}
