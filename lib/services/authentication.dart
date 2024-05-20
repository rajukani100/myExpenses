import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_expense/screens/verification_screen.dart';
import 'package:my_expense/widgets/custom_snackbar.dart';

class Authenticate {
  static void login(String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (!FirebaseAuth.instance.currentUser!.emailVerified) {
        await FirebaseAuth.instance.currentUser!.sendEmailVerification();
        Get.to(() => verificationScreen());
      }
    } on FirebaseAuthException catch (error) {
      if (context.mounted) {
        showSnackBar(context, error.code, Colors.red);
      }
    }
  }

  static void signUp(
      String email, String password, BuildContext context) async {
    try {
      showSnackBar(context, "processing your request", Colors.greenAccent);

      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      showSnackBar(
          context, "your account created successfully.", Colors.greenAccent);

      Get.back();
    } on FirebaseAuthException catch (error) {
      if (context.mounted) {
        showSnackBar(context, error.code, Colors.red);
      }
    }
  }
}
