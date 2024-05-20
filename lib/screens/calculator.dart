import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_expense/main.dart';
import 'package:my_expense/screens/home_screen.dart';
import 'package:my_expense/utils/color.dart';
import 'package:my_expense/utils/responsive.dart';
import 'package:my_expense/widgets/custom_button.dart';

class Calculate extends StatelessWidget {
  Calculate({super.key});

  late final toDate, fromDate;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: height120,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "From",
                  style: TextStyle(
                      fontFamily: 'Gotham_black',
                      fontStyle: FontStyle.normal,
                      color: mainColor,
                      fontSize: font20),
                ),
                GestureDetector(
                  onTap: () async {
                    fromDate = await showCalendarDatePicker2Dialog(
                      context: context,
                      config: CalendarDatePicker2WithActionButtonsConfig(
                          selectedRangeHighlightColor: const Color(0xFF11999E),
                          selectedRangeDayTextStyle:
                              const TextStyle(color: mainBackgorund),
                          selectedDayHighlightColor: mainColor,
                          calendarType: CalendarDatePicker2Type.single),
                      dialogSize: Size(width325, height400),
                      value: [],
                      borderRadius: BorderRadius.circular(15),
                    );
                    if (fromDate != null) {
                      helperGetx.fromDate.value = fromDate;
                    }
                  },
                  child: Container(
                    height: height55,
                    width: width280,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(() => Text(
                                helperGetx.toDate[0] == null
                                    ? "select date"
                                    : "${helperGetx.fromDate[0].day}-${helperGetx.fromDate[0].month}-${helperGetx.fromDate[0].year}",
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
                              size: height25,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: height20 / 2,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "To",
                  style: TextStyle(
                      fontFamily: 'Gotham_black',
                      fontStyle: FontStyle.normal,
                      color: mainColor,
                      fontSize: font20),
                ),
                GestureDetector(
                  onTap: () async {
                    toDate = await showCalendarDatePicker2Dialog(
                      context: context,
                      config: CalendarDatePicker2WithActionButtonsConfig(
                          selectedRangeHighlightColor: const Color(0xFF11999E),
                          selectedRangeDayTextStyle:
                              const TextStyle(color: mainBackgorund),
                          selectedDayHighlightColor: mainColor,
                          calendarType: CalendarDatePicker2Type.single),
                      dialogSize: Size(width325, height400),
                      value: [],
                      borderRadius: BorderRadius.circular(15),
                    );
                    if (toDate != null) {
                      helperGetx.toDate.value = toDate;
                    }
                  },
                  child: Container(
                    height: height55,
                    width: width280,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(() => Text(
                                helperGetx.toDate[0] == null
                                    ? "select date"
                                    : "${helperGetx.toDate[0].day}-${helperGetx.toDate[0].month}-${helperGetx.toDate[0].year}",
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
                              size: height25,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: height20,
          ),
          GestureDetector(
            onTap: () async {
              if (helperGetx.toDate[0] != null &&
                  helperGetx.fromDate[0] != null) {
                // print(expensesGetx.calculateTotal(fromDate[0], toDate[0]));
                await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: mainBackgorund,
                      title: Text("Calcutor"),
                      content: Text(
                          "Total expense cost : ₹ ${expensesGetx.calculateTotal(helperGetx.fromDate[0], helperGetx.toDate[0])}"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "ok",
                              style: TextStyle(color: mainColor),
                            ))
                      ],
                    );
                  },
                );
              }
            },
            child: Container(
              height: height55,
              width: width350,
              child: customButton(value: "calculate"),
            ),
          ),
          SizedBox(
            height: height20 / 2,
          ),
        ],
      ),
    );
  }
}
