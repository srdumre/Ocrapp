import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:marksheetscanner/GlobalComponents/colorConfig.dart';
import 'package:marksheetscanner/GlobalComponents/globalPadding.dart';
import 'package:marksheetscanner/GlobalComponents/rtlslide.dart';
import 'package:marksheetscanner/Theme/ThemeController.dart';

class GlobalIcon extends StatelessWidget {
  final ThemeController _themeController = Get.find();

  final IconData icon;
  final color;
  final double? size;
  final Function()? onTap;
  final int? duration;
  final double? padding;
  GlobalIcon(
      {super.key,
      required this.icon,
      this.color,
      this.size,
      this.onTap,
      this.duration,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return SlideFadeTransition(
      animationDuration: Duration(milliseconds: duration ?? 0),
      direction: Direction.horizontal,
      child: GlobalHorizontallPadding(
        padding: padding ?? 14.w,
        child: GestureDetector(
            onTap: onTap,
            child: Icon(
              icon,
              color: _themeController.isDarkMode.value ? white : themeColor,
              size: size,
            )),
      ),
    );
  }
}
