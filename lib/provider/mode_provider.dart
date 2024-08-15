import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UiProvider extends ChangeNotifier {
  bool _isDark = false;
  bool get isDark => _isDark;

  late SharedPreferences storage;

  // Custom Dark theme
  final darkTheme = ThemeData(
      primaryColor: Colors.black12,
      brightness: Brightness.dark,
      primaryColorDark: Colors.black12);

  // Custom Light theme
  final lightTheme = ThemeData(
      primaryColor: Colors.white,
      brightness: Brightness.light,
      primaryColorLight: Colors.white);

  // Now we want to save the last changed theme value

  // Dark mode toggle action
  changeTheme() {
    _isDark = !isDark;

    // Save the value to secure storage
    notifyListeners();
  }

  // init method of provider
  init() async {
    // After we re-run the app
    storage = await SharedPreferences.getInstance();
    _isDark = storage.getBool("isDark") ?? false;
    notifyListeners();
  }
}
