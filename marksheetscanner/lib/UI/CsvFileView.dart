import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marksheetscanner/Controllers/FetchCsvFileController.dart';
import 'package:marksheetscanner/GlobalComponents/GlobalCircularBar.dart';
import 'package:marksheetscanner/GlobalComponents/GlobalListTile.dart';
import 'package:marksheetscanner/GlobalComponents/globalIcon.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:marksheetscanner/UI/FileDetails.dart';

class CSVFileListWidget extends StatelessWidget {
  final CSVFileController _csvFileController = Get.put(CSVFileController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_csvFileController.isLoading.value) {
        return Center(
            child: GlobalCircularLoading(
          isLoading: true,
        ));
      } else if (_csvFileController.csvFiles.isEmpty) {
        return const Center(child: Text('No CSV files found.'));
      } else {
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: _csvFileController.csvFiles.length,
          itemBuilder: (context, index) {
            var file = _csvFileController.csvFiles[index];
            return CustomListTile(
                leadingIcon: GlobalIcon(
                  icon: MdiIcons.file,
                ),
                text: "${file.id}",
                trailingIcon: GlobalIcon(
                  icon: MdiIcons.arrowRight,
                ),
                onTap: () {
                  Get.to(() => CSVFileDetailPage(file: file));
                });
          },
        );
      }
    });
  }
}
