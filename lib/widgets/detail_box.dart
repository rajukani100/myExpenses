import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_expense/getx/models/records_getx.dart';
import 'package:my_expense/screens/editRecordEntry.dart';
import 'package:my_expense/screens/home_screen.dart';
import 'package:my_expense/services/cloud_data.dart';
import 'package:my_expense/utils/color.dart';
import 'package:my_expense/utils/constant.dart';
import 'package:my_expense/utils/responsive.dart';

class detailBox extends StatelessWidget {
  final String title;
  final double value;
  final UserRecord userRecord;
  detailBox(
      {super.key,
      required this.title,
      required this.value,
      required this.userRecord});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: mainBlack,
      ),
      width: width372,
      height: height20 * 4,
      child: Row(
        children: [
          Container(
            width: width322,
            decoration: BoxDecoration(
                color: mainBlack,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8))),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text("${title}",
                        style: TextStyle(
                          fontFamily: 'Gotham',
                          fontStyle: FontStyle.normal,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w900,
                          fontSize: font20,
                          color: Colors.white,
                        )),
                  ),
                  Expanded(
                    child: SizedBox(),
                    flex: 1,
                  ),
                  Expanded(
                    flex: 2,
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                        text: "₹",
                        style: TextStyle(
                          fontFamily: 'Gotham',
                          overflow: TextOverflow.ellipsis,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w100,
                          fontSize: font24,
                          color: mainColor,
                        ),
                      ),
                      TextSpan(
                          text: " ${value}",
                          style: TextStyle(
                            fontFamily: 'Gotham',
                            overflow: TextOverflow.ellipsis,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w900,
                            fontSize: font20,
                            color: mainColor,
                          ))
                    ])),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(
                      () => editRecordEntry(
                            description: title,
                            cost: value,
                            userRecord: userRecord,
                          ),
                      transition: Transition.rightToLeft,
                      duration: Duration(milliseconds: 200));
                },
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.edit,
                      size: height20,
                      color: mainBlack,
                    ),
                  ),
                  height: height20 * 2,
                  width: width10 * 5,
                  decoration: const BoxDecoration(
                      color: mainColor,
                      borderRadius:
                          BorderRadius.only(topRight: Radius.circular(8))),
                ),
              ),
              GestureDetector(
                onTap: () {
                  userRecord.totalCost.value -= value;
                  userRecord.subDetails.remove(title);
                  expensesGetx.updateLocalData();
                  cloudData.removeExpenseDetailData(userRecord.toJson());
                },
                child: Container(
                  child: Center(
                    child: Image.asset(
                      bin_icon,
                      height: height20,
                      width: width25,
                      color: mainBlack,
                    ),
                  ),
                  height: height20 * 2,
                  width: width25 * 2,
                  decoration: BoxDecoration(
                      color: mainRed,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(8))),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
