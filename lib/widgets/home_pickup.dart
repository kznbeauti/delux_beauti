import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../controller/home_controller.dart';
import 'package:getwidget/getwidget.dart';

import '../model/view_all_model.dart';
import '../routes/routes.dart';

class HomePickUp extends StatelessWidget {
  const HomePickUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.height > 1000;
    final width = MediaQuery.of(context).size.width;
    final HomeController controller = Get.find();
    return controller.advertisementList.isEmpty
        ? const SizedBox()
        : Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
            ),
            child: GFCarousel(
              scrollPhysics: const BouncingScrollPhysics(),
              aspectRatio: 16 / 9,
              autoPlay: true,
              viewportFraction: 1.0,
              hasPagination: true,
              activeIndicator: Colors.black,
              passiveIndicator: Colors.grey,
              autoPlayInterval: const Duration(seconds: 6),
              items: controller.advertisementList.map((advertisement) {
                return CachedNetworkImage(
                  progressIndicatorBuilder: (context, url, status) {
                    return Shimmer.fromColors(
                      child: Container(
                        color: Colors.white,
                      ),
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.white,
                    );
                  },
                  errorWidget: (context, url, whatever) {
                    return const Text("Image not available");
                  },
                  imageUrl: advertisement.image,
                  fit: BoxFit.contain,
                );
              }).toList(),
            ),
          );
  }
}
