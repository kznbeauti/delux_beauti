import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kozarni_ecome/controller/home_controller.dart';
import 'package:kozarni_ecome/controller/upload_controller.dart';
import 'package:kozarni_ecome/data/constant.dart';
import 'package:kozarni_ecome/utils/extension.dart';
import 'package:kozarni_ecome/widgets/animate_size_list/animate_size_list.dart';
import 'package:kozarni_ecome/widgets/home_category.dart';
import 'package:kozarni_ecome/widgets/status_button_list.dart';
import 'package:kozarni_ecome/widgets/tag_button_list.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../widgets/animate_size_list/sizeprice_item.dart';

class UploadItem extends StatefulWidget {
  const UploadItem({Key? key}) : super(key: key);

  @override
  State<UploadItem> createState() => _UploadItemState();
}

class _UploadItemState extends State<UploadItem> {
  final UploadController controller = Get.find();
  final HomeController homecontroller = Get.find();

  @override
  void dispose() {
    homecontroller.setEditItem(null);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: scaffoldBackground,
        appBar: AppBar(
          title: Text(
            "DELUX BEAUTI",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              // fontStyle: FontStyle.italic,
              wordSpacing: 2,
              letterSpacing: 3,
            ),
          ),
          actions: [
            // if (!(homecontroller.editItem.value == null)) ...[
            //   Padding(
            //     padding: const EdgeInsets.only(
            //       top: 12.0,
            //       bottom: 12.0,
            //     ),
            //     child: ElevatedButton(
            //       style: ElevatedButton.styleFrom(
            //         primary: homeIndicatorColor,
            //       ),
            //       child: Text("Delete"),
            //       onPressed: () =>
            //           controller.delete(homecontroller.editItem.value!.id),
            //     ),
            //   ),
            // ],
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: homeIndicatorColor,
                ),
                child: Text("Save"),
                onPressed: () => controller.upload(),
              ),
            ),
          ],
          elevation: 0,
          backgroundColor: detailBackgroundColor,
          leading: IconButton(
            onPressed: Get.back,
            icon: Icon(
              Icons.arrow_back,
              color: appBarTitleColor,
            ),
          ),
        ),
        body: Form(
            key: controller.form,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10, bottom: 5),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Category:",
                    ),
                  ),
                ),
                // Category
                ItemCategory(),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10, bottom: 5),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Status:",
                    ),
                  ),
                ),
                // Status
                StatusButtonList(),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10, bottom: 5),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Tags:",
                    ),
                  ),
                ),
                //Tabs
                TagButtonList(),
                //Brand
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10, bottom: 5),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Brands:",
                    ),
                  ),
                ),
                //Tabs
                BrandButtonList(),
                //Photo1
                Padding(
                  padding: EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                  ),
                  child: TextFormField(
                    selectionControls: MaterialTextSelectionControls(),
                    controller: controller.photo1Controller,
                    validator: (value) =>
                        controller.validator(value: value, isOptional: false),
                    decoration: InputDecoration(
                      hintText: 'Photo Link',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                //Photo2
                Padding(
                  padding: EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                  ),
                  child: TextFormField(
                    selectionControls: MaterialTextSelectionControls(),
                    controller: controller.photo2Controller,
                    validator: (value) =>
                        controller.validator(value: value, isOptional: false),
                    decoration: InputDecoration(
                      hintText: 'Photo Link 2',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                //Photo3
                Padding(
                  padding: EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                  ),
                  child: TextFormField(
                    selectionControls: MaterialTextSelectionControls(),
                    controller: controller.photo3Controller,
                    validator: (value) =>
                        controller.validator(value: value, isOptional: false),
                    decoration: InputDecoration(
                      hintText: 'Photo Link 3',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                //Name
                Padding(
                  padding: EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                  ),
                  child: TextFormField(
                    controller: controller.nameController,
                    validator: (value) =>
                        controller.validator(value: value, isOptional: false),
                    decoration: InputDecoration(
                      hintText: 'Product အမည်',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                //Description
                Padding(
                  padding: EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                  ),
                  child: TextFormField(
                    // textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    minLines: 1,
                    maxLines: null,

                    controller: controller.descriptionController,
                    validator: (value) =>
                        controller.validator(value: value, isOptional: false),
                    decoration: InputDecoration(
                      hintText: 'အသေးစိတ်ဖော်ပြချက်',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                //Ingredients
                Padding(
                  padding: EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                  ),
                  child: TextFormField(
                    // textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    minLines: 3,
                    maxLines: null,

                    controller: controller.ingredientController,
                    validator: (value) =>
                        controller.validator(value: value, isOptional: false),
                    decoration: InputDecoration(
                      hintText: 'Ingredients',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                //How To Use
                Padding(
                  padding: EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                  ),
                  child: TextFormField(
                    // textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    minLines: 3,
                    maxLines: null,

                    controller: controller.howToUseController,
                    validator: (value) =>
                        controller.validator(value: value, isOptional: false),
                    decoration: InputDecoration(
                      hintText: 'How to use',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                //Price
                Padding(
                  padding: EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                  ),
                  child: TextFormField(
                    controller: controller.priceController,
                    validator: (value) =>
                        controller.validator(value: value, isOptional: false),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'ဈေးနှုန်း',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                //Discount
                Padding(
                  padding: EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                  ),
                  child: TextFormField(
                    controller: controller.discountPriceController,
                    validator: (value) =>
                        controller.validator(value: value, isOptional: true),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'အထူးလျော့ဈေး',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                //Color
                // Padding(
                //   padding: EdgeInsets.only(
                //     top: 20,
                //     left: 20,
                //     right: 20,
                //   ),
                //   child: TextFormField(
                //     controller: controller.colorController,
                //     validator: (value) =>
                //         controller.validator(value: value, isOptional: true),
                //     decoration: InputDecoration(
                //       hintText: 'အရောင်',
                //       border: OutlineInputBorder(),
                //     ),
                //   ),
                // ),
                //Add SizePrice Button
                Padding(
                  padding: EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                  ),
                  child: Obx(() {
                    return Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: controller.isEmptySizePrice.value
                              ? Colors.red
                              : Colors.white,
                        )),
                        height: 50,
                        width: 100,
                        child: Row(children: [
                          //Add Icon
                          IconButton(
                            onPressed: () => controller.addSizePrice(),
                            icon: Icon(FontAwesomeIcons.plusCircle,
                                color: Colors.black),
                          ),
                          //Text
                          Text("Add Size"),
                        ]));
                  }),
                ),
                //SizePrice Widget if list is not empty
                Obx(() => controller.sizePriceMap.isNotEmpty
                    ? sizePriceListWidget()
                    : const SizedBox(height: 0)),
                /* ListView(
                  primary: false,
                  shrinkWrap: false,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [ */
                //row
                20.vertical(),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Schedule Sales(Optional):"),
                      IconButton(
                        onPressed: () => controller.clearSchedule(),
                        icon: Icon(
                          Icons.clear,
                          size: 24,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 70,
                  width: size.width,
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 5,
                    bottom: 5,
                  ),
                  child: Row(
                    children: [
                      //title
                      Expanded(
                        child: TextFormField(
                          controller: controller.scheduleSaleTitle,
                          validator: (value) => controller.validator(
                              value: value, isOptional: true),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'Sale Title',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      10.horizontal(),
                      //price
                      Expanded(
                        child: TextFormField(
                          controller: controller.scheduleSalePrice,
                          validator: (value) => controller.validator(
                              value: value, isOptional: true),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Sale Price',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //datetime
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 20),
                  child: TextButton(
                    onPressed: () {
                      Get.dialog(
                        Center(
                          child: SizedBox(
                            height: 400,
                            width: 300,
                            child: Material(
                              child: SfDateRangePicker(
                                onSelectionChanged: (d) {
                                  controller.scheduleSaleEndDate.value =
                                      d.value;
                                  Get.back();
                                },
                                selectionMode:
                                    DateRangePickerSelectionMode.single,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "Pick schedule date(optional)",
                      style: TextStyle(fontSize: 16, color: Colors.blue),
                    ),
                  ),
                ),
                Obx(() => controller.scheduleSaleEndDate.value == null
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.only(
                          left: 35,
                          bottom: 10,
                        ),
                        child: Text(
                          DateFormat.yMEd()
                              .add_jms()
                              .format(controller.scheduleSaleEndDate.value!),
                        ),
                      )),
                /*  ],
                ), */
                //Reward Point
                Padding(
                  padding: EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                  ),
                  child: TextFormField(
                    controller: controller.requirePointController,
                    validator: (value) =>
                        controller.validator(value: value, isOptional: true),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'reward point',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                //Original Price
                Padding(
                  padding: EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                  ),
                  child: TextFormField(
                    controller: controller.originalPrice,
                    validator: (value) =>
                        controller.validator(value: value, isOptional: false),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Buying Price',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                //
                Padding(
                  padding: EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                  ),
                  child: TextFormField(
                    controller: controller.originalQuantity,
                    validator: (value) =>
                        controller.validator(value: value, isOptional: false),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Original Quantity',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                //Remain Quantity
                Padding(
                  padding: EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                  ),
                  child: TextFormField(
                    controller: controller.remainQuantity,
                    validator: (value) =>
                        controller.validator(value: value, isOptional: false),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Remain Quantity',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                //Delivery Time
                Padding(
                  padding: EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                  ),
                  child: TextFormField(
                    controller: controller.deliveryTimeController,
                    validator: (value) =>
                        controller.validator(value: value, isOptional: true),
                    decoration: InputDecoration(
                      hintText: 'Available Time',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            )));
  }

  Widget sizePriceListWidget() {
    return Obx(() {
      return AnimatedContainer(
          height: (controller.sizePriceMap.length * 50) + 100,
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 600),
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: ListView(
            children: controller.sizePriceMap.entries.map((map) {
              return SizePriceItemWidget(
                key: ValueKey(map.key),
                id: map.key,
                sizeText: map.value.size,
                price: "${map.value.price}",
              );
            }).toList(),
          ));
    });
  }
}
