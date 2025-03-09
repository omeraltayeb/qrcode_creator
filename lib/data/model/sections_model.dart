import 'package:flutter/material.dart';

class SectionModel {
  final String title;
  final IconData icon;
  final int initialIndex;

  const SectionModel({
    required this.title,
    required this.icon,
    required this.initialIndex,
  });
}
