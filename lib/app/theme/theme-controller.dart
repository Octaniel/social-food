import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  static ThemeController get to => Get.put(ThemeController());

  GetStorage storage = GetStorage();
  ThemeMode _themeMode;
  ThemeMode get themeMode => _themeMode;
  RxBool modoDark = false.obs;

  Future<void> changeTheme(ThemeMode themeMode) async {
    if (themeMode == ThemeMode.system) themeMode = ThemeMode.light;
    Get.changeThemeMode(themeMode);
    _themeMode = themeMode;
    update();
    await storage.write('theme', themeMode.toString().split('.')[1]);
  }

  getThemeMode() async {
    ThemeMode themeMode;
    String themeText = storage.read('theme') ?? 'system';
    try {
      themeMode = ThemeMode.values.firstWhere((e) => describeEnum(e) == themeText);
    } catch (e) {
      themeMode = ThemeMode.light;
    }

    if (themeMode == ThemeMode.dark)
      modoDark.value = true;
    else
      modoDark.value = false;

    changeTheme(themeMode);
  }

  handleThemeChange() {
    modoDark.value = !modoDark.value;

    if (modoDark.value) {
      changeTheme(ThemeMode.dark);
    } else {
      changeTheme(ThemeMode.light);
    }
  }
}
