import 'package:flutter/material.dart';

class PrivacyPolicyRoute extends StatefulWidget {
  static final String routeName = "/privacy_policy_route";
  @override
  _PrivacyPolicyRouteState createState() => _PrivacyPolicyRouteState();
}

class _PrivacyPolicyRouteState extends State<PrivacyPolicyRoute> {
  final Color tileColor = Colors.redAccent;
  final Color iconColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text("Privacy and Policy", style: TextStyle(fontWeight: FontWeight.w700,
            fontSize: 16.0,
            color: Colors.black
        )),),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
        child: SingleChildScrollView(child: Column(
          children: [
            SizedBox(
              height: 20,
            ),

            Text(
              '''We, DELUX BEAUTI respects your concerns about privacy and values the relationship we have with you. This privacy describes the type of personal information we collect from our customer, including in store and online, how we use your information, the choices available to our customers regarding our use of the information. We also describe the measures of securities we use to protect the info and how our customers can contact us about privacy practices. 
Information we collect 
We may collect information when you purchase goods or services from us, provide it to us once on our websites ( www.deluxbeauti.com) or application, via our social media pages, at one of our events of if you contact us by telephone. 
Information you provide 
You may choose to provide us your information in a number of ways, such as when you participate in or promotion offers, when you purchase an order via stores, telephone, websites or social media. Information you provide may include, 
Contact info; (as name, address, postal codes, email address, phone numbers)
Age and date of birth 
Payment information( such as billing and delivery addresses)
Purchase history
Account information ( account id and Password)
Product preferences and feedback
Location information
Your physical characteristics, skincare and concerns and preferences
Information in relation to product complaints( includes reaction to skin, ethnic origin and allergy) 
Contents you provides( such as photos, videos, reviews, articles, comments and responses) 
Information provided to us through social media networks when you visit our social media pages (such as your name, profile pictures, and other information made publicly available by you on social media network
How we use the information
We may use the information you provided to :
Provide you promotion information and others 
Provide products and services to you 
Process your payment and transactions
Create your online account and access for online and instore purchases
Assit with product selection
Respond to your inquires
Comply with applicable legal requirements, relevant industry standards and our policies 
If  we use your information in ways not included here, we will let you know. 
 If you would like to know more, please contact us.
'''
            ),
          ],
        )),
      ),

    );
  }
}


