import 'dart:developer';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:marksheetscanner/GlobalComponents/globaldialog.dart';
import 'package:marksheetscanner/UI/TextOutputPage.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  Rx<XFile?> pickedImage = Rx<XFile?>(null);
  Rx<String?> scannedText = Rx<String?>(null);
  RxBool isloading = false.obs;

  Future<void> pickImageFromGallery(BuildContext context) async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        pickedImage.value = image;
        await _processImage(File(image.path), context);
      }
    } catch (e) {
      print('Error picking image from gallery: $e');
    }
  }

  Future<void> pickImageFromCamera(context) async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        pickedImage.value = image;
        await _processImage(File(image.path), context);
      }
    } catch (e) {
      log('Error picking image from camera: $e');
    }
  }

  Future<void> _processImage(File imageFile, BuildContext context) async {
    isloading.value = true;
    final textRecognizer = TextRecognizer();
    final inputImage = InputImage.fromFile(imageFile);

    try {
      CustomDialog().myDialog(
        dialog: "Scanning",
        context: context,
      );

      final RecognizedText recognizedText =
          await textRecognizer.processImage(inputImage);
      scannedText.value = recognizedText.text;
      log(scannedText.value.toString());
    } catch (e) {
      log('Error processing image: $e');
      if (context.mounted) Navigator.pop(context);
    } finally {
      isloading.value = false;
      if (context.mounted) Navigator.pop(context);

      Get.to(() => TextOutputPage(
            recognizedText: scannedText.value.toString(),
          ));

      textRecognizer.close();
    }
  }
}
