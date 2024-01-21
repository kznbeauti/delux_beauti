import 'package:flutter/material.dart';
import 'package:kozarni_ecome/model/real_purchase.dart';

String getCategoryFromList(List<String> categories) {
  var category = "";
  for (var element in categories) {
    category += element + ",";
  }
  return category;
}

Map<String, dynamic> getStatusOrderUser(int? status) {
  switch (status) {
    case null:
      return {"color": Colors.yellow, "status": "Waiting", "num": null};
    case 0:
      return {"color": Colors.green, "status": "Confirmed", "num": 0};
    case 1:
      return {"color": Colors.red, "status": "Shipped", "num": 1};
    default:
      return {};
  }
}

Map<String, dynamic> getStatusOrderAdmin(PurchaseModel model) {
  int? status = model.orderStatus;
  bool newShow = DateTime.parse(model.dateTime).millisecondsSinceEpoch >=
      DateTime(2024, 1, 19).millisecondsSinceEpoch;
  switch (status) {
    case null:
      return {
        "color": newShow ? Colors.yellow : null,
        "status": newShow ? "New" : "",
        "num": null
      };
    case 0:
      return {"color": Colors.green, "status": "Confirmed", "num": 0};
    case 1:
      return {"color": Colors.red, "status": "Shipped", "num": 1};
    default:
      return {};
  }
}

enum OrderStatus { newOrder, confirmed, shipped, oldOrder }

OrderStatus getOrderStatus(PurchaseModel model) {
  int? status = model.orderStatus;
  bool newShow = DateTime.parse(model.dateTime).millisecondsSinceEpoch >=
      DateTime(2024, 1, 19).millisecondsSinceEpoch;
  switch (status) {
    case null:
      return newShow ? OrderStatus.newOrder : OrderStatus.oldOrder;
    case 0:
      return OrderStatus.confirmed;
    case 1:
      return OrderStatus.shipped;
    default:
      return OrderStatus.oldOrder;
  }
}
