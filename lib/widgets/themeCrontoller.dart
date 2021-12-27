
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class themeController {

  final _box = GetStorage();
  final _key = 'isDarkMode';

  _saveTheme(bool value) async {
    await _box.write(_key, value);
  }

  bool _isDarkMode() {
    return _box.read(_key) ?? false;
  }
  ThemeMode get theme => _isDarkMode()? ThemeMode.dark : ThemeMode.light;

  void setTheme() {
    Get.changeThemeMode(_isDarkMode()? ThemeMode.light : ThemeMode.dark);
    _saveTheme(!_isDarkMode());
    
  }
}