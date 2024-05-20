import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_expense/getx/models/records_getx.dart';
import 'package:my_expense/main.dart';
import 'package:my_expense/screens/detail_screen.dart';
import 'package:my_expense/screens/home_screen.dart';
import 'package:my_expense/services/cloud_data.dart';
import 'package:my_expense/utils/color.dart';
import 'package:my_expense/utils/constant.dart';
import 'package:my_expense/utils/responsive.dart';

class recordBox extends StatelessWidget {
  final UserRecord userRecord;
  const recordBox({super.key, required this.userRecord});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width15),
      child: Container(
        height: height58,
        width: width300,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 8.0,
            ),
          ],
          borderRadius: BorderRadius.circular(8),
          color: mainBlack,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Get.to(() => detailScreen(userRecord: userRecord),
                    transition: Transition.rightToLeft,
                    duration: Duration(milliseconds: 200));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: width20),
                width: width300,
                height: height58,
                child: Row(
                  children: [
                    Obx(() => Expanded(
                          flex: 4,
                          child: Text(
                              "${userRecord.id.value.day}-${userRecord.id.value.month}-${userRecord.id.value.year} ",
                              style: TextStyle(
                                fontFamily: 'Gotham',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w900,
                                fontSize: font17,
                                color: Colors.white,
                              )),
                        )),
                    Obx(() => Expanded(
                          flex: 3,
                          child: Center(
                            child: RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                text: "₹",
                                style: TextStyle(
                                  fontFamily: 'Gotham',
                                  overflow: TextOverflow.ellipsis,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w100,
                                  fontSize: font20,
                                  color: mainColor,
                                ),
                              ),
                              TextSpan(
                                  text: " ${userRecord.totalCost.value}",
                                  style: TextStyle(
                                    fontFamily: 'Gotham',
                                    overflow: TextOverflow.ellipsis,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w900,
                                    fontSize: font17,
                                    color: mainColor,
                                  ))
                            ])),
                          ),
                        )),
                  ],
                ),
              ),
            ),
            GestureDetector(
              child: Container(
                width: width45,
                height: height58,
                decoration: const BoxDecoration(
                    color: mainRed,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8))),
                child: Center(
                  child: Image.asset(
                    bin_icon,
                    height: height20,
                    width: width25,
                    color: mainBlack,
                  ),
                ),
              ),
              onTap: () {
                // delete button

                expensesGetx.removeRecord(userRecord);
                cloudData.removeRecordEntryUpdateData(userRecord.toJson());

                // we have to delete things from both lists and manage it's UI
                if (helperGetx.isDateFilter.value != false) {
                  expensesGetx.filterExpenses.value = [];
                  expensesGetx.filterExpense(
                      helperGetx.dateRange[0], helperGetx.dateRange[1]);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
