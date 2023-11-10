import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:retailerapp/login.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import 'Nav/navbar.dart';
import 'reports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(const MyApp());
}
var currentUserId;
var currentStationEail;
var currentStationName;
var currentStationPlace;
double walletBal = 0;
bool ?loggedin ;
bool isLoggedIn = false;

class MyApp extends StatefulWidget {

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // void checkLoginStatus() async {
  //   // SharedPreferences prefs = await SharedPreferences.getInstance();
  //   // bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  //   setState(() {
  //     isLoggedIn = isLoggedIn;
  //   });
  // }
  // void onLoginSuccess() async {
  //   // SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     isLoggedIn = true;
  //   });
  //   // await prefs.setBool('isLoggedIn', true);
  //
  //
  // }
  @override
  void initState() {
    // checkLoginStatus();
    // onLoginSuccess();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,
      // home:loggedin == true? Navigation(index: 0):Login(),
      home: isLoggedIn ? Navigation(index: 0,) : Login(),
    );
  }
}
