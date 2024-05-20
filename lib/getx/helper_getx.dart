import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HelperGetx extends GetxController {
  RxBool isLoading = false.obs;

  RxList dateRange = <dynamic>[].obs;

  RxBool isDateFilter = RxBool(false);
  RxList toDate = RxList([DateTime.now()]);
  RxList fromDate = RxList([DateTime.now()]);

  void checkEmailVerification() async {
    var currentUser = FirebaseAuth.instance.currentUser!;
    await currentUser.reload();
    if (currentUser.emailVerified == true) {
      Get.back();
      await FirebaseAuth.instance.currentUser!.reload();
    }
  }
}
