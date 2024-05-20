import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_expense/screens/resetPassword_screen.dart';
import 'package:my_expense/screens/home_screen.dart';
import 'package:my_expense/utils/color.dart';
import 'package:my_expense/utils/responsive.dart';
import 'package:my_expense/widgets/custom_snackbar.dart';

class mySetting extends StatelessWidget {
  const mySetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: height55,
            ),
            Text(
              "Your account ",
              style: TextStyle(
                  fontFamily: 'Gotham',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600,
                  fontSize: font15 * 1.5,
                  color: mainColor),
            ),
            SizedBox(
              height: height25,
            ),
            Column(
              children: [
                Container(
                  child: Center(
                    child: Icon(
                      Icons.person,
                      size: height70,
                      color: Color(0xFF8ff0e2),
                    ),
                  ),
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: mainColor),
                  height: 90,
                ),
                SizedBox(
                  height: height25,
                ),
                Container(
                  width: width359,
                  height: height55,
                  decoration: BoxDecoration(
                    color: Color(0xFF8ff0e2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      "${FirebaseAuth.instance.currentUser!.email}",
                      style: TextStyle(
                          fontFamily: 'Gotham',
                          fontStyle: FontStyle.normal,
                          fontSize: font20,
                          color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(
                  height: height25,
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(() => resetPasswordScreen());
                      },
                      child: Container(
                        width: width10 * 20,
                        height: height55,
                        decoration: BoxDecoration(
                          color: Color(0xFF8ff0e2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            "reset password",
                            style: TextStyle(
                                fontFamily: 'Gotham',
                                fontStyle: FontStyle.normal,
                                fontSize: font20,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height20 / 2,
                    ),
                    GestureDetector(
                      onTap: () async {
                        try {
                          expensesGetx.removeLocalData();
                          FirebaseAuth.instance.signOut();
                          await GoogleSignIn().signOut();
                        } catch (e) {
                          showSnackBar(context, "unable sign out", Colors.red);
                        }
                      },
                      child: Container(
                        width: width10 * 20,
                        height: height55,
                        decoration: BoxDecoration(
                          color: Color(0xFFff5e1a),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            "sign out",
                            style: TextStyle(
                                fontFamily: 'Gotham',
                                fontStyle: FontStyle.normal,
                                fontSize: font20,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
