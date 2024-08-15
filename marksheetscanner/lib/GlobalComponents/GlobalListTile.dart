import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marksheetscanner/GlobalComponents/colorConfig.dart';
import 'package:marksheetscanner/GlobalComponents/globalIcon.dart';
import 'package:marksheetscanner/GlobalComponents/globalText.dart';
import 'package:marksheetscanner/Theme/ThemeController.dart';

class CustomListTile extends StatelessWidget {
  final GlobalIcon leadingIcon;
  final String text;
  final GlobalIcon trailingIcon;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final EdgeInsetsGeometry padding;

  CustomListTile({
    Key? key,
    required this.leadingIcon,
    required this.text,
    required this.trailingIcon,
    required this.onTap,
    this.backgroundColor,
    this.padding = const EdgeInsets.all(8.0),
  }) : super(key: key);

  final ThemeController _themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor ??
              (_themeController.isDarkMode.value
                  ? darkContainerColor
                  : lightContainerColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: leadingIcon,
          title: GlobalText(
            text: text,
          ),
          trailing: trailingIcon,
          onTap: onTap,
        ),
      ),
    );
  }
}
