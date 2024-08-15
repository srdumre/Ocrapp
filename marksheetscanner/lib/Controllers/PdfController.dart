import 'dart:io';
import 'dart:math'; // For generating unique file names
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;

class PdfController extends GetxController {
  var isLoading = false.obs;
  var pdfFilePath = ''.obs;
  var currentPage = 1.obs;
  var totalPage = 1.obs;

  // Define max lines per page
  final int maxLinesPerPage = 40;

  Future<void> createPdfFromText(String text) async {
    isLoading(true);
    try {
      final pdf = pw.Document();
      final lines = text.split('\n');

      // Split lines into pages
      for (int i = 0; i < lines.length; i += maxLinesPerPage) {
        final pageLines =
            lines.sublist(i, min(i + maxLinesPerPage, lines.length));

        pdf.addPage(
          pw.Page(
            build: (pw.Context context) {
              return pw.Column(
                children: pageLines.map((line) => pw.Text(line)).toList(),
              );
            },
          ),
        );
      }

      await _savePdf(pdf);
    } catch (e) {
      Get.snackbar("Error", "Failed to create PDF: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> _savePdf(pw.Document pdf) async {
    try {
      if (await Permission.storage.request().isGranted) {
        Directory? downloadsDir;

        if (Platform.isAndroid) {
          downloadsDir = Directory('/storage/emulated/0/Download');
        } else if (Platform.isIOS) {
          downloadsDir = await getApplicationDocumentsDirectory();
        }

        if (downloadsDir != null) {
          final timestamp = DateTime.now().millisecondsSinceEpoch;
          final fileName = "generated_pdf_$timestamp.pdf";
          final file = File(path.join(downloadsDir.path, fileName));
          final bytes = await pdf.save();
          await file.writeAsBytes(bytes);

          pdfFilePath.value = file.path;
          Get.snackbar("Success", "PDF saved at: ${file.path}");
        } else {
          Get.snackbar("Error", "Downloads directory not found.");
        }
      } else {
        Get.snackbar("Error", "Storage permission denied.");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to save PDF: $e");
    }
  }

  Future<void> savePdf() async {
    try {
      if (pdfFilePath.value.isNotEmpty) {
        if (await Permission.storage.request().isGranted) {
          final file = File(pdfFilePath.value);

          if (await file.exists()) {
            Get.snackbar(
                "Success", "PDF file is already saved at: ${file.path}");
          } else {
            Get.snackbar("Error", "File does not exist");
          }
        } else {
          Get.snackbar("Error", "Storage permission denied.");
        }
      } else {
        Get.snackbar("Error", "No PDF file to download.");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to download PDF: $e");
    }
  }
}
