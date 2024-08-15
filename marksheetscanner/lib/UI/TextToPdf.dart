import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart'; // Import the flutter_pdfview package
import 'package:marksheetscanner/Controllers/PdfController.dart';
import 'package:marksheetscanner/GlobalComponents/GlobalAppbar.dart';
import 'package:marksheetscanner/GlobalComponents/GlobalButton.dart';
import 'package:marksheetscanner/GlobalComponents/GlobalCircularBar.dart';
import 'package:marksheetscanner/GlobalComponents/colorConfig.dart';
import 'package:marksheetscanner/Theme/ThemeController.dart';

class PdfView extends StatefulWidget {
  final String recognizedtext;

  const PdfView({super.key, required this.recognizedtext});
  @override
  State<PdfView> createState() => _PdfViewState(recognizedtext: recognizedtext);
}

class _PdfViewState extends State<PdfView> with SingleTickerProviderStateMixin {
  final PdfController pdfController = Get.put(PdfController());
  final ThemeController _themeController = Get.find();

  late AnimationController _animationController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final String recognizedtext;

  _PdfViewState({required this.recognizedtext});

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log(recognizedtext);
    return Obx(
      () => Scaffold(
        key: _scaffoldKey,
        backgroundColor: _themeController.isDarkMode.value
            ? darkThemeColor
            : lightThemeColor,
        appBar: GlobalAppBar(
          text: "Generate PDF",
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() {
                if (pdfController.isLoading.value) {
                  return GlobalCircularLoading(
                    isLoading: true,
                  );
                } else if (pdfController.pdfFilePath.value.isNotEmpty) {
                  return Column(
                    children: [
                      Container(
                          height: 400.h,
                          child: PDFView(
                            filePath: pdfController.pdfFilePath.value,
                            enableSwipe: true,
                            swipeHorizontal: false,
                            autoSpacing: false,
                            pageSnap: false,
                            pageFling: true,
                            fitEachPage: false,
                            fitPolicy: FitPolicy.BOTH,
                            onRender: (_pages) {
                              pdfController.totalPage.value = _pages!;
                              pdfController.isLoading.value = false;
                            },
                            onError: (error) {
                              print("Error while loading the PDF: $error");
                            },
                            onPageError: (page, error) {
                              print('Error on page $page: $error');
                            },
                            onPageChanged: (page, total) {
                              pdfController.currentPage.value = page! + 1;
                              pdfController.totalPage.value = total!;
                            },
                          )),
                      SizedBox(height: 20.h),
                      Text(
                        "${pdfController.currentPage} / ${pdfController.totalPage}",
                        style: TextStyle(
                          fontFamily: "mulish",
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                          color:
                              _themeController.isDarkMode.value ? white : black,
                        ),
                      ),
                      SizedBox(height: 20.h),
                    ],
                  );
                } else {
                  return const SizedBox.shrink();
                }
              }),
              GlobalButton(
                onTap: () {
                  pdfController.createPdfFromText(recognizedtext);
                },
                text: "Generate and View PDF",
              ),
              SizedBox(height: 20.h),
              Obx(() {
                if (pdfController.pdfFilePath.value.isNotEmpty) {
                  return GlobalButton(
                    onTap: () {
                      pdfController.savePdf();
                    },
                    text: "Download PDF",
                  );
                } else {
                  return const SizedBox.shrink();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
