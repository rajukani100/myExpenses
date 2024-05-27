import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_expense/getx/models/records_getx.dart';
import 'package:my_expense/screens/home_screen.dart';
import 'package:my_expense/screens/newRecordEntry.dart';
import 'package:my_expense/utils/color.dart';
import 'package:my_expense/utils/responsive.dart';
import 'package:my_expense/widgets/date_picker.dart';
import 'package:my_expense/widgets/detail_box.dart';

class detailScreen extends StatelessWidget {
  detailScreen({super.key, required this.userRecord});
  final UserRecord userRecord;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBackgorund,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              child: Column(
                children: [
                  SizedBox(
                    height: height20 / 2,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                            expensesGetx.expenses
                                .sort((a, b) => UserRecord.compareById(b, a));
                          },
                          child: Icon(
                            Icons.arrow_back,
                            size: height15 * 2,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: width15,
                        ),
                        Expanded(
                            child: datePicker(
                          userRecord: userRecord,
                        )),
                        SizedBox(
                          width: width15,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height20,
                  ),
                  Text(
                    "Details",
                    style: TextStyle(
                        fontFamily: 'Gotham',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                        fontSize: font18),
                  ),
                  SizedBox(
                    height: height20,
                  ),
                  Expanded(
                    child: Container(
                        width: width372,
                        child: Obx(
                          () => ListView.separated(
                            itemCount: userRecord.subDetails.length,
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: height20 / 2,
                              );
                            },
                            itemBuilder: (context, index) {
                              return detailBox(
                                title:
                                    userRecord.subDetails.keys.toList()[index],
                                value: userRecord.subDetails.values
                                    .toList()[index],
                                userRecord: userRecord,
                              );
                            },
                          ),
                        )),
                  ),
                  SizedBox(
                    height: height20 / 2,
                  ),
                ],
              ),
            ),
            Positioned(
                right: 15,
                bottom: 25,
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => newRecordEntry(uesrRecord: userRecord),
                        transition: Transition.rightToLeft,
                        duration: Duration(milliseconds: 200));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 8.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(30),
                      color: mainColor,
                    ),
                    child: Center(
                        child: Text(
                      "add expenses",
                      style: TextStyle(
                          fontSize: font20, fontWeight: FontWeight.w500),
                    )),
                    width: width170,
                    height: height45,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
