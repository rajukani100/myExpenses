import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:my_expense/firebase_options.dart';
import 'package:my_expense/getx/bottomNavbarGetx.dart';
import 'package:my_expense/getx/helper_getx.dart';
import 'package:my_expense/screens/login_screen.dart';
import 'package:my_expense/screens/no_internet_screen.dart';
import 'package:my_expense/utils/color.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  var directory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(directory.path);
  await Hive.openBox('myExpenses');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  FlutterNativeSplash.remove();
  runApp(myApp());
}

late double screenHeight;
late double screenWidth;
late StreamSubscription subscription;
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
HelperGetx helperGetx = HelperGetx();
BottomNavbarGetx bottomNavbarGetx = BottomNavbarGetx();

class myApp extends StatefulWidget {
  myApp({super.key});

  @override
  State<myApp> createState() => _myAppState();
}

Future<void> checkAppUpdate(BuildContext context) async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String currentAppVersion = packageInfo.version;

  http.Response latestAppVersion = await http.get(Uri.parse(
      "https://raw.githubusercontent.com/rajukani100/myExpenses/main/VERSION_INFO"));
  if (latestAppVersion.body.compareTo(currentAppVersion) != 0) {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Update"),
          content: Text("Exciting news! A new app update is available now!"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "skip",
                style: TextStyle(color: mainColor),
              ),
            ),
            TextButton(
              onPressed: () async {
                if (await canLaunchUrl(Uri.parse(
                    "https://github.com/rajukani100/myExpenses/releases/latest"))) {
                  await launchUrl(
                    Uri.parse(
                        "https://github.com/rajukani100/myExpenses/releases/latest"),
                    mode: LaunchMode.externalApplication,
                  );
                }
              },
              child: Text(
                "Download",
                style: TextStyle(color: mainColor),
              ),
            ),
          ],
        );
      },
    );
  }
}

void checkConnectivity() async {
  List<ConnectivityResult> result = await Connectivity().checkConnectivity();

  if (!result.contains(ConnectivityResult.wifi) &&
      !result.contains(ConnectivityResult.mobile) &&
      !result.contains(ConnectivityResult.vpn)) {
    // no internet
    Get.to(() => noInternetScreen());
  } else {
    //internet
    Get.back();
  }
}

class _myAppState extends State<myApp> {
  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(milliseconds: 300), (timer) {
      checkConnectivity();
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //responsive UI
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              FirebaseAuth.instance.currentUser!.emailVerified) {
            return Scaffold(
              backgroundColor: mainBackgorund,
              body: Obx(
                  () => SafeArea(child: bottomNavbarGetx.currentScreen.value)),
              bottomNavigationBar: Obx(() => BottomNavigationBar(
                      backgroundColor: mainColor,
                      fixedColor: mainBlack,
                      unselectedItemColor: Colors.white,
                      currentIndex: bottomNavbarGetx.navbarIndex.value,
                      type: BottomNavigationBarType.fixed,
                      unselectedIconTheme: IconThemeData(),
                      onTap: (value) {
                        bottomNavbarGetx.changeScreen(value);
                      },
                      items: const [
                        BottomNavigationBarItem(
                            icon: Icon(Icons.home), label: "Home"),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.calculate), label: "Calculate"),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.settings), label: "Setting"),
                      ])),
            );
          } else {
            return Scaffold(
              backgroundColor: mainBackgorund,
              body: myLogin(),
            );
          }
        },
      ),
    );
  }
}
