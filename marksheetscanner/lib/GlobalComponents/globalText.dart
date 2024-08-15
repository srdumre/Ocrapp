import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:marksheetscanner/GlobalComponents/colorConfig.dart';
import 'package:marksheetscanner/GlobalComponents/fontconfig.dart';
import 'package:marksheetscanner/GlobalComponents/globalPadding.dart';
import 'package:marksheetscanner/GlobalComponents/rtlslide.dart';
import 'package:marksheetscanner/Theme/ThemeController.dart';

class GlobalText extends StatelessWidget {
  final String? fontFamily;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String text;
  final int? animationDuration;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLine;
  final TextOverflow? textOverflow;
  final double? padding;
  final TextDecoration? textDecoration; // Added this line
  final ThemeController _themeController = Get.find();
  GlobalText(
      {super.key,
      this.fontFamily,
      this.fontSize,
      this.fontWeight,
      required this.text,
      this.animationDuration,
      this.color,
      this.textAlign,
      this.maxLine,
      this.textOverflow,
      this.textDecoration, // Added this line
      this.padding});

  @override
  Widget build(BuildContext context) {
    return SlideFadeTransition(
      animationDuration: Duration(milliseconds: animationDuration ?? 0),
      direction: Direction.horizontal,
      child: GlobalHorizontallPadding(
        child: Text(
          text,
          textAlign: textAlign ?? TextAlign.start,
          maxLines: maxLine ?? 50,
          overflow: textOverflow ?? TextOverflow.ellipsis,
          style: TextStyle(
              color: (color == null)
                  ? _themeController.isDarkMode.value
                      ? white
                      : black
                  : color,
              fontFamily: fontFamily ?? FontConfig.poppinsMedium,
              fontSize: fontSize ?? 12.sp,
              decoration:
                  textDecoration ?? TextDecoration.none, // Added this line
              fontWeight: fontWeight ?? FontWeight.normal),
        ),
      ),
    );
  }
}
