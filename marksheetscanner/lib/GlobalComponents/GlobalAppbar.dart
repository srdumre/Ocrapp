import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:marksheetscanner/GlobalComponents/BackIcon.dart';
import 'package:marksheetscanner/GlobalComponents/colorConfig.dart';
import 'package:marksheetscanner/GlobalComponents/fontconfig.dart';
import 'package:marksheetscanner/Theme/ThemeController.dart';

class GlobalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ThemeController _themeController = Get.find<ThemeController>();
  final String text;
  final List<Widget>? actions;

  GlobalAppBar({Key? key, required this.text, this.actions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:
          _themeController.isDarkMode.value ? darkThemeColor : lightThemeColor,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: BackIcon(),
      ),
      title: Text(
        text,
        style: TextStyle(
          color:
              _themeController.isDarkMode.value ? Colors.white : Colors.black,
          fontFamily: FontConfig.poppinsMedium,
          fontSize: 18.sp,
        ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.h);
}
