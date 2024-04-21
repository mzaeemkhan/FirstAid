import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:first_aid/language/language_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../modules/splash/splash_screen.dart';
import 'shared/constants/app_theme.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      builder: (context,widget) => GetMaterialApp(
        translations: Languages(), // your translations
        locale: Locale('en', 'US'), // translations will be displayed in that locale
        fallbackLocale: Locale('en', 'UK'),
        theme: getLightThemeData(),
        darkTheme: getLightThemeData(),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}