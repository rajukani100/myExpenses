import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_expense/screens/calculator.dart';
import 'package:my_expense/screens/home_screen.dart';
import 'package:my_expense/screens/setting_screen.dart';

class BottomNavbarGetx extends GetxController {
  RxInt navbarIndex = 0.obs;
  Rx<Widget> currentScreen = Rx(myHome());

  Widget getCurrentScreen() {
    return currentScreen.value;
  }

  void changeScreen(int value) async {
    navbarIndex.value = value;
    switch (value) {
      case 0:
        currentScreen.value = myHome();
        break;
      case 1:
        currentScreen.value = Calculate();
        break;
      case 2:
        currentScreen.value = mySetting();
        break;
    }
  }
}
