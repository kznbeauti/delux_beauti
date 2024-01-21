import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kozarni_ecome/utils/fun.dart';

import '../../controller/home_controller.dart';
import '../purchase_dialog_box/purchase_dialog_box.dart';

class CashOnDelivery extends StatelessWidget {
  const CashOnDelivery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find();
    return Obx(() {
      return ListView.builder(
        itemCount: controller.purchcasesCashOn().length,
        itemBuilder: (_, i) {
          final model = controller.purchcasesCashOn()[i];
          List town = model.deliveryTownshipInfo;
          final shipping = town[1];
          final townName = town[0];
          final statusSum = getStatusOrderAdmin(model);
          return ListTile(
            title: Text(
                "${controller.purchcasesCashOn()[i].name} \n${controller.purchcasesCashOn()[i].phone}"),
            subtitle: Text(
                "${DateTime.parse(controller.purchcasesCashOn()[i].dateTime).day}/${DateTime.parse(controller.purchcasesCashOn()[i].dateTime).month}/${DateTime.parse(controller.purchcasesCashOn()[i].dateTime).year}"),
            trailing: SizedBox(
              width: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding:
                        EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                    decoration: BoxDecoration(
                        color: statusSum["color"],
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Text(
                      statusSum["status"],
                      style: TextStyle(
                          fontSize: 12,
                          color: statusSum["num"] == null
                              ? Colors.black
                              : Colors.white),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      print(controller.purchcasesCashOn()[i].items.length);

                      Get.defaultDialog(
                        title: "Customer ၀ယ်ယူခဲ့သော အချက်အလက်များ",
                        titleStyle: TextStyle(fontSize: 12),
                        radius: 5,
                        content: purchaseDialogBox(
                            context: context,
                            purchaseModel: controller.purchcasesCashOn()[i]),
                      );
                    },
                    icon: Icon(Icons.info),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
