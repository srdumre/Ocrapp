import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:marksheetscanner/Controllers/FetchCsvFileController.dart';

class RecognizedTextController extends GetxController {
  final CSVFileController _csvFileController = Get.put(CSVFileController());
  var isLoading = false.obs;
  final String apiUrl = "http://192.168.18.7:8000/api/save-text-as-csv/";

  Dio dio = Dio();
  Future<void> postRecognizedText(String recognizedText) async {
    isLoading(true);

    try {
      var response = await dio.post(apiUrl, data: {
        'recognized_text': recognizedText,
      });

      if (response.statusCode == 201) {
        Get.snackbar('Success', 'Text saved successfully.');
        _csvFileController.fetchCSVFiles();
      } else {
        Get.snackbar('Error', 'Failed to save text.');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }
}
