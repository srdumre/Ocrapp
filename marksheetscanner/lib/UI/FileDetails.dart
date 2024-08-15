import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:marksheetscanner/Controllers/FetchCsvFileController.dart';
import 'package:marksheetscanner/GlobalComponents/GlobalAppbar.dart';
import 'package:marksheetscanner/GlobalComponents/GlobalButton.dart';
import 'package:marksheetscanner/GlobalComponents/colorConfig.dart';
import 'package:marksheetscanner/GlobalComponents/globalText.dart';
import 'package:marksheetscanner/Model/TextRecogonizedModel.dart';
import 'package:marksheetscanner/Theme/ThemeController.dart';
import 'package:marksheetscanner/UI/TextToPdf.dart';

class CSVFileDetailPage extends StatelessWidget {
  final CSVFileModel file;
  final ThemeController _themeController = Get.find();
  final CSVFileController _csvFileController = Get.find();

  CSVFileDetailPage({required this.file});

  @override
  Widget build(BuildContext context) {
    log(file.filePath);
    return Scaffold(
      backgroundColor:
          _themeController.isDarkMode.value ? darkThemeColor : lightThemeColor,
      appBar: GlobalAppBar(
        text: 'File Details',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GlobalText(
              text: 'File ID: ${file.id}',
            ),
            SizedBox(height: 8.h),
            GlobalText(
              text: 'File Path: ${file.filePath}',
            ),
            SizedBox(height: 8.h),
            GlobalText(
              text: 'Created At: ${file.createdAt.toLocal()}',
            ),
            SizedBox(height: 16.h),
            GlobalButton(
              text: "Download CSV",
              onTap: () async {
                await _csvFileController.downloadCsv(file.filePath);
              },
            ),
          ],
        ),
      ),
    );
  }
}
