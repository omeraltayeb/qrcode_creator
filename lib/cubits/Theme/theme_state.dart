import 'package:flutter/material.dart';

abstract class ThemeState {
  final ThemeMode themeMode;
  ThemeState(this.themeMode);
}

class ThemeInitial extends ThemeState {
  ThemeInitial() : super(ThemeMode.light);
}

class ThemeChanged extends ThemeState {
  ThemeChanged(super.themeMode);
}
