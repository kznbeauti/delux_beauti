import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kozarni_ecome/controller/home_controller.dart';
import 'package:kozarni_ecome/data/constant.dart';
import 'package:get/get.dart';
import 'package:kozarni_ecome/expaned_widget.dart';
import 'package:kozarni_ecome/model/hive_item.dart';
import 'package:kozarni_ecome/routes/routes.dart';
import 'package:kozarni_ecome/screen/product_detail/controller/product_detail_controller.dart';
import '../../../utils/fun.dart';
import '../../../widgets/product_review/product_review.dart';
import '../../home_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:kozarni_ecome/model/size.dart' as own;

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  List<bool> isOpen = [false, false, false];
  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();
    final currentProduct = controller.editItem.value!;
    final ProductDetailController pdController = Get.find();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: detailTextBackgroundColor,
      /*  appBar: AppBar(
        /* actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: ValueListenableBuilder(
              valueListenable: Hive.box<HiveItem>(boxName).listenable(),
              builder: (context, Box<HiveItem> box, widget) {
                final currentObj = box.get(currentProduct!.id);

                if (!(currentObj == null)) {
                  return IconButton(
                      onPressed: () {
                        box.delete(currentObj.id);
                      },
                      icon: Icon(
                        FontAwesomeIcons.solidHeart,
                        color: Colors.red,
                        size: 25,
                      ));
                }
                return IconButton(
                    onPressed: () {
                      box.put(currentProduct.id,
                          controller.changeHiveItem(currentProduct));
                    },
                    icon: Icon(
                      Icons.favorite_outline,
                      color: Colors.red,
                      size: 25,
                    ));
              },
            ),
          ),
        ], */
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        /* title: Text(
          currentProduct!.name,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
        ), */
      ),
      */
      body: ListView(
        children: [
          //Brand Name
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: const SizedBox()),
              //Brand Name
              currentProduct.brandName == null
                  ? const SizedBox()
                  : Center(
                      child: Text(
                        currentProduct.brandName ?? '',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ).withPadding(v: 5, h: 20),
                    ),
              Expanded(child: const SizedBox()),
              //Favourite Icon
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: ValueListenableBuilder(
                  valueListenable: Hive.box<HiveItem>(boxName).listenable(),
                  builder: (context, Box<HiveItem> box, widget) {
                    final currentObj = box.get(currentProduct!.id);

                    if (!(currentObj == null)) {
                      return IconButton(
                          onPressed: () {
                            box.delete(currentObj.id);
                          },
                          icon: Icon(
                            FontAwesomeIcons.solidHeart,
                            color: Colors.red,
                            size: 25,
                          ));
                    }
                    return IconButton(
                        onPressed: () {
                          box.put(currentProduct.id,
                              controller.changeHiveItem(currentProduct));
                        },
                        icon: Icon(
                          Icons.favorite_outline,
                          color: Colors.red,
                          size: 25,
                        ));
                  },
                ),
              ),
            ],
          ),
          //Product Name
          Center(
            child: Text(
              currentProduct.name,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ).withPadding(v: 5, h: 20),
          ),
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              child: CarouselSlider(
                items: [
                  CachedNetworkImage(
                    imageUrl: currentProduct.photo1,
                    // "$baseUrl$itemUrl${currentProduct.photo}/get",
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  CachedNetworkImage(
                    imageUrl: currentProduct.photo2,
                    // "$baseUrl$itemUrl${currentProduct.photo}/get",
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  CachedNetworkImage(
                    imageUrl: currentProduct.photo3,
                    // "$baseUrl$itemUrl${currentProduct.photo}/get",
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ],
                options: CarouselOptions(
                  height: 250,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
            margin: EdgeInsets.only(top: 10),
            width: double.infinity,
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 10,
            ),
            decoration: BoxDecoration(
              color: detailTextBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
          ),
          //Normal Price
          Center(
            child: Text(
              "${currentProduct.price} Ks",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                decoration: (!(currentProduct.discountPrice == null) &&
                        (currentProduct.discountPrice ?? 0) > 0)
                    ? TextDecoration.lineThrough
                    : null,
              ),
            ).withPadding(v: 5, h: 20),
          ),
          //Discount Price
          (!(currentProduct.discountPrice == null) &&
                  (currentProduct.discountPrice ?? 0) > 0)
              ? Center(
                  child: Text(
                    (currentProduct.discountPrice ?? 0) > 0
                        ? "${currentProduct.discountPrice} Ks"
                        : "no discount price",
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ).withPadding(v: 5, h: 20),
                )
              : const SizedBox(),
          Divider(),
          ExpansionPanelList(
            elevation: 0,
            children: [
              ExpansionPanel(
                isExpanded: isOpen[0],
                headerBuilder: (context, value) {
                  return Text("About Product").withPadding(v: 5, h: 10);
                },
                body: Text(currentProduct.description).withPadding(v: 0, h: 10),
              ),
              ExpansionPanel(
                isExpanded: isOpen[1],
                headerBuilder: (context, value) {
                  return Text("Ingredients").withPadding(v: 5, h: 10);
                },
                body: Text(currentProduct.ingredients ?? "")
                    .withPadding(v: 0, h: 10),
              ),
              ExpansionPanel(
                isExpanded: isOpen[2],
                headerBuilder: (context, value) {
                  return Text("How To Use").withPadding(v: 5, h: 10);
                },
                body: Text(currentProduct.howToUse ?? "")
                    .withPadding(v: 0, h: 10),
              ),
            ],
            expansionCallback: (index, value) {
              setState(() {
                isOpen[index] = !value;
              });
              log("====Index: ${index}");
            },
          ),
          Divider(
            thickness: 2,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          imageUrl: currentProduct.photo2,
                          width: 150,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CachedNetworkImage(
                                imageUrl: currentProduct.photo3,
                                width: 150,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     Text(
                //       "🏠 Shop Address",
                //       style: TextStyle(
                //         fontSize: 16,
                //         fontWeight: FontWeight.bold,
                //         color: Colors.grey,
                //       ),
                //     ),
                //     SizedBox(
                //       height: 5,
                //     ),
                //     Text(
                //       'ဥက္ကာလမ်း ၊ ဥက္ကာ ၅x၆ လမ်း ၊ မြောက်ဥက္ကလာပမြို့နယ် ၊ ရန်ကုန်မြို့။',
                //       style: TextStyle(
                //         fontSize: 15,
                //         color: Colors.black,
                //       ),
                //     )
                //   ],
                // ),
              ],
            ),
          ),
          //Overall Rating
          Obx(() {
            var totalRating = pdController.totalRating.value;
            var ratingCount = pdController.ratingCount.value;
            var ratingMap = pdController.ratingMap;
            var rating = totalRating / ratingCount;
            return SizedBox(
              width: size.width,
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shrinkWrap: true,
                children: [
                  //OverAll Rating
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Overall Rating",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${rating.isNaN ? 0 : rating}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RatingBar.builder(
                            initialRating: rating.isNaN ? 0 : rating,
                            minRating: 0,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 20,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            ignoreGestures: true,
                            onRatingUpdate: (rating) {},
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "base on ${ratingCount} reviews",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  //Stars and Number
                ]..addAll(ratingMap.entries.map((e) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LayoutBuilder(builder: (context, constraints) {
                        final width = constraints.maxWidth;
                        return SizedBox(
                          width: width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                pdController.categoryToString(e.key),
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              SizedBox(
                                width: width * 0.6,
                                child: LinearProgressIndicator(
                                  value: e.value / 10,
                                  backgroundColor: Colors.grey.shade200,
                                  color: pdController.categoryToColor(e.key),
                                  minHeight: 10,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    );
                  }).toList()),
              ),
            );
          }),
          //--------------Review------//
          ProductReviewWidget(
            product: currentProduct,
          ),
          //-----------------------//
        ],
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 65,
        // decoration: BoxDecoration(
        //   color: detailBackgroundColor,
        //   borderRadius: BorderRadius.only(
        //     topLeft: Radius.circular(20),
        //     topRight: Radius.circular(20),
        //   ),
        // ),
        padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        child: !(currentProduct.remainQuantity == null) &&
                (currentProduct.remainQuantity! == 0)
            ? ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.grey.shade300),
                ),
                onPressed: null,
                child: Text("Out of stock"),
              )
            : ElevatedButton(
                style: buttonStyle,
                onPressed: () {
                  if ((currentProduct.color == null) &&
                      (currentProduct.size == null ||
                          (currentProduct.size?.isEmpty == true))) {
                    //------Add to Cart-------//
                    controller.addToCart(currentProduct,
                        price: currentProduct.price);
                    Get.back();
                  } else {
                    showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      )),
                      builder: (context) {
                        return AddToCart(
                          sizePriceList: currentProduct.size ?? [],
                          imageUrl: currentProduct.photo1,
                          color: currentProduct.color ?? "No Color",
                        );
                      },
                    );
                  }
                },
                child: Text("၀ယ်ယူရန်"),
              ),
      ),
    );
  }
}

