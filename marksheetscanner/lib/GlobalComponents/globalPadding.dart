import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// default horizontal padding for widgets

class GlobalHorizontallPadding extends StatelessWidget {
  final child;
  final double? padding;
  const GlobalHorizontallPadding({super.key, this.padding, this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding ?? 14.w),
      child: child,
    );
  }
}

// default Vertical padding for widgets

class GlobalVerticalPadding extends StatelessWidget {
  final child;

  final double? padding;
  const GlobalVerticalPadding({super.key, this.padding, this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding ?? 12.h),
      child: child,
    );
  }
}

// Global Mediaquery Sizes

class GlobalSizes {
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width.w;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height.h;
  }
}
