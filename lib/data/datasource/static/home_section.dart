import 'package:flutter/material.dart';
import '../../model/sections_model.dart';

const List<SectionModel> sections = [
  SectionModel(
      title: 'Scan QR Code', icon: Icons.qr_code_scanner, initialIndex: 2),
  SectionModel(title: 'Scan History', icon: Icons.history, initialIndex: 1),
  SectionModel(title: 'Create QR Code', icon: Icons.add, initialIndex: 0),
  SectionModel(title: 'My QR Codes', icon: Icons.qr_code_2, initialIndex: 3),
];
