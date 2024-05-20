import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_expense/getx/models/records_getx.dart';
import 'package:my_expense/screens/home_screen.dart';
import 'package:my_expense/services/cloud_data.dart';
import 'package:my_expense/utils/color.dart';
import 'package:my_expense/utils/responsive.dart';

class datePicker extends StatelessWidget {
  final UserRecord userRecord;
  datePicker({super.key, required this.userRecord});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        DateTime? selectedDate = await showDatePicker(
          context: context,
          firstDate: DateTime(2000),
          lastDate: DateTime(DateTime.now().year + 1),
          builder: (context, child) {
            return Theme(
                data: Theme.of(context).copyWith(
                  // override MaterialApp ThemeData
                  colorScheme: ColorScheme.light(
                    primary: mainColor, //header and selced day background color
                    onSurface: Colors.black,
                    // Month days , years
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(),
                  ),
                ),
                child: child!);
          },
        );
        if (selectedDate != null) {
          cloudData.removeRecordEntryUpdateData(userRecord.toJson());
          userRecord.id.value = selectedDate.copyWith(hour: 1);
          expensesGetx.updateLocalData();
          cloudData.updateExpenseDetailData(userRecord.toJson());
        }
      },
      child: Container(
        height: height55,
        decoration: BoxDecoration(
            border: Border.all(width: 1),
            borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() => Text(
                  "${userRecord.id.value.day}-${userRecord.id.value.month}-${userRecord.id.value.year}",
                  style: TextStyle(
                    fontFamily: 'Gotham',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w900,
                    fontSize: font20,
                    color: mainBlack,
                  ))),
              Icon(
                Icons.edit_calendar_outlined,
                color: mainBlack,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
