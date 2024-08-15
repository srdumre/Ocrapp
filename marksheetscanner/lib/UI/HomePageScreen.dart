import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:marksheetscanner/Controllers/ImagePickerController.dart';
import 'package:marksheetscanner/GlobalComponents/colorConfig.dart';
import 'package:marksheetscanner/GlobalComponents/globalPadding.dart';
import 'package:marksheetscanner/GlobalComponents/globalText.dart';
import 'package:marksheetscanner/Theme/ThemeController.dart';
import 'package:marksheetscanner/UI/CsvFileView.dart';
import 'package:marksheetscanner/Widgets/BoxWidget.dart';

class Homepagescreen extends StatelessWidget {
  final ImageController _imageController = Get.put(ImageController());
  final ThemeController _themeController = Get.find();

  Homepagescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          _themeController.isDarkMode.value ? darkThemeColor : lightThemeColor,
      appBar: AppBar(
        backgroundColor: _themeController.isDarkMode.value
            ? darkThemeColor
            : lightThemeColor,
        title: GlobalText(
          text: "MarkSheet Scanner",
          fontSize: 18,
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: GlobalHorizontallPadding(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CSVFileListWidget(),
                  SizedBox(height: 200.h),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: _themeController.isDarkMode.value
                    ? darkThemeColor
                    : lightThemeColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8.0,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: BoxCard(
                      svgPath: 'assets/svg/camera.svg',
                      title: 'Camera',
                      onTap: () {
                        _imageController.pickImageFromCamera(context);
                      },
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: BoxCard(
                      svgPath: 'assets/svg/gallery.svg',
                      title: 'Gallery',
                      onTap: () {
                        _imageController.pickImageFromGallery(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
