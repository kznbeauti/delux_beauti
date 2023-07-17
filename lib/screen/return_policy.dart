import 'package:flutter/material.dart';

class AboutRoute extends StatefulWidget {
  static final String routeName = "/about_route";
  @override
  _AboutRouteState createState() => _AboutRouteState();
}

class _AboutRouteState extends State<AboutRoute> {
  final Color tileColor = Colors.redAccent;
  final Color iconColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text("Return Policy", style: TextStyle(fontWeight: FontWeight.w700,
            fontSize: 16.0,
            color: Colors.black
        )),),
      // appBar: AppBar(title: Text("About")),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: SingleChildScrollView(child: Text(
            '''
If  you are going to make a return, we are sorry to hear that. If you are not satisfied with your purchase made through Delux Beauti , we are happy to let you know that you can return any unwanted products that are new within 3 days form the date of your purchase as stated on your receipt/invoice. Change of mind is not applicable. We will refund only for the orders that are purchased at DELUX BEAUTI. 
Please note that the products in bundles or sets must be returned in full in order to be eligible for a refund. Partial refunds will not be offered. 
You may return with a proof of your receipt of purchase(required). If you purchased online ( cash on delivery is not included), you will be refunded to your original payment method. If you purchased via COD, you will be refunded via bank transfer method after items are arrived at Delux Beauti. If  the items that are not from DELUX BEAUTI, we will not return them to you. 
The refund process will take about 12 business days or more. If we see an abnormal process, we may contact you. DELUX BEAUTI reserves the rights to refuse your return or orders. 
'''
        )),
      ),

    );
  }
}


