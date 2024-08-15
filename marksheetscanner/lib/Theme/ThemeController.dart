import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  RxBool isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadTheme();
    Brightness brightness = WidgetsBinding.instance.window.platformBrightness;
    isDarkMode.value = brightness == Brightness.dark;
    updateTheme();
    WidgetsBinding.instance?.window.onPlatformBrightnessChanged = () {
      Brightness newBrightness =
          WidgetsBinding.instance!.window.platformBrightness;
      isDarkMode.value = newBrightness == Brightness.dark;
      updateTheme();
    };
  }

  void toggleTheme() {
    isDarkMode.toggle();
    updateTheme();
    saveTheme();
  }

  void updateTheme() {
    Get.changeThemeMode(
      isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
    );
  }

  void setLightTheme() {
    isDarkMode.value = false;
    updateTheme();
    saveTheme();
  }

  void setDarkTheme() {
    isDarkMode.value = true;
    updateTheme();
    saveTheme();
  }

  Future<void> saveTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', isDarkMode.value);
  }

  Future<void> loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool savedIsDarkMode = prefs.getBool('isDarkMode') ?? false;
    isDarkMode.value = savedIsDarkMode;
    updateTheme();
  }
}
