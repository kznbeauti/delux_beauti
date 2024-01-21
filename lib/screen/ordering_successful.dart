import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kozarni_ecome/data/constant.dart';
import 'package:kozarni_ecome/routes/routes.dart';
import 'package:kozarni_ecome/screen/product_detail/view/detail_screen.dart';
import 'package:kozarni_ecome/utils/extension.dart';

import 'order_history.dart';

class OrderingSuccessful extends StatefulWidget {
  const OrderingSuccessful({Key? key}) : super(key: key);

  @override
  State<OrderingSuccessful> createState() => _OrderingSuccessfulState();
}

class _OrderingSuccessfulState extends State<OrderingSuccessful>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;

  late AnimationController _animationController;
  bool isDialogOpen = false;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);

    _animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Transform.scale(
                      scale: _animationController.value,
                      alignment: Alignment.center,
                      child: Center(
                        child: Image.asset(
                          orderSuccessImage,
                          width: size.width * 0.8,
                          height: size.height * 0.3,
                        ),
                      ));
                }),
            30.vertical(),
            Text("လူကြီးမင်း Order တင်ခြင်း အောင်မြင်ပါသည်။"),
            20.vertical(),
            Text(
              "You can see the order status in the 'Order History' section.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600),
            ),
            40.vertical(),
            ElevatedButton(
                onPressed: () => Get.to(() => OrderHistory()),
                child: Text("Go to 'Order History'"))
          ],
        ).withPadding(v: 0, h: 20),
      ),
    );
  }
}
