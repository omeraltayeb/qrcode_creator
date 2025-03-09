import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qrcode_creator/core/services/services.dart';
import 'package:qrcode_creator/cubits/scan_qr/scan_qr_states.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qrcode_creator/view/screen/result_scan.dart';
import '../../data/datasource/remote/scan_data.dart';

class ScanQrCubit extends Cubit<ScanQrStates> {
  String? serverErrorMessage;
  bool isFlashOn = false;
  MobileScannerController? cameraController;
  final scanData = ScanData();
  final myServices = MyServices();

  ScanQrCubit() : super(ScanQrInitial()) {
    cameraController = MobileScannerController();
  }

  Future<void> saveScannedValue(String scannedValue, String userid) async {
    emit(ScanQrLoading());
    var response = await scanData.postData(scannedValue, userid);
    if (response["status"] == "success") {
      emit(ScanQrSuccess(scannedValue));
    } else {
      emit(ScanQrFailure(serverErrorMessage = "Failed to upload data"));
      log(serverErrorMessage!);
    }
  }

  navigateResult(String scannedValue, BuildContext context) async {
    String? userid = await myServices.getValue("userid");
    String? isLogin = await myServices.getValue("isLogin");
    if (isLogin == "true") {
      saveScannedValue(scannedValue, userid!);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ResultScan(value: scannedValue)));
    } else {
      myServices.setValue("data", "scannedValue");
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ResultScan(value: scannedValue)));
    }
  }

  Future<void> pickImageAndScan(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final bytes = await file.readAsBytes();
      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/temp_qr_image.png');
      await tempFile.writeAsBytes(bytes);
      final barcodeCapture =
          await cameraController?.analyzeImage(tempFile.path);
      if (barcodeCapture != null && barcodeCapture.barcodes.isNotEmpty) {
        final scannedValue =
            barcodeCapture.barcodes.first.rawValue ?? "No Data found in QR";
        String? userid = await myServices.getValue("userid");
        String? isLogin = await myServices.getValue("isLogin");
        if (isLogin == "true") {
          saveScannedValue(scannedValue, userid!);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ResultScan(value: scannedValue)));
        } else {
          // Fetch the existing list from SharedPreferences
          List<Map<String, dynamic>> scannedValues = [];
          String? scannedVal = await myServices.getValue("scannedValues");

          String? existingData = scannedVal;
          if (existingData != null && existingData.isNotEmpty) {
            scannedValues = List<Map<String, dynamic>>.from(
                jsonDecode(existingData)
                    .map((item) => Map<String, dynamic>.from(item)));
          }
          Map<String, dynamic> newScan = {
            "scannedData_value": scannedValue,
            "created_at": DateTime.now().toIso8601String(),
          };
          scannedValues.add(newScan);
          await myServices.setValue("scannedValues", jsonEncode(scannedValues));

          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ResultScan(value: scannedValue)));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No QR code found in the image.')),
        );
      }
    }
  }

  void flashToggle() {
    if (cameraController != null && cameraController!.value.isInitialized) {
      isFlashOn = !isFlashOn;
      cameraController!.toggleTorch();
      emit(ScanQrLoaded());
    } else {}
  }
}
