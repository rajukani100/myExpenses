import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_expense/utils/color.dart';
import 'package:my_expense/utils/responsive.dart';
import 'package:my_expense/widgets/custom_button.dart';
import 'package:my_expense/widgets/custom_snackbar.dart';
import 'package:my_expense/widgets/input_Text.dart';

class resetPasswordScreen extends StatelessWidget {
  resetPasswordScreen({super.key});

  TextEditingController forgotEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: mainBackgorund,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: height20 / 2,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width10),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        size: height15 * 2,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: height400 / 2,
              ),
              Text(
                "Reset your password",
                style: TextStyle(
                    fontFamily: 'Gotham_black',
                    fontStyle: FontStyle.normal,
                    color: mainColor,
                    fontSize: font20 * 1.5),
              ),
              SizedBox(
                height: height15 * 2,
              ),
              Container(
                width: width359,
                height: height55,
                child: inputText(
                  inputString: "Email",
                  controller: forgotEmailController,
                ),
              ),
              SizedBox(
                height: height15,
              ),
              Container(
                width: width359,
                height: height55,
                child: GestureDetector(
                  onTap: () {
                    if (forgotEmailController.text != "") {
                      FirebaseAuth.instance.sendPasswordResetEmail(
                          email: forgotEmailController.text);
                    }
                    showSnackBar(
                        context,
                        "password reset link sent successfully",
                        Colors.greenAccent);
                  },
                  child: customButton(
                    value: "reset",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
