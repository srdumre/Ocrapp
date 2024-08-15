import 'dart:io';
import 'dart:developer';
import 'package:dio/dio.dart';

import 'package:get/get.dart';
import 'package:marksheetscanner/Model/TextRecogonizedModel.dart';

import 'package:permission_handler/permission_handler.dart';

class CSVFileController extends GetxController {
  var isLoading = false.obs;
  var csvFiles = <CSVFileModel>[].obs;

  final String apiUrl = "http://192.168.18.7:8000/api/fetch-all-csv-files/";

  Dio dio = Dio();

  @override
  void onInit() {
    fetchCSVFiles();
    super.onInit();
  }

  Future<void> fetchCSVFiles() async {
    isLoading(true);
    try {
      var response = await dio.get(apiUrl);

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        csvFiles.value = data.map((e) => CSVFileModel.fromJson(e)).toList();
      } else {
        Get.snackbar('Error',
            'Failed to fetch CSV files. Status code: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> downloadCsv(String filePath) async {
    log("Attempting to download file from: $filePath");
    try {
      // Request storage permission
      if (await Permission.storage.request().isGranted) {
        final Uri uri = Uri.parse(filePath);
        if (!uri.isAbsolute) {
          throw ArgumentError('Invalid URL: $filePath');
        }

        // Get the Downloads directory path
        final downloadsDir = Directory('/storage/emulated/0/Download');
        if (!await downloadsDir.exists()) {
          throw Exception('Unable to get the downloads directory');
        }

        // Determine the file name
        final fileName = uri.pathSegments.isNotEmpty
            ? uri.pathSegments.last
            : 'downloaded_file.csv';

        final file = File('${downloadsDir.path}/$fileName');

        // Delete the file if it already exists
        if (await file.exists()) {
          await file.delete();
        }

        // Download the file
        final response = await dio.get<ResponseBody>(
          filePath,
          options: Options(responseType: ResponseType.stream),
        );

        // Write the file to disk
        final sink = file.openWrite();
        await for (var chunk in response.data!.stream) {
          sink.add(chunk);
        }
        await sink.flush();
        await sink.close();

        // Show success message
        Get.snackbar(
          "Success",
          "CSV file downloaded successfully to: ${file.path}",
          duration: Duration(seconds: 5),
        );
      } else {
        Get.snackbar("Permission Denied",
            "Storage permission is required to save files.");
      }
    } catch (e) {
      log(e.toString());
      Get.snackbar("Error", "Failed to download CSV file: $e");
    }
  }
}
