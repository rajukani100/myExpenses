import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:my_expense/getx/models/records_getx.dart';
import 'package:my_expense/getx/expenses_getx.dart';
import 'package:my_expense/main.dart';
import 'package:my_expense/screens/detail_screen.dart';
import 'package:my_expense/services/cloud_data.dart';
import 'package:my_expense/utils/color.dart';
import 'package:my_expense/utils/responsive.dart';
import 'package:my_expense/widgets/custom_snackbar.dart';
import 'package:my_expense/widgets/record_box.dart';

//data
final currentDate =
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
ExpensesGetx expensesGetx = ExpensesGetx();

bool isFirstTime = true;

class myHome extends StatefulWidget {
  myHome({super.key});

  @override
  State<myHome> createState() => _myHomeState();
}

class _myHomeState extends State<myHome> {
  //some data
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    // first try to load data in offline mode, if no data found then it will try in online mode
    http.Response test = await http.get(Uri.parse(
        "https://raw.githubusercontent.com/rajukani100/myExpenses/main/VERSION_INFO"));
    if (test.statusCode == 200) {
      checkConnectivity(await Connectivity().checkConnectivity());
      FirebaseAuth.instance.currentUser!.reload();
      expensesGetx.expenses.clear();
      for (Map data in expensesGetx.getLocalData()!) {
        expensesGetx.jsonToExpense(data);
      }
      if (expensesGetx.getLocalData()!.isEmpty) {
        cloudData.fetchData();
      }
      expensesGetx.expenses.sort((a, b) => UserRecord.compareById(b, a));
    }
  }

  @override
  Widget build(BuildContext context) {
    //App update
    if (isFirstTime) {
      checkAppUpdate(context);
      isFirstTime = false;
    }

    return Stack(
      children: [
        Center(
          child: Column(
            children: [
              SizedBox(
                height: height15,
              ),
              GestureDetector(
                onTap: () async {
                  try {
                    expensesGetx.filterExpenses.value = [].obs;
                    helperGetx.dateRange.value =
                        await showCalendarDatePicker2Dialog(
                      context: context,
                      config: CalendarDatePicker2WithActionButtonsConfig(
                          selectedRangeHighlightColor: const Color(0xFF11999E),
                          selectedRangeDayTextStyle:
                              const TextStyle(color: mainBackgorund),
                          selectedDayHighlightColor: mainColor,
                          calendarType: CalendarDatePicker2Type.range),
                      dialogSize: Size(width325, height400),
                      value: [],
                      borderRadius: BorderRadius.circular(15),
                      dialogBackgroundColor: mainBackgorund,
                    ) as List<dynamic>;
                    if (helperGetx.dateRange.length == 2) {
                      expensesGetx.filterExpense(
                          helperGetx.dateRange[0], helperGetx.dateRange[1]);
                      helperGetx.isDateFilter.value = true;
                    } else {
                      helperGetx.isDateFilter.value = false;
                    }
                  } catch (e) {
                    helperGetx.isDateFilter.value = false;
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 1)),
                  width: width359,
                  height: height55,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width15),
                    child: Row(
                      children: [
                        Icon(
                          Icons.date_range,
                          color: mainGrey,
                          size: height25,
                        ),
                        SizedBox(
                          width: width10,
                        ),
                        Expanded(
                            child: Obx(() => Text(
                                (helperGetx.isDateFilter.value == false)
                                    ? "Filter by date"
                                    : "${helperGetx.dateRange[0]!.day}-${helperGetx.dateRange[0]!.month}-${helperGetx.dateRange[0]!.year} to ${helperGetx.dateRange[1]!.day}-${helperGetx.dateRange[1]!.month}-${helperGetx.dateRange[1]!.year}",
                                style: TextStyle(
                                    fontFamily: 'Gotham',
                                    fontStyle: FontStyle.normal,
                                    fontSize: font20,
                                    color: mainGrey))))
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height20,
              ),
              Text(
                "Record",
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
              Obx(
                () => (helperGetx.isLoading.value == false)
                    ? Expanded(
                        child: RefreshIndicator(
                        color: mainColor,
                        onRefresh: () async {
                          http.Response test = await http.get(Uri.parse(
                              "https://raw.githubusercontent.com/rajukani100/myExpenses/main/VERSION_INFO"));
                          if (test.statusCode == 200) {
                            expensesGetx.expenses.clear();
                            cloudData.fetchData();
                          }
                        },
                        child: Container(
                          child: ListView.separated(
                              separatorBuilder: (context, index) => SizedBox(
                                    height: height20 / 2,
                                  ),
                              itemBuilder: (context, index) {
                                return recordBox(
                                    userRecord:
                                        (helperGetx.isDateFilter.value == false)
                                            ? expensesGetx.expenses[index]
                                            : expensesGetx
                                                .filterExpenses[index]);
                              },
                              itemCount:
                                  (helperGetx.isDateFilter.value == false)
                                      ? expensesGetx.expenses.length
                                      : expensesGetx.filterExpenses.length),
                        ),
                      ))
                    : Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: height45,
                              width: height45,
                              child: CircularProgressIndicator(
                                color: mainColor,
                                strokeWidth: 3,
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
              SizedBox(
                height: height20 / 2,
              )
            ],
          ),
        ),
        Positioned(
            bottom: 20,
            right: 10,
            child: GestureDetector(
              onTap: () {
                try {
                  var record = UserRecord(id: Rx(DateTime.now()));
                  expensesGetx.add(record);

                  expensesGetx.updateLocalData();
                  cloudData.newRecordEntryUpdateData(record.toJson());

                  Get.to(() => detailScreen(userRecord: record),
                      transition: Transition.rightToLeft,
                      duration: Duration(milliseconds: 200));
                } catch (e) {
                  showSnackBar(
                      context,
                      "Could not connect to the server.Please check your internet connection and try again !",
                      Color(0xFFFF0000));
                }
              },
              child: Container(
                width: height70,
                height: height70,
                decoration: const BoxDecoration(
                    color: mainColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 8.0,
                      ),
                    ]),
                child: Center(
                    child: Text(
                  "+",
                  style: TextStyle(fontSize: font20 * 2, color: Colors.white),
                )),
              ),
            ))
      ],
    );
  }
}