class AddToCart extends StatefulWidget {
  final String imageUrl;
  final List<own.Size> sizePriceList;
  final String color;
  const AddToCart({
    Key? key,
    required this.imageUrl,
    required this.sizePriceList,
    required this.color,
  }) : super(key: key);

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  String? colorValue;
  String? discountPercentage;
  own.Size? sizePrice;
  final HomeController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          //Default Price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Product Image
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: widget.imageUrl,
                  width: 100,
                  height: 100,
                  progressIndicatorBuilder: (context, url, status) {
                    return Center(
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(
                          value: status.progress,
                        ),
                      ),
                    );
                  },
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Text(
                sizePrice?.size ?? "",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
              //
              SizedBox(
                height: widget.sizePriceList.length * 30,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (var element in widget.sizePriceList) ...[
                      Text(
                        "${element.price}",
                        textAlign: sizePrice == element
                            ? TextAlign.right
                            : TextAlign.center,
                        style: TextStyle(
                          decoration: sizePrice == element
                              ? TextDecoration.none
                              : TextDecoration.lineThrough,
                          fontSize: sizePrice == element ? 20 : 12,
                          color: sizePrice == element
                              ? homeIndicatorColor
                              : Colors.black,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          //SizePrice
          SizedBox(
            height: 80,
            child: Wrap(
              children: widget.sizePriceList.map((element) {
                return Padding(
                  padding: const EdgeInsets.only(left: 7, right: 7),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: sizePrice?.id == element.id
                            ? homeIndicatorColor
                            : Colors.grey,
                      ),
                    ),
                    onPressed: () {
                      //TODO: CHANGE SIZEPRICE
                      setState(() {
                        sizePrice = element;
                      });
                    },
                    child: Text(
                      element.size,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 20),
          //
          // SizedBox(
          //   width: 120,
          //   child: DropdownButtonFormField(
          //     value: colorValue,
          //     hint: Text(
          //       'Color',
          //       style: TextStyle(fontSize: 12),
          //     ),
          //     onChanged: (String? e) {
          //       colorValue = e;
          //     },
          //     items: widget.color
          //         .split(',')
          //         .map((e) => DropdownMenuItem(
          //               value: e,
          //               child: Text(
          //                 e,
          //                 style: TextStyle(fontSize: 12),
          //               ),
          //             ))
          //         .toList(),
          //   ),
          // ),

          SizedBox(
            height: 10,
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: ElevatedButton(
              style: buttonStyle,
              onPressed: () {
                debugPrint("************PRICE: ${sizePrice!.price}");
                if (!(sizePrice == null)) {
                  controller.addToCart(controller.editItem.value!,
                      color: "",
                      size: [sizePrice!.size, sizePrice!.price],
                      price: int.parse(sizePrice!.price));
                  Get.toNamed(homeScreen);
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Text("၀ယ်ယူရန်"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

extension padd on Widget {
  Widget withPadding({required double v, required double h}) => Padding(
        padding: EdgeInsets.symmetric(vertical: v, horizontal: h),
        child: this,
      );
}
