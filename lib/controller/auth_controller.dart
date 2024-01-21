import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kozarni_ecome/screen/view/profile.dart';

class AuthenticationController extends GetxController {
  var passwordSecure = true.obs;
  var emailOrPhoneNumber = "".obs;
  var password = "".obs;
  var firstTimePressedLogin = false.obs;
  var emailSignInLoading = false.obs;
  var codeRetrieveTimeout = false.obs;
  int resendTokenCount = 0;
  final GlobalKey<FormState> formKey = GlobalKey();

  void changePasswordSecure() => passwordSecure.value = !passwordSecure.value;
  void changeEmailOrPhone(String value) => emailOrPhoneNumber.value = value;
  void changePassword(String value) => password.value = value;
  Future<void> login() async {
    if (password.value.isEmpty || emailOrPhoneNumber.value.isEmpty) {
      //if not valid
      firstTimePressedLogin.value = true;
      return;
    }
    //check email or phone number
    if (emailOrPhoneNumber.value.contains("@gmail.com")) {
      //this is email
      emailSignInLoading.value = true;
      await createAccountWithEmail();

      emailSignInLoading.value = false;
    } else if (emailOrPhoneNumber.value.startsWith('09')) {
      //this is phone
      emailSignInLoading.value = true;
      await signInWithPhoneNumber(null);
    }
    firstTimePressedLogin.value = false;
  }

  Future<void> createAccountWithEmail() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailOrPhoneNumber.value.removeAllWhitespace,
        password: password.value.removeAllWhitespace,
      );
      Get.snackbar("Login Success!", "",
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.green);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar("Login Failed!", "Password is too weak.",
            snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
      } else if (e.code == 'email-already-in-use') {
        await emailSignIn();
      }
    } catch (e) {
      Get.snackbar("Login Failed!", "Try again.",
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    }
  }

  Future<void> emailSignIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailOrPhoneNumber.value.removeAllWhitespace,
        password: password.value.removeAllWhitespace,
      );
      Get.snackbar("Login Success!", "",
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.green);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar("No user found for that email.", "Try again.",
            snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
      } else if (e.code == 'wrong-password') {
        Get.snackbar("Wrong password provided for that user.", "Try again.",
            snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
      }
    }
  }

  Future<void> signInWithPhoneNumber(int? forceResendToken) async {
    codeRetrieveTimeout.value = false;
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber:
            "+959${emailOrPhoneNumber.value.removeAllWhitespace.substring(2)}",
        forceResendingToken: forceResendToken,
        verificationCompleted: (PhoneAuthCredential credential) async {
          emailSignInLoading.value = false;
          await FirebaseAuth.instance.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            emailSignInLoading.value = false;
            Get.snackbar("The provided phone number is not valid.", "",
                snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
          }
        },
        codeSent: (String verificationId, int? resendToken) async {
          // Update the UI - wait for the user to enter the SMS code

          Get.to(
            () => PhoneVerificationPage(
              onCompleted: (v) async {
                PhoneAuthCredential credential = PhoneAuthProvider.credential(
                    verificationId: verificationId, smsCode: v);

                // Sign the user in (or link) with the credential
                await FirebaseAuth.instance.signInWithCredential(credential);
                emailSignInLoading.value = false;
                Get.back();
                Get.snackbar("Login Success!", "",
                    snackPosition: SnackPosition.BOTTOM,
                    colorText: Colors.green);
              },
              resendCode: () => signInWithPhoneNumber(resendTokenCount++),
            ),
          );
          // Create a PhoneAuthCredential with the code
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          codeRetrieveTimeout.value = true;
        },
      );
    } catch (e) {
      emailSignInLoading.value = false;

      Get.snackbar("Login Failed!", "",
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    }
  }
}
