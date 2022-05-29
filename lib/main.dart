import 'dart:convert';
import 'dart:io';
import 'package:benix/notification.dart';
import 'package:benix/splash.dart';
import 'package:benix/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:request_api_helper/helper/database.dart';
import 'package:request_api_helper/loading.dart';
import 'package:request_api_helper/request.dart';
import 'package:request_api_helper/request_api_helper.dart';
import 'package:request_api_helper/session.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(statusBarIconBrightness: Brightness.light, statusBarBrightness: Brightness.light));
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(statusBarIconBrightness: Brightness.dark, statusBarBrightness: Brightness.dark));
  try {
    await Firebase.initializeApp();
  } finally {}
  HttpOverrides.global = MyHttpOverrides();
  await RequestApiHelper.init(
    RequestApiHelperData(
      baseUrl: 'https://admin.benix.id/api/',
      debug: true,
      navigatorKey: navigatorKey,
      onError: (res) {
        final parse = json.decode(res.body);
        if (parse['message'] != null) {
          Fluttertoast.showToast(msg: parse['message']);
        }
      },
    ),
  );
  Loading.widget = (context) async {
    await showDialog(
      context: context,
      builder: (context) {
        Loading.currentContext = context;
        Loading.lastContext = context;
        return const Center(child: CircularProgressIndicator());
      },
    );
    Loading.currentContext = context;
  };
  runApp(const MyApp());

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();
  String notificationTitle = 'No Title';
  String notificationBody = 'No Body';
  String notificationData = 'No Data';
  @override
  void initState() {
    super.initState();
    BaseColor.setColor();
    try {
      final firebaseMessaging = FCM();
      firebaseMessaging.setNotifications();

      firebaseMessaging.streamCtlr.stream.listen(_changeData);
      firebaseMessaging.bodyCtlr.stream.listen(_changeBody);
      firebaseMessaging.titleCtlr.stream.listen(_changeTitle);
    } finally {}
  }

  _changeData(String msg) => setState(() => notificationData = msg);
  _changeBody(String msg) => setState(() => notificationBody = msg);
  _changeTitle(String msg) => setState(() => notificationTitle = msg);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: MaterialApp(
        title: 'Bennix',
        debugShowCheckedModeBanner: false,
        theme: themeDatas(false, context),
        navigatorKey: navigatorKey,
        home: const Splash(),
      ),
    );
  }
}
