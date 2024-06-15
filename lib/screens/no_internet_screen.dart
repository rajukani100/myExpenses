import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:my_expense/main.dart';
import 'package:my_expense/utils/color.dart';
import 'package:my_expense/utils/responsive.dart';
import 'package:my_expense/widgets/custom_button.dart';

class noInternetScreen extends StatelessWidget {
  const noInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "lib/assets/logos/no-internet.gif",
            height: 300,
          ),
          Text(
            "Ooops !",
            style: TextStyle(
                fontFamily: 'Gotham',
                fontStyle: FontStyle.normal,
                fontSize: font24,
                fontWeight: FontWeight.w900,
                color: mainGrey),
          ),
          Text(
            "Slow or no internet connection.",
            style: TextStyle(
                fontFamily: 'Gotham',
                fontStyle: FontStyle.normal,
                fontSize: font15,
                fontWeight: FontWeight.w900,
                color: mainGrey),
          ),
          Text(
            "check your internet connection.",
            style: TextStyle(
                fontFamily: 'Gotham',
                fontStyle: FontStyle.normal,
                fontSize: font15,
                fontWeight: FontWeight.w900,
                color: mainGrey),
          ),
          SizedBox(
            height: height55,
          ),
          GestureDetector(
            onTap: () async {
              checkConnectivity();
            },
            child: Container(
              height: height55,
              width: width170 * 1.5,
              child: customButton(
                value: "try again",
              ),
            ),
          )
        ],
      )),
    );
  }
}
