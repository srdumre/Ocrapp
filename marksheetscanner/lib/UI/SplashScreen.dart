import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:marksheetscanner/Controllers/NavigationController.dart';

class SplashScreen extends StatelessWidget {
  final NavigateController navigateController = Get.put(NavigateController());
  SplashScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: navigateController,
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/Applogo.png',
                    width: 200.w,
                    height: 200.h,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
