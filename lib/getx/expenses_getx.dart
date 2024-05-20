import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_expense/getx/models/records_getx.dart';
import 'package:hive/hive.dart';

class ExpensesGetx extends GetxController {
  ExpensesGetx() {}

  RxList expenses = <dynamic>[].obs;

  RxList filterExpenses = <dynamic>[].obs;

  double calculateTotal(DateTime first, DateTime last) {
    double total = 0;
    for (var i = 0; i < expenses.length; i++) {
      if (expenses[i].id.value.compareTo(first) >= 0 &&
          expenses[i].id.value.compareTo(last.copyWith(hour: 24)) <= 0) {
        total += expenses[i].totalCost.value;
      }
    }
    return total;
  }

  void removeRecord(UserRecord obj) {
    expenses.remove(obj);
    updateLocalData();
  }

  List expensesToJson() {
    return expenses.map((record) => record.toJson()).toList();
  }

  void jsonToExpense(Map expense) {
    DateTime dateTime = DateTime.parse(expense["id"]);
    UserRecord temp = UserRecord(id: Rx(dateTime));
    temp.subDetails.value = expense["subDetails"];
    temp.totalCost.value = expense["totalCost"];
    add(temp);
  }

  void updateLocalData() async {
    var box = Hive.box("myExpenses");
    await box.put("records", expensesToJson());
  }

  void removeLocalData() async {
    var box = Hive.box("myExpenses");
    await box.delete("records");
  }

  List? getLocalData() {
    var box = Hive.box("myExpenses");
    return box.get("records") ?? [];
  }

  void filterExpense(DateTime first, DateTime last) {
    for (var i = 0; i < expenses.length; i++) {
      if (expenses[i].id.value.compareTo(first) >= 0 &&
          expenses[i].id.value.compareTo(last) <= 0) {
        filterExpenses.add(expenses[i]);
      }
    }
  }

  void add(UserRecord record) {
    expenses.add(record);
    updateLocalData();
  }
}
