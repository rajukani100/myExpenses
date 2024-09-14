import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_expense/getx/models/records_getx.dart';
import 'package:my_expense/main.dart';
import 'package:my_expense/screens/home_screen.dart';

class cloudData {
  static void fetchData() async {
    try {
      helperGetx.isLoading.value = true;

      final DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('records')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .get();
      Map data = documentSnapshot.data() as Map;
      data.forEach((key, value) {
        expensesGetx.jsonToExpense(value);
      });
      expensesGetx.expenses.sort((a, b) => UserRecord.compareById(b, a));

      helperGetx.isLoading.value = false;
    } catch (e) {
      //offline data
      FirebaseAuth.instance.currentUser!.reload(); // checking user state
      expensesGetx.expenses.clear();
      for (Map data in expensesGetx.getLocalData()!) {
        expensesGetx.jsonToExpense(data);
      }
      helperGetx.isLoading.value = false;
    }
  }

  static Future<void> newRecordEntryUpdateData(Map data) async {
    try {
      final CollectionReference collection =
          FirebaseFirestore.instance.collection('records');
      await collection
          .doc("${FirebaseAuth.instance.currentUser!.email}")
          .set({"${data["id"]}": data}, SetOptions(merge: true));
    } catch (e) {
      //error
    }
  }

  static Future<void> removeRecordEntryUpdateData(Map data) async {
    try {
      await FirebaseFirestore.instance
          .collection('records')
          .doc("${FirebaseAuth.instance.currentUser!.email}")
          .set({"${data["id"]}": FieldValue.delete()}, SetOptions(merge: true));
    } catch (e) {
      //error
    }
  }

  static Future<void> updateExpenseDetailData(Map data) async {
    try {
      // first removing data
      await FirebaseFirestore.instance
          .collection('records')
          .doc("${FirebaseAuth.instance.currentUser!.email}")
          .set({"${data["id"]}": FieldValue.delete()}, SetOptions(merge: true));

      // again writing data
      await FirebaseFirestore.instance
          .collection('records')
          .doc("${FirebaseAuth.instance.currentUser!.email}")
          .set({"${data["id"]}": data}, SetOptions(merge: true));
    } catch (e) {
      //error
    }
  }

  static Future<void> removeExpenseDetailData(Map data) async {
    try {
      // first removing data
      await FirebaseFirestore.instance
          .collection('records')
          .doc("${FirebaseAuth.instance.currentUser!.email}")
          .set({"${data["id"]}": FieldValue.delete()}, SetOptions(merge: true));

      // again writing data
      await FirebaseFirestore.instance
          .collection('records')
          .doc("${FirebaseAuth.instance.currentUser!.email}")
          .set({"${data["id"]}": data}, SetOptions(merge: true));
    } catch (e) {
      //error
    }
  }

  static Future<void> writeNotes(String value) async {
    try {
      await FirebaseFirestore.instance
          .collection("notes")
          .doc("${FirebaseAuth.instance.currentUser!.email}")
          .set({"note": value});
    } catch (e) {
      //error
    }
  }

  static Future<String> getNotes() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection("notes")
          .doc("${FirebaseAuth.instance.currentUser!.email}")
          .get();
      return documentSnapshot.get('note');
    } catch (e) {
      //error
    }
    return "";
  }
}
