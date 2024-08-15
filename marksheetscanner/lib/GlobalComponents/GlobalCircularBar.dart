import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marksheetscanner/GlobalComponents/colorConfig.dart';
import 'package:marksheetscanner/Theme/ThemeController.dart';

class GlobalCircularLoading extends StatelessWidget {
  final bool isLoading;
  final ThemeController _themeController = Get.put(ThemeController());
  GlobalCircularLoading({Key? key, required this.isLoading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: Container(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(
                strokeWidth: 5,
                valueColor: AlwaysStoppedAnimation<Color>(
                    _themeController.isDarkMode.value ? white : black),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
