import 'package:get/get.dart';
import 'package:my_expense/screens/home_screen.dart';

class UserRecord extends GetxController {
  Rx<DateTime> id;

  RxDouble totalCost = 0.0.obs;

  RxMap subDetails = {}.obs;

  UserRecord({required this.id});

  static int compareById(UserRecord a, UserRecord b) {
    // Accessing value of Rx<DateTime> id
    final DateTime dateA = a.id.value;
    final DateTime dateB = b.id.value;
    return dateA.compareTo(dateB); // Comparing dates
  }

  void setSubDetail(String key, double value) {
    subDetails[key] = value;
    getTotal();
    subDetails.refresh();
    expensesGetx.updateLocalData();
  }

  void editSubDetail(String oldKey, String key, double value) {
    subDetails.remove(oldKey);
    subDetails[key] = value;
    getTotal();
    subDetails.refresh();
    expensesGetx.updateLocalData();
  }

  void getTotal() {
    totalCost.value = 0;
    subDetails.forEach((key, value) {
      totalCost.value += value;
    });
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id.value.toIso8601String(), // Convert DateTime? to ISO 8601 string
      'totalCost': totalCost.value,
      'subDetails': subDetails,
    };
  }
}
