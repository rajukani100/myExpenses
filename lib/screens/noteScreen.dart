import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:my_expense/main.dart';
import 'package:my_expense/services/cloud_data.dart';
import 'package:my_expense/utils/color.dart';
import 'package:my_expense/utils/responsive.dart';

class noteScreen extends StatelessWidget {
  noteScreen({super.key}) {}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: height15 * .75,
        ),
        Text(
          "ExpenseNote",
          style: TextStyle(
              fontFamily: 'Gotham',
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w600,
              fontSize: font15 * 1.5,
              color: mainColor),
        ),
        SizedBox(
          height: height15 * .75,
        ),
        Expanded(
          child: Obx(() => TextFormField(
                controller: helperGetx.noteController.value,
                onChanged: (value) async {
                  await cloudData
                      .writeNotes(helperGetx.noteController.value.text);
                },
                style: TextStyle(fontSize: 18),
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                      borderSide: BorderSide(width: 1, color: mainGrey)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                      borderSide: BorderSide(width: 1, color: mainGrey)),
                  hintText: 'type your expense note here....  ',
                ),
              )),
        )
      ],
    );
  }
}
