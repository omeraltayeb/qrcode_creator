import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gal/gal.dart';
import 'package:path/path.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:qrcode_creator/core/services/services.dart';
import '../../core/function/check_internet.dart';
import '../../data/datasource/remote/my_qr_data.dart';
import '../../view/screen/my_qrcode.dart';
import '../notificationHelper/notification_helper.dart';
import 'result_create_state.dart';

class ResultCreateQrCodeCubit extends Cubit<ResultCreateState> {
  ResultCreateQrCodeCubit() : super(ResultCreateInitial());

  final myServices = MyServices();
  final myQrData = MyQrData();

  Future<void> saveCreatedQR(String labelName, File? imageFile) async {
    emit(ResultCreateLoading());
    if (imageFile == null) {
      return;
    }

    if (await checkInternet()) {
      String? userId = await myServices.getValue('userid');
      var response = await myQrData.addQR(labelName, userId!, imageFile);
      if (response['status'] == 'success') {
        emit(ResultCreateLoaded());
      } else {
        emit(ResultCreateFailure('failure saved qr'));
      }
    }
  }

  Future<void> saveQRCode(BuildContext context, File logoFile, String qrData,
      String name, Color qrColor) async {
    try {
      final qrImage = await _generateQrImage(qrData, qrColor, logoFile);
      final filePath = await _saveQrToFile(qrImage);

      await Gal.putImage(filePath);
      await saveCreatedQR(name, File(filePath));
      // Show notification
      await NotificationHelper.showNotification(
        title: 'Download Complete',
        body: basename(filePath),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('QR Code saved to gallery!')),
      );

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => MyQrcode(qrColor: qrColor)),
        (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving QR Code: $e')),
      );
    }
  }

  // Helpers
  Future<ui.Image> _loadImage(File file) async {
    final Uint8List bytes = await file.readAsBytes();
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    return frame.image;
  }

  Future<ui.Image> _generateQrImage(
      String qrData, Color qrColor, File logoFile) async {
    final embeddedImage = await _loadImage(logoFile);
    return QrPainter(
      data: qrData,
      version: QrVersions.auto,
      eyeStyle: QrEyeStyle(color: qrColor),
      dataModuleStyle: QrDataModuleStyle(color: qrColor),
      embeddedImage: embeddedImage,
      embeddedImageStyle: QrEmbeddedImageStyle(size: Size(40, 40)),
    ).toImage(200);
  }

  Future<String> _saveQrToFile(ui.Image image) async {
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final pngBytes = byteData!.buffer.asUint8List();

    final tempDir = await getDownloadsDirectory();
    final file = File('${tempDir!.path}/qr_code.png');
    await file.writeAsBytes(pngBytes);

    return file.path;
  }
}
