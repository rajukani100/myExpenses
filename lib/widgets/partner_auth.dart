import 'package:flutter/material.dart';
import 'package:my_expense/utils/responsive.dart';

class partnerAuth extends StatelessWidget {
  final String imagePath;
  final String value;
  const partnerAuth({super.key, required this.imagePath, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width137,
      height: height20 * 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(33),
        border: Border.all(width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            Image.asset(
              imagePath,
              height: height15 * 2,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    value,
                    style: TextStyle(
                        fontFamily: 'Gotham',
                        fontStyle: FontStyle.normal,
                        fontSize: font17,
                        color: Colors.black),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
