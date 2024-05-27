import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_expense/services/authentication.dart';
import 'package:my_expense/utils/color.dart';
import 'package:my_expense/utils/responsive.dart';
import 'package:my_expense/widgets/custom_button.dart';
import 'package:my_expense/widgets/input_Text.dart';

class createAccount extends StatelessWidget {
  createAccount({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBackgorund,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: height400 / 2,
                  ),
                  Text(
                    "Sign Up",
                    style: TextStyle(
                        fontFamily: 'Gotham_black',
                        fontStyle: FontStyle.normal,
                        color: mainColor,
                        fontSize: font20 * 2),
                  ),
                  SizedBox(
                    height: height15 * 2,
                  ),
                  Container(
                    width: width359,
                    height: height55,
                    child: inputText(
                      inputString: "Email",
                      controller: emailController,
                    ),
                  ),
                  SizedBox(
                    height: height15,
                  ),
                  Container(
                    width: width359,
                    height: height55,
                    child: inputText(
                      inputString: "Password",
                      controller: passwordController,
                      isPass: true,
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
                        if (emailController.text != "" &&
                            passwordController.text != "") {
                          Authenticate.signUp(emailController.text,
                              passwordController.text, context);
                        }
                      },
                      child: customButton(
                        value: "Create account",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      width: width359,
                      height: height55,
                      child: customButton(
                        value: "Login",
                        color: mainBackgorund,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
