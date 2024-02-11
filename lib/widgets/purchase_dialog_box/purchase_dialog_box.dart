import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Condition;
import 'package:kozarni_ecome/utils/extension.dart';
import 'package:kozarni_ecome/utils/fun.dart';

import '../../controller/home_controller.dart';
import '../../data/constant.dart';
import '../../model/real_purchase.dart';
import '../order_print/user_order_print_view.dart';

Widget purchaseDialogBox({
  required PurchaseModel purchaseModel,
  required BuildContext context,
}) {
  HomeController controller = Get.find();
  final responsiveFontSize14 = TextStyle(
    fontSize: 10,
  );
  final responsiveFontSize10 = TextStyle(
    fontSize: 6,
  );
  final total =
      purchaseModel.total - purchaseModel.deliveryTownshipInfo[1] as int;
  final township = purchaseModel.deliveryTownshipInfo[0];
  final shipping = purchaseModel.deliveryTownshipInfo[1];
  final promotionValue = purchaseModel.promotionValue.contains("%")
      ? int.tryParse(purchaseModel.promotionValue.split("%").first) ?? 0
      : int.tryParse(purchaseModel.promotionValue) ?? 0;
  return Column(
    children: [
      //Order Id
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Text("Purchase Date"),
          Text(
            "Order ID - ${purchaseModel.id}",
            style: responsiveFontSize14,
          ),
        ],
      ),
      SizedBox(
        height: 15,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Text("Purchase Date"),
          Text(
            "၀ယ်ယူခဲ့သော နေ့ရက် - ${DateTime.tryParse(purchaseModel.dateTime)?.day}/${DateTime.tryParse(purchaseModel.dateTime)?.month}/${DateTime.tryParse(purchaseModel.dateTime)?.year}",
            style: responsiveFontSize14,
          ),
        ],
      ),
      SizedBox(
        height: 15,
      ),

      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Text("Name"),
          Text(
            purchaseModel.name,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
      SizedBox(
        height: 15,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Text("Ph No."),
          Text(
            "0${purchaseModel.phone}",
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
      SizedBox(
        height: 15,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Text("Email"),
          Text(
            purchaseModel.email,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),

      SizedBox(
        height: 15,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Text("Address"),
          Expanded(
              child: Text(
            purchaseModel.address,
            style: TextStyle(fontSize: 14),
          )),
        ],
      ),
      SizedBox(
        height: 25,
      ),
      Container(
        width: 400,
        height: 150,
        child: ListView.builder(
            padding: EdgeInsets.all(0),
            itemCount: purchaseModel.items.length,
            itemBuilder: (_, o) {
              final purchase = purchaseModel.items[o];
              return Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${o + 1}. ${purchase.itemName}",
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Expanded(
                      child: Wrap(
                        children: [
                          Text(
                            "${purchase.size}",
                            style: TextStyle(fontSize: 10),
                          ),
                          if (purchase.discountPrice! > 0) ...[
                            Text(
                              "${purchase.discountPrice} x  ${purchase.count} ထည်",
                              style: TextStyle(fontSize: 10),
                            ),
                          ] else if (purchase.requirePoint! > 0) ...[
                            Text(
                              "${purchase.requirePoint} x  ${purchase.count} ထည်",
                              style: TextStyle(fontSize: 10),
                            ),
                          ] else ...[
                            Text(
                              "${purchase.price} x  ${purchase.count} ထည်",
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
      //Promotion Discount
      promotionValue > 0
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "promotion လျှော့ငွေ",
                  style: responsiveFontSize14,
                ),
                Text(
                  purchaseModel.promotionValue.contains("%")
                      ? "${purchaseModel.promotionValue.split("%").first} %"
                      : "$promotionValue Ks",
                  style: responsiveFontSize14,
                ),
              ],
            )
          : const SizedBox(),
      const SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "ပို့ဆောင်ရမည့်မြို့နယ် -",
            style: responsiveFontSize14,
          ),
          //SizedBox(width: 10),
          Expanded(
            child: Text(
              township,
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "စုစုပေါင်း",
            style: responsiveFontSize14,
          ),
          Text(
            "($total ks - ${purchaseModel.promotionValue.contains("%") ? "${purchaseModel.promotionValue.split("%").first} %" : "$promotionValue Ks"}) + Deli $shipping Ks",
            style: responsiveFontSize14,
          ),
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      PurchaseDialogButton(
        total: total,
        shipping: shipping,
        township: township,
        purchaseModel: purchaseModel,
      ),
    ],
  );
}

class PurchaseDialogButton extends StatelessWidget {
  const PurchaseDialogButton({
    Key? key,
    required this.total,
    required this.shipping,
    required this.township,
    required this.purchaseModel,
  }) : super(key: key);

  final int total;
  final int shipping;
  final String township;
  final PurchaseModel purchaseModel;

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();
    switch (getOrderStatus(purchaseModel)) {
      case OrderStatus.newOrder:
        return Column(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
              onPressed: () {
                //TODO:Confirm this order
                controller.changeOrderStatus(
                  purchaseModel: purchaseModel,
                  status: 0,
                );
              },
              child: controller.changing.value
                  ? SizedBox(
                      height: 35,
                      width: 35,
                      child: CircularProgressIndicator(
                        color: homeIndicatorColor,
                      ),
                    )
                  : Text("Confirm"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
              onPressed: () {
                //TODO:Confirm this order
                controller.changeOrderStatus(
                  purchaseModel: purchaseModel,
                  status: 2,
                );
              },
              child: controller.changing.value
                  ? SizedBox(
                      height: 35,
                      width: 35,
                      child: CircularProgressIndicator(
                        color: homeIndicatorColor,
                      ),
                    )
                  : Text("Cancel"),
            ),
          ],
        );
      case OrderStatus.confirmed:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: homeIndicatorColor,
              ),
              onPressed: () {
                Get.to(UserOrderPrintView(
                  purchaseModel: purchaseModel,
                  total: total,
                  shipping: shipping,
                  township: township,
                ));
              },
              child: Text("Print Preview"),
            ),
            10.vertical(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: homeIndicatorColor,
              ),
              onPressed: () {
                controller.changeOrderStatus(
                    purchaseModel: purchaseModel, status: 1);
              },
              child: Text("Shipped"),
            ),
          ],
        );
      case OrderStatus.shipped:
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: homeIndicatorColor,
          ),
          onPressed: () {
            Get.to(UserOrderPrintView(
              purchaseModel: purchaseModel,
              total: total,
              shipping: shipping,
              township: township,
            ));
          },
          child: Text("Print Preview"),
        );
      case OrderStatus.canceled:
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: homeIndicatorColor,
          ),
          onPressed: null,
          child: Text("Canceled"),
        );
      default:
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: homeIndicatorColor,
          ),
          onPressed: () {
            Get.to(UserOrderPrintView(
              purchaseModel: purchaseModel,
              total: total,
              shipping: shipping,
              township: township,
            ));
          },
          child: Text("Print Preview"),
        );
    }
  }
}
