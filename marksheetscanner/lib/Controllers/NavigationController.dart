import 'package:get/get.dart';
import 'package:marksheetscanner/UI/HomePageScreen.dart';

class NavigateController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 5));
    Get.offAll(() => Homepagescreen());
  }
}
