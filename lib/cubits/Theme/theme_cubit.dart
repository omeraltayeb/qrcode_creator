import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode_creator/core/services/services.dart';

import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial()) {
    _loadTheme();
  }

  final MyServices myServices = MyServices();

  Future<void> _loadTheme() async {
    final isDarkModeString = await myServices.getValue("isDarkMode");
    final isDarkMode = isDarkModeString == "true";
    emit(ThemeChanged(isDarkMode ? ThemeMode.dark : ThemeMode.light));
  }

  Future<void> toggleTheme() async {
    final isDark = state.themeMode == ThemeMode.dark;
    final newTheme = isDark ? ThemeMode.light : ThemeMode.dark;

    // حفظ التفضيل كم String
    await myServices.setValue("isDarkMode", (!isDark).toString());

    emit(ThemeChanged(newTheme));
  }
}
