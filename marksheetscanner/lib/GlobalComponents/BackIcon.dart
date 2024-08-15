import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:marksheetscanner/GlobalComponents/colorConfig.dart';
import 'package:marksheetscanner/Theme/ThemeController.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class BackIcon extends StatelessWidget {
  final ThemeController _themeController = Get.find();
  BackIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Icon(
        MdiIcons.arrowLeftCircle,
        size: 20.sp,
        color: _themeController.isDarkMode.value ? white : black,
      ),
    );
  }
}
