// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class QrCodeTypeModel {
  String text;
  Widget icon;
  bool isLink;
  QrCodeTypeModel({
    required this.text,
    required this.icon,
    required this.isLink,
  });
}
