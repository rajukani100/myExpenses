import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_expense/main.dart';
import 'package:my_expense/utils/color.dart';
import 'package:my_expense/utils/responsive.dart';
import 'package:my_expense/widgets/custom_button.dart';
import 'package:my_expense/widgets/custom_snackbar.dart';

class verificationScreen extends StatefulWidget {
  verificationScreen({super.key});
  @override
  State<verificationScreen> createState() => _verificationScreenState();
}

class _verificationScreenState extends State<verificationScreen> {
  Timer? timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      helperGetx.checkEmailVerification();
    });
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: mainBackgorund,
        body: Column(
          children: [
            SizedBox(
              height: height20 / 2,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width10),
                  child: GestureDetector(
                    onTap: () async {
                      Get.back();
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: height15 * 2,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height150 * 1.5,
            ),
            Column(
              children: [
                Text(
                  "Email verification link is sent to",
                  style: TextStyle(
                      fontFamily: 'Gotham',
                      fontStyle: FontStyle.normal,
                      fontSize: font18,
                      fontWeight: FontWeight.w900,
                      color: mainGrey),
                ),
                Text(
                  "${FirebaseAuth.instance.currentUser!.email}",
                  style: TextStyle(
                      fontFamily: 'Gotham',
                      fontStyle: FontStyle.normal,
                      fontSize: font18,
                      fontWeight: FontWeight.w900,
                      color: mainGrey),
                ),
                SizedBox(
                  height: height70,
                ),
                GestureDetector(
                  onTap: () async {
                    await FirebaseAuth.instance.currentUser!
                        .sendEmailVerification();
                    showSnackBar(
                        context,
                        "Verification link has been resent successfully.",
                        Colors.greenAccent);
                  },
                  child: Container(
                    height: height55,
                    width: width170 * 1.5,
                    child: customButton(
                      value: "Resend link",
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: height55,
            ),
          ],
        ),
      ),
    );
  }
}
