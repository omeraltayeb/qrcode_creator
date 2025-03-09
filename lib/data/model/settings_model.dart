import 'package:flutter/material.dart';

class SettingsModel {
  final String title;
  final IconData leading;
  final Widget trailing;
  final VoidCallback? onTap;

  const SettingsModel({
    required this.title,
    required this.leading,
    required this.trailing,
    this.onTap,
  });
}
