import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_expense/main.dart';
import 'package:my_expense/screens/createAccout_screen.dart';
import 'package:my_expense/screens/resetPassword_screen.dart';
import 'package:my_expense/services/authentication.dart';
import 'package:my_expense/utils/color.dart';
import 'package:my_expense/utils/constant.dart';
import 'package:my_expense/utils/responsive.dart';
import 'package:my_expense/widgets/custom_button.dart';
import 'package:my_expense/widgets/custom_snackbar.dart';
import 'package:my_expense/widgets/input_Text.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:my_expense/widgets/partner_auth.dart';

class myLogin extends StatelessWidget {
  myLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: height150,
              ),
              Text(
                "Login",
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
                height: height15 / 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: width15 * 2),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => resetPasswordScreen());
                      },
                      child: Text(
                        "forget password ?",
                        style: TextStyle(
                            fontFamily: 'Gotham',
                            fontStyle: FontStyle.normal,
                            fontSize: font15,
                            fontWeight: FontWeight.w900,
                            color: mainGrey),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height15 / 2,
              ),
              Container(
                width: width359,
                height: height55,
                child: GestureDetector(
                  onTap: () {
                    if (emailController.text != "" &&
                        passwordController.text != "") {
                      showSnackBar(context, "processing your request",
                          Colors.greenAccent);
                      Authenticate.login(emailController.text,
                          passwordController.text, context);
                    }
                  },
                  child: customButton(
                    value: "Login",
                  ),
                ),
              ),
              SizedBox(
                height: height15,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => createAccount());
                },
                child: Container(
                  width: width359,
                  height: height55,
                  child: customButton(
                    value: "Create account",
                    color: mainBackgorund,
                  ),
                ),
              ),
              SizedBox(
                height: height15,
              ),
              SizedBox(
                height: height15 * 2,
              ),
              Container(
                height: height20 / 20,
                width: width45 * 4,
                color: mainGrey,
              ),
              SizedBox(
                height: height15 * 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      Future<UserCredential> signInWithGoogle() async {
                        // Trigger the authentication flow
                        final GoogleSignInAccount? googleUser =
                            await GoogleSignIn().signIn();
                        // Obtain the auth details from the request
                        final GoogleSignInAuthentication? googleAuth =
                            await googleUser?.authentication;
                        // Create a new credential
                        final credential = GoogleAuthProvider.credential(
                          accessToken: googleAuth?.accessToken,
                          idToken: googleAuth?.idToken,
                        );
                        // Once signed in, return the UserCredential
                        return await FirebaseAuth.instance
                            .signInWithCredential(credential);
                      }

                      try {
                        await signInWithGoogle();
                      } catch (e) {
                        showSnackBar(
                            context, "an unknown error occurred", Colors.red);
                      }
                    },
                    child: partnerAuth(
                      imagePath: google_logo,
                      value: "Google",
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
