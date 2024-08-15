import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marksheetscanner/GlobalComponents/DropBackGesture.dart';
import 'package:marksheetscanner/GlobalComponents/colorConfig.dart';
import 'package:marksheetscanner/GlobalComponents/fontconfig.dart';
import 'package:marksheetscanner/GlobalComponents/rtlslide.dart';

class GlobalButton extends StatelessWidget {
  final Color? color;
  final String? text;
  final Function()? onTap;
  final int? duration;
  final Color? textColor;
  final Color? borderColor;
  final bool isLoading;

  GlobalButton({
    super.key,
    this.color,
    this.text,
    this.onTap,
    this.duration,
    this.textColor,
    this.borderColor,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SlideFadeTransition(
      animationDuration: Duration(milliseconds: duration ?? 0),
      direction: Direction.horizontal,
      child: BackDropGesture(
        onTap: isLoading ? null : onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: color ?? themeColor,
            border: Border.all(
              color: borderColor ?? Colors.transparent,
              width: 1.5.r,
            ),
          ),
          child: Center(
            child: isLoading
                ? SizedBox(
                    height: 24.h,
                    width: 24.h,
                    child: CircularProgressIndicator(
                      color: textColor ?? white,
                      strokeWidth: 2.0,
                    ),
                  )
                : Text(
                    text ?? "",
                    style: TextStyle(
                      fontFamily: FontConfig.poppinsBold,
                      color: textColor ?? white,
                      fontWeight: FontWeight.w500,
                      fontSize: 11.sp,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
