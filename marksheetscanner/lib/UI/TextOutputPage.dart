import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:marksheetscanner/Controllers/PostrepcgpnizedTextController.dart';
import 'package:marksheetscanner/GlobalComponents/GlobalAppbar.dart';
import 'package:marksheetscanner/GlobalComponents/colorConfig.dart';
import 'package:marksheetscanner/GlobalComponents/globalText.dart';
import 'package:marksheetscanner/GlobalComponents/globalButton.dart';
import 'package:marksheetscanner/Theme/ThemeController.dart';
import 'package:marksheetscanner/UI/TextToPdf.dart';

class TextOutputPage extends StatelessWidget {
  final String recognizedText;
  final ThemeController _themeController = Get.find();
  final RecognizedTextController recognizedTextController =
      Get.put(RecognizedTextController());

  TextOutputPage({super.key, required this.recognizedText});

  @override
  Widget build(BuildContext context) {
    log(recognizedText);

    List<String> textChunks = _splitText(recognizedText, 1500);

    return Scaffold(
      backgroundColor:
          _themeController.isDarkMode.value ? darkThemeColor : lightThemeColor,
      appBar: GlobalAppBar(
        text: "Text Output",
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: recognizedText.split('\n').map((line) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: GlobalText(
                        text: line,
                        fontSize: 16.0,
                        color: _themeController.isDarkMode.value
                            ? Colors.white
                            : Colors.black,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            GlobalButton(
              text: 'Convert to Pdf',
              onTap: () {
                Get.to(PdfView(
                  recognizedtext: textChunks.toString(),
                ));
              },
            ),
            SizedBox(height: 16.h),
            Obx(() {
              return recognizedTextController.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: Colors.green,
                    ))
                  : GlobalButton(
                      text: 'Save to database',
                      onTap: () async {
                        await recognizedTextController
                            .postRecognizedText(recognizedText);
                      },
                    );
            }),
          ],
        ),
      ),
    );
  }

  List<String> _splitText(String text, int chunkSize) {
    List<String> chunks = [];
    for (int i = 0; i < text.length; i += chunkSize) {
      chunks.add(text.substring(
          i, i + chunkSize > text.length ? text.length : i + chunkSize));
    }
    return chunks;
  }
}
