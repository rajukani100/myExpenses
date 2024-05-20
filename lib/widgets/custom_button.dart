import 'package:flutter/material.dart';
import 'package:my_expense/utils/color.dart';
import 'package:my_expense/utils/responsive.dart';

class customButton extends StatelessWidget {
  final String value;
  final Color color;
  const customButton({super.key, required this.value, this.color = mainColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 1)),
      child: Center(
        child: Text(
          value,
          style: TextStyle(
              fontFamily: 'Gotham',
              fontStyle: FontStyle.normal,
              fontSize: font20,
              color: Colors.black),
        ),
      ),
    );
  }
}
