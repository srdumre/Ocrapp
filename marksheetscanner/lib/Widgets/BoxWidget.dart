import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:marksheetscanner/Theme/ThemeController.dart';
import 'package:marksheetscanner/GlobalComponents/colorConfig.dart';
import 'package:marksheetscanner/GlobalComponents/fontconfig.dart';
import 'package:marksheetscanner/GlobalComponents/GlobalText.dart'; // Adjust import as needed

class BoxCard extends StatelessWidget {
  final String svgPath;
  final String title;
  final Function() onTap;
  final ThemeController _themeController = Get.find<ThemeController>();

  BoxCard({
    required this.svgPath,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (controller) {
        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Container(
              width: 0.35.sw,
              height: 90.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: _themeController.isDarkMode.value
                    ? darkContainerColor
                    : white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    offset: Offset(0.1, 0.5),
                    blurRadius: 3,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(8.sp),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Center(
                      child: SvgPicture.asset(
                        svgPath,
                        width: 20.sp,
                        height: 20.sp,
                        color: appMainColor,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Center(
                      child: GlobalText(
                        text: title,
                        color: _themeController.isDarkMode.value
                            ? white
                            : appMainColor,
                        fontSize: 10.sp,
                        fontFamily: FontConfig.poppinsMedium,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
