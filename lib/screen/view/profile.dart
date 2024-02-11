import 'package:colours/colours.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:kozarni_ecome/controller/home_controller.dart';
import 'package:kozarni_ecome/data/constant.dart';
import 'package:kozarni_ecome/routes/routes.dart';
import 'package:kozarni_ecome/utils/extension.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../controller/auth_controller.dart';
import '../order_history.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();
    return Obx(() =>
        !(controller.currentUser.value == null) ? _LoginUser() : LoginScreen());
  }
}

class _LoginUser extends StatelessWidget {
  const _LoginUser({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController _controller = Get.find();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 220,
            padding: EdgeInsets.only(left: 20, right: 20),
            margin: EdgeInsets.only(top: 20),
            child: Card(
              child: Column(
                children: [
                  //Logo
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      bottom: 20,
                    ),
                    child: Image.asset(
                      "assets/applogo.png",
                      width: 100,
                      height: 100,
                    ),
                  ),
                  //   ),
                  // ),
                  //Email
                  Obx(
                    () => Text(
                      _controller.currentUser.value?.emailAddress ??
                          '', //-Email Address Will be Phone Number beacause
                      //--I didn't change it,TODO: need to change emailAddress to phone number
                      //--instance variable of AuthUser Object
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  //-----Point For Admin To Test On Their Own----//
                  Obx(
                    () => Text(
                      "Your points: ${_controller.currentUser.value?.points ?? 0}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Obx(() {
            if (_controller.currentUser.value!.status! > 0) {
              return _AdminPanel();
            } else {
              return SizedBox();
            }
          }),

          ///Order History
          GestureDetector(
            onTap: () {
              Get.to(() => OrderHistory());
            },
            child: Container(
              height: 60,
              margin: EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Order History"),
                      Icon(Icons.shop),
                    ],
                  ),
                ),
              ),
            ),
          ),
          //Return
          GestureDetector(
            onTap: () {
              Get.toNamed(returnPolicyUrl);
            },
            child: Container(
              height: 60,
              margin: EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Return Policy"),
                      Icon(FontAwesomeIcons.exclamationCircle),
                    ],
                  ),
                ),
              ),
            ),
          ),
          //Privacy Policy
          GestureDetector(
            onTap: () {
              Get.toNamed(privacyPolicyUrl);
            },
            child: Container(
              height: 60,
              margin: EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Privacy and Policy"),
                      Icon(FontAwesomeIcons.exclamationCircle),
                    ],
                  ),
                ),
              ),
            ),
          ),
          //TNC
          GestureDetector(
            onTap: () {
              Get.toNamed(tncRouteUrl);
            },
            child: Container(
              height: 60,
              margin: EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Terms and Conditions"),
                      Icon(FontAwesomeIcons.exclamationCircle),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          //Logout And Delete Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                    onPressed: () {
                      _controller.logOut();
                    },
                    child: Text("Log Out",
                        style: TextStyle(
                          fontSize: 16,
                          letterSpacing: 2,
                          wordSpacing: 2,
                          color: Colors.white,
                        ))),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                    onPressed: () {
                      _controller.deleteAccount();
                    },
                    child: Text("Delete Account",
                        style: TextStyle(
                          fontSize: 16,
                          letterSpacing: 2,
                          wordSpacing: 2,
                          color: Colors.white,
                        ))),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AdminPanel extends StatelessWidget {
  const _AdminPanel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 40, bottom: 20, left: 20, right: 20),
          child: Text(
            "Admin Feature",
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            controller.changeCat("");
            Get.toNamed(uploadItemScreen);
          },
          child: Container(
            height: 60,
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Upload Item"),
                    Icon(Icons.upload),
                  ],
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed(mangeItemScreen);
          },
          child: Container(
            height: 60,
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Manage Item"),
                    Icon(Icons.edit),
                  ],
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed(advertisementUrl);
          },
          child: Container(
            height: 60,
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Manage Advertisement"),
                    Icon(Icons.edit),
                  ],
                ),
              ),
            ),
          ),
        ),

        GestureDetector(
          onTap: () {
            Get.toNamed(advertisementUrl2);
          },
          child: Container(
            height: 60,
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Manage Advertisement2"),
                    Icon(Icons.edit),
                  ],
                ),
              ),
            ),
          ),
        ),

        GestureDetector(
          onTap: () {
            Get.toNamed(categoriesUrl);
          },
          child: Container(
            height: 60,
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Manage Categories"),
                    Icon(Icons.edit),
                  ],
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed(brandManagementUrl);
          },
          child: Container(
            height: 60,
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Manage Brands"),
                    Icon(Icons.edit),
                  ],
                ),
              ),
            ),
          ),
        ),

        GestureDetector(
          onTap: () {
            Get.toNamed(statusUrl);
          },
          child: Container(
            height: 60,
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Manage Status"),
                    Icon(Icons.edit),
                  ],
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed(tagsUrl);
          },
          child: Container(
            height: 60,
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Manage Tags"),
                    Icon(Icons.edit),
                  ],
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed(promotionUrl);
          },
          child: Container(
            height: 60,
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Manage Promotions"),
                    Icon(Icons.edit),
                  ],
                ),
              ),
            ),
          ),
        ),

        ///Manage Divisions
        GestureDetector(
          onTap: () {
            Get.toNamed(divisionUrl);
          },
          child: Container(
            height: 60,
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Manage Divisions"),
                    Icon(Icons.edit),
                  ],
                ),
              ),
            ),
          ),
        ),

        ///Stock Management
        GestureDetector(
          onTap: () {
            Get.toNamed(inventoryUrl);
          },
          child: Container(
            height: 60,
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Stock Management"),
                    Icon(Icons.edit),
                  ],
                ),
              ),
            ),
          ),
        ),

        ///
        GestureDetector(
          onTap: () {
            Get.toNamed(purchaseScreen);
          },
          child: Container(
            height: 60,
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("My Orders  🎁"),
                    CircleAvatar(
                        backgroundColor: Colors.orange,
                        minRadius: 20,
                        maxRadius: 20,
                        child: Text(
                          "${controller.purchcasesCashOn().length + controller.purchcasesPrePay().length}",
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final focusBorder =
        OutlineInputBorder(borderSide: BorderSide(color: homeIndicatorColor));
    final errorBorder = OutlineInputBorder(
        borderSide: BorderSide(
      color: Colors.red,
    ));
    final border =
        OutlineInputBorder(borderSide: BorderSide(color: Colors.white));
    final labelTextStyle = TextStyle(
      color: Colors.white,
      fontSize: 16,
    );

    final textStyle = TextStyle(color: Colors.white);
    final HomeController homeController = Get.find();
    final AuthenticationController authController = Get.find();
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //LOGO
            ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              child: Image.asset(
                "assets/applogo.png",
                width: Get.width / 3,
              ),
            ),
            10.vertical(),
            Text(
              "DELUX BEAUTI",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                // fontStyle: FontStyle.italic,
                wordSpacing: 2,
                letterSpacing: 3,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: LayoutBuilder(builder: (context, constraints) {
                final height = constraints.maxHeight;
                return Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  height: height,
                  decoration: BoxDecoration(
                      color: logoColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      )),
                  child: AutofillGroup(
                    child: SingleChildScrollView(
                      child: Obx(() {
                        final errorPassword =
                            authController.password.value.isEmpty &&
                                authController.firstTimePressedLogin.value;
                        final errorEmail =
                            authController.emailOrPhoneNumber.value.isEmpty &&
                                authController.firstTimePressedLogin.value;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 50),
                            //Email
                            Text(
                              "Email or Phone Number",
                              style: labelTextStyle,
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              style: textStyle,
                              cursorColor: homeIndicatorColor,
                              onChanged: authController.changeEmailOrPhone,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                enabledBorder: border,
                                focusedBorder: focusBorder,
                                errorBorder: errorBorder,
                                disabledBorder: border,
                                focusedErrorBorder: errorBorder,
                                hintText: "example@gmail.com (or) 09987654321",
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade700,
                                ),
                                errorText: errorEmail
                                    ? "Email or Phone Number is required."
                                    : null,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            //Password
                            Text(
                              "Password",
                              style: labelTextStyle,
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              obscureText: authController.passwordSecure.value,
                              style: textStyle,
                              onChanged: authController.changePassword,
                              cursorColor: homeIndicatorColor,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                enabledBorder: border,
                                focusedBorder: focusBorder,
                                errorBorder: errorBorder,
                                disabledBorder: border,
                                focusedErrorBorder: errorBorder,
                                hintText: "R#2pL@9w!",
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade700,
                                ),
                                errorText: errorPassword
                                    ? "Password is required."
                                    : null,
                                suffixIcon: IconButton(
                                  onPressed:
                                      authController.changePasswordSecure,
                                  icon: Icon(
                                    authController.passwordSecure.value
                                        ? FontAwesomeIcons.eyeSlash
                                        : FontAwesomeIcons.eye,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              onPressed: authController.emailSignInLoading.value
                                  ? null
                                  : () => authController.login(),
                              child: authController.emailSignInLoading.value
                                  ? SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  : Text(
                                      "Login",
                                      style: labelTextStyle,
                                    ),
                            ).withCenter(),
                            10.vertical(),
                            Center(
                              child: Text(
                                "(or)",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                  letterSpacing: 2,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            //Social Login
                            Center(
                              child: Text(
                                "Login With",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                  letterSpacing: 2,
                                ),
                              ),
                            ),
                            20.vertical(),
                            SizedBox(
                              height: 40,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () =>
                                        homeController.signInWithGoogle(),
                                    child: Image.asset(
                                      googleLogo,
                                      height: 40,
                                      width: 40,
                                    ),
                                  ),
                                  20.horizontal(),
                                  InkWell(
                                    onTap: () =>
                                        homeController.signInWithApple(),
                                    child: Image.asset(
                                      appleLogo,
                                      height: 40,
                                      width: 40,
                                    ),
                                  ),
                                ],
                              ).withCenter(),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class PhoneVerificationPage extends StatelessWidget {
  const PhoneVerificationPage({
    Key? key,
    required this.onCompleted,
    required this.resendCode,
  }) : super(key: key);
  final void Function(String) onCompleted;
  final void Function() resendCode;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final focusBorder =
        OutlineInputBorder(borderSide: BorderSide(color: homeIndicatorColor));
    final errorBorder = OutlineInputBorder(
        borderSide: BorderSide(
      color: Colors.red,
    ));
    final border =
        OutlineInputBorder(borderSide: BorderSide(color: Colors.white));
    final labelTextStyle = TextStyle(
      color: Colors.white,
      fontSize: 20,
    );

    final textStyle = TextStyle(color: Colors.white);
    final HomeController homeController = Get.find();
    final AuthenticationController authController = Get.find();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //LOGO

            Text(
              "PHONE CODE VERIFICATION",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                // fontStyle: FontStyle.italic,
                wordSpacing: 2,
                letterSpacing: 3,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: LayoutBuilder(builder: (context, constraints) {
                final height = constraints.maxHeight;
                return Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  height: height,
                  decoration: BoxDecoration(
                      color: logoColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      )),
                  child: SingleChildScrollView(
                    child: Obx(() {
                      final errorPassword =
                          authController.password.value.isEmpty &&
                              authController.firstTimePressedLogin.value;
                      final errorEmail =
                          authController.emailOrPhoneNumber.value.isEmpty &&
                              authController.firstTimePressedLogin.value;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 50),
                          //Email
                          Text(
                            "We have sent the verification code to ${authController.emailOrPhoneNumber}",
                            style: labelTextStyle,
                            textAlign: TextAlign.center,
                          ),
                          40.vertical(),
                          VerificationCode(
                            onEditing: (v) {},
                            fullBorder: true,
                            textStyle:
                                TextStyle(fontSize: 20.0, color: Colors.white),
                            keyboardType: TextInputType.number,
                            underlineColor: Colors
                                .amber, // If this is null it will use primaryColor: Colors.red from Theme
                            length: 6,
                            cursorColor: Colors
                                .white, // If this is null it will default to the ambient
                            // clearAll is NOT required, you can delete it
                            // takes any widget, so you can implement your design
                            clearAll: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'clear all',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    decoration: TextDecoration.underline,
                                    color: homeIndicatorColor),
                              ),
                            ),
                            onCompleted: (String value) {
                              onCompleted(value);
                            },
                          ),
                          20.vertical(),
                          authController.codeRetrieveTimeout.value
                              ? ElevatedButton(
                                  onPressed: resendCode,
                                  child: Text(
                                    "Resend",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ).withCenter()
                              : const SizedBox(),
                        ],
                      );
                    }),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
