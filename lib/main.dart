// ignore_for_file: prefer_const_constructors, use_key_in_widget_construc, prefer_is_empty
import 'package:MaaAlankar/Fun/Notification_Services/local_not.dart';
import 'package:MaaAlankar/Login/LoginScreen.dart';
import 'package:MaaAlankar/Login/SplashScreen.dart';
import 'package:MaaAlankar/Screen/Dashboard/HomeScreen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

var _local;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await SharedPreferences.getInstance();
  // await NotificationService();

  await FlutterLocalNotificationsPlugin();
  tz.initializeTimeZones();

  // options:
  // DefaultFirebaseOptions.currentPlatform;
  // Initializing Firebase
  // await Firebase.initializeApp();

  runApp(MyApp());
}

late Widget? showFirstScreen;

class MyApp extends StatefulWidget {
  static String? email = '';
  static String? password = '';
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    getInitialScreen().whenComplete(() => setState(() {
          isFirstLoad = false;
        }));
    _requestPermissions();
  }

  bool isFirstLoad = true;

  Future<void> getInitialScreen() async {
    String mobileno = '';
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      mobileno = preferences.getString('mobileno')!;
    } catch (Exception) {}

    showFirstScreen = mobileno.length > 0 ? HomeScreeen() : LoginScreen();
    await Future.delayed(Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 2), () async {
      String email = '';
      var password = '';
      try {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        email = preferences.getString('email')!;
        password = preferences.getString('password')!;
        setState(() {
          MyApp.email = email;
          MyApp.password = password;
        });
      } catch (Exception) {}

      showFirstScreen = email.isNotEmpty ? HomeScreeen() : LoginScreen();
    });
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      title: 'Maa Alankar Jewellers',
      home: isFirstLoad ? SplashScreen() : showFirstScreen,
    );
  }

  Future<void> _requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      // Permission.location,
      // Permission.storage,
      Permission.notification,
      // Add more permissions as needed
    ].request();

    // Handle permission statuses if needed
    // For example, check if any permission is denied
    if (statuses.containsValue(PermissionStatus.denied)) {
      // Handle denied permissions
    }
  }
}
