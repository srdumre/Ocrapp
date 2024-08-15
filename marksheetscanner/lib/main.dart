import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:marksheetscanner/Controllers/NavigationController.dart';
import 'package:marksheetscanner/Theme/ThemeController.dart';
import 'package:marksheetscanner/UI/SplashScreen.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await requestPermissions();

  Get.put(NavigateController());
  Get.put(ThemeController());

  runApp(MyApp());
}

Future<void> requestPermissions() async {
  await Permission.storage.request();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => GetMaterialApp(
        title: 'Marksheet Scanner',
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
