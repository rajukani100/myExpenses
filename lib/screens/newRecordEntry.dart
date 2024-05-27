import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_expense/getx/models/records_getx.dart';
import 'package:my_expense/services/cloud_data.dart';
import 'package:my_expense/utils/color.dart';
import 'package:my_expense/utils/responsive.dart';
import 'package:my_expense/widgets/custom_button.dart';
import 'package:my_expense/widgets/input_Text.dart';

class newRecordEntry extends StatelessWidget {
  String description = "";
  double cost = 0;
  UserRecord uesrRecord;

  TextEditingController descriptionController = TextEditingController();
  TextEditingController costController = TextEditingController();

  newRecordEntry({super.key, required this.uesrRecord});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBackgorund,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height20 / 2,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width10),
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back,
                  size: height15 * 2,
                  color: Colors.black,
                ),
              ),
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height55,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width10 * 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.description_outlined,
                          color: mainBlack,
                          size: width35,
                        ),
                        Container(
                          height: height55,
                          width: width290,
                          child: inputText(
                              inputString: "description",
                              controller: descriptionController),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height20 / 2,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.money,
                          color: mainBlack,
                          size: width35,
                        ),
                        Container(
                          height: height55,
                          width: width290,
                          child: inputText(
                            inputString: "paid money",
                            controller: costController,
                            isNum: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height20,
                  ),
                  Container(
                    width: width300,
                    height: height55,
                    child: GestureDetector(
                      onTap: () {
                        if (descriptionController.text.isNotEmpty) {
                          uesrRecord.setSubDetail(descriptionController.text,
                              double.parse(costController.text));
                          cloudData
                              .updateExpenseDetailData(uesrRecord.toJson());

                          Get.back();
                        }
                      },
                      child: customButton(
                        value: "add",
                        color: mainColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
