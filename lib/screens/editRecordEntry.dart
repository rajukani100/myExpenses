import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_expense/getx/models/records_getx.dart';
import 'package:my_expense/services/cloud_data.dart';
import 'package:my_expense/utils/color.dart';
import 'package:my_expense/utils/responsive.dart';
import 'package:my_expense/widgets/custom_button.dart';
import 'package:my_expense/widgets/input_Text.dart';

class editRecordEntry extends StatelessWidget {
  String description;
  double cost = 0;
  UserRecord userRecord;

  late TextEditingController descriptionController;
  late TextEditingController costController;

  editRecordEntry(
      {super.key,
      required this.description,
      required this.cost,
      required this.userRecord}) {
    descriptionController = TextEditingController(text: description);
    costController = TextEditingController(text: cost.toString());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: mainBackgorund,
        body: Column(
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
                    padding: EdgeInsets.symmetric(horizontal: width20),
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
                    width: width350,
                    height: height55,
                    child: GestureDetector(
                      onTap: () {
                        if (descriptionController.text.isNotEmpty) {
                          userRecord.editSubDetail(
                              description,
                              descriptionController.text,
                              double.parse(costController.text));

                          cloudData
                              .updateExpenseDetailData(userRecord.toJson());

                          Get.back();
                        }
                      },
                      child: customButton(
                        value: "edit",
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
