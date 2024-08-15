import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marksheetscanner/GlobalComponents/colorConfig.dart';
import 'package:marksheetscanner/GlobalComponents/fontconfig.dart';
import 'package:marksheetscanner/GlobalComponents/globalText.dart';

class CustomDialog {
  myDialog({
    required String dialog,
    Function()? onDismiss,
    required BuildContext context,
  }) async {
    showDialog(
      barrierColor: black.withOpacity(0.3),
      context: context,
      builder: (context) => PopScope(
        canPop: false,
        child: Dialog(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              alignment: FractionalOffset.center,
              // height: 80.0,
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: white,
                  ),
                  SizedBox(
                    height: 14.h,
                  ),
                  GlobalText(
                    text: dialog,
                    color: white,
                    fontSize: 10.sp,
                    fontFamily: FontConfig.poppinsRegular,
                  )
                ],
              )),
        ),
      ),
    );
  }
}
