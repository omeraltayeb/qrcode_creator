import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../model/qr_code_type_model.dart';

final List<QrCodeTypeModel> qrTypes = [
  QrCodeTypeModel(
    text: "URL / Link",
    icon: Image.asset('assets/icons/url.png', height: 50),
    isLink: true,
  ),
  QrCodeTypeModel(
    text: "PDF",
    icon: Image.asset('assets/icons/pdf.png', height: 50),
    isLink: false,
  ),
  QrCodeTypeModel(
    text: "Image",
    icon: SvgPicture.asset('assets/icons/image-solid.svg', height: 50),
    isLink: false,
  ),
  QrCodeTypeModel(
    text: "Play Market / App Store",
    icon: Image.asset('assets/icons/google-play.png', height: 50),
    isLink: true,
  ),
  QrCodeTypeModel(
    text: "Text",
    icon: Image.asset('assets/icons/icons-text.png', height: 50),
    isLink: true,
  ),
  QrCodeTypeModel(
    text: "Maps",
    icon: Image.asset('assets/icons/maps.png', height: 50),
    isLink: true,
  ),
  QrCodeTypeModel(
    text: "Document",
    icon: Image.asset('assets/icons/document.png', height: 50),
    isLink: true,
  ),
  QrCodeTypeModel(
    text: "Wifi",
    icon: Icon(Icons.wifi, size: 50),
    isLink: true,
  ),
  QrCodeTypeModel(
    text: "Audio",
    icon: Icon(Icons.audio_file, size: 50),
    isLink: true,
  ),
  QrCodeTypeModel(
    text: "Paypal",
    icon: Icon(Icons.paypal, size: 50),
    isLink: true,
  ),
  QrCodeTypeModel(
    text: "Facebook",
    icon: SvgPicture.asset('assets/icons/facebook.svg', height: 50),
    isLink: true,
  ),
  QrCodeTypeModel(
    text: "Instagram",
    icon: Image.asset('assets/icons/instagram.png', height: 50),
    isLink: true,
  ),
  QrCodeTypeModel(
    text: "Snapchat",
    icon: Image.asset('assets/icons/snapchat.png', height: 50),
    isLink: true,
  ),
  QrCodeTypeModel(
    text: "Telegram",
    icon: Image.asset('assets/icons/telegram.png', height: 50),
    isLink: true,
  ),
  QrCodeTypeModel(
    text: "Phone number",
    icon: Icon(Icons.phone, size: 50),
    isLink: true,
  ),
  QrCodeTypeModel(
    text: "Tiktok",
    icon: Image.asset('assets/icons/tiktok.png', height: 50),
    isLink: true,
  ),
  QrCodeTypeModel(
    text: "Youtube",
    icon: Image.asset('assets/icons/youtube.png', height: 50),
    isLink: true,
  ),
];
