import 'package:flutter/material.dart';
import 'package:my_expense/utils/color.dart';
import 'package:my_expense/utils/responsive.dart';

class inputText extends StatelessWidget {
  final String inputString;
  bool isNum;
  bool isPass;
  final TextEditingController controller;
  inputText(
      {super.key,
      required this.inputString,
      required this.controller,
      this.isNum = false,
      this.isPass = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: mainColor,
      controller: controller,
      keyboardType: (!isNum) ? TextInputType.text : TextInputType.number,
      obscureText: isPass,
      decoration: InputDecoration(
          labelText: inputString,
          contentPadding:
              EdgeInsets.symmetric(vertical: height15, horizontal: width10),
          isDense: true,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(height15)),
          labelStyle: TextStyle(
              fontFamily: 'Gotham',
              fontStyle: FontStyle.normal,
              fontSize: font20,
              color: mainGrey),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: mainBlack),
              borderRadius: BorderRadius.circular(height15)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: mainBlack),
              borderRadius: BorderRadius.circular(height15))),
      onTap: () {
        if (controller.text == "0.0") {
          controller.clear();
        }
      },
    );
  }
}
