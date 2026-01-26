import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:package_tester/shared/themes/colors_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemesManager extends ChangeNotifier{
  static bool _isDark = true;
  static late Color _accent;
  static bool get isDark => _isDark;
  static Color get accent => _accent;

  static ThemeMode get themeMode => _isDark? ThemeMode.dark:ThemeMode.light;

 Future<void> init() async{
   SharedPreferences prefs = await SharedPreferences.getInstance();
   int? color = prefs.getInt('Accent');
   if(color == null){
     _accent = getAccentColor(Accents.dark);
   } else{
     _accent = Color(color);
   }
   _isDark = prefs.getBool('isDark')??true;
   notifyListeners();
 }
  void toggleTheme() async{
    _isDark = !_isDark;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDark', _isDark);
    if (_accent == getAccentColor(Accents.dark) ||
        _accent == getAccentColor(Accents.light)) {
      _accent = _isDark ? getAccentColor(Accents.dark) : getAccentColor(Accents.light);
    }
    notifyListeners();
  }

  void setAccent(Accents accents){
    _accent = getAccentColor(accents);
    notifyListeners();
  }

  static ThemeData get darkTheme => _darkTheme();
  static ThemeData get lightTheme => _lightTheme();


  static ThemeData _darkTheme(){
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: ColorsManager.darkThemeBackgroundColor),
      scaffoldBackgroundColor: ColorsManager.darkThemeBackgroundColor,
      primaryColor: _accent,
      dialogTheme: DialogThemeData(
        backgroundColor: ColorsManager.lightThemeBackgroundColor,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: ColorsManager.darkThemeBackgroundColor,
        surfaceTintColor: ColorsManager.transparent,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(color: _accent, fontSize: 34),
      ),
      cardColor: ColorsManager.darkThemePrimaryColor,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: BorderSide(color: _accent.withAlpha(20))
        ),
        backgroundColor: ColorsManager.darkThemePrimaryColor,
        foregroundColor: _accent
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: _accent,
        )
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(color: ColorsManager.white),
        displayMedium: TextStyle(color: ColorsManager.white),
        displaySmall: TextStyle(color: ColorsManager.white),
        headlineLarge: TextStyle(color: ColorsManager.white),
        headlineMedium: TextStyle(color: ColorsManager.white),
        headlineSmall: TextStyle(color: ColorsManager.white),
        bodyLarge: TextStyle(color: ColorsManager.white),
        bodyMedium: TextStyle(color: ColorsManager.white),
        bodySmall: TextStyle(color: ColorsManager.white),
        labelLarge: TextStyle(color: ColorsManager.white),
        labelMedium: TextStyle(color: ColorsManager.white),
        labelSmall: TextStyle(color: ColorsManager.white),
        titleLarge: TextStyle(color: ColorsManager.white),
        titleMedium: TextStyle(color: ColorsManager.white),
        titleSmall: TextStyle(color: ColorsManager.white),
      ),
    );
  }

  static ThemeData _lightTheme(){
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: ColorsManager.lightThemeBackgroundColor),
      dialogTheme: DialogThemeData(
        backgroundColor: ColorsManager.lightThemeBackgroundColor,
      ),
      primaryColor: _accent,
      iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
            foregroundColor: _accent,
          )
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: ColorsManager.lightThemePrimaryColor,
        elevation: 5,
        foregroundColor: _accent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: BorderSide(color: _accent.withAlpha(20))
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: ColorsManager.lightThemeBackgroundColor,
        foregroundColor: _accent,
        elevation: 5,
        centerTitle: true,
        scrolledUnderElevation: 0,
        surfaceTintColor: ColorsManager.transparent,
        shadowColor: ColorsManager.black.withAlpha(50),
        titleTextStyle: TextStyle(color: _accent, fontSize: 34),
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(color: ColorsManager.black),
        displayMedium: TextStyle(color: ColorsManager.black),
        displaySmall: TextStyle(color: ColorsManager.black),
        headlineLarge: TextStyle(color: ColorsManager.black),
        headlineMedium: TextStyle(color: ColorsManager.black),
        headlineSmall: TextStyle(color: ColorsManager.black),
        bodyLarge: TextStyle(color: ColorsManager.black),
        bodyMedium: TextStyle(color: ColorsManager.black),
        bodySmall: TextStyle(color: ColorsManager.black),
        labelLarge: TextStyle(color: ColorsManager.black),
        labelMedium: TextStyle(color: ColorsManager.black),
        labelSmall: TextStyle(color: ColorsManager.black),
        titleLarge: TextStyle(color: ColorsManager.black),
        titleMedium: TextStyle(color: ColorsManager.black),
        titleSmall: TextStyle(color: ColorsManager.black),
      ),
      scaffoldBackgroundColor: ColorsManager.lightThemeBackgroundColor
    );
  }
}

