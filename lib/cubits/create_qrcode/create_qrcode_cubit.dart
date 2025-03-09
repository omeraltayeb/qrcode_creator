import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../../core/function/check_internet.dart';
import '../../data/datasource/remote/my_qr_data.dart';
import '../../data/datasource/static/logo_data.dart';
import '../../core/constant/links.dart';
import '../../view/screen/result_create_qr_code.dart';
import 'create_qrcode_states.dart';

class CreateQrCodeCubit extends Cubit<CreateQrCodeStates> {
  final link = TextEditingController();
  final name = TextEditingController();
  final createForm = GlobalKey<FormState>();
  Color qrColor = Colors.black;
  File? logoFile;
  File? file;
  ImageProvider? logoImage;
  final myQrData = MyQrData();
  String? serverErrorMessage;
  bool isDone = false;
  List<bool> selectedLogos;
  String qrData = "";

  CreateQrCodeCubit()
      : selectedLogos = List.filled(logo.length, false),
        super(CreateQrCodeInitial());

  void updateQrColor(Color color) {
    if (qrColor != color) {
      qrColor = color;
      emit(CreateQrCodeLoaded());
    }
  }

  Future<void> pickLogo() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      logoFile = File(result.files.single.path!);
      logoImage = FileImage(logoFile!);
      emit(CreateQrCodeLoaded());
    }
  }

  void setLogo(ImageProvider imageProvider, String path, int index) async {
    logoImage = imageProvider;
    logoFile = await _saveImageFromAssets(imageProvider, path);
    isDone = true;
    for (int i = 0; i < selectedLogos.length; i++) {
      selectedLogos[i] = false;
    }
    selectedLogos[index] = true;

    emit(CreateQrCodeLoaded());
  }

  Future<void> pickFileAndGenerateQR(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(type: FileType.any);
    if (result == null || result.files.single.path == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a valid file.')),
      );
      return;
    }

    file = File(result.files.single.path!);

    if (!(await file!.exists())) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('File not found.')),
      );
      return;
    }
    if (await checkInternet()) {
      var response = await myQrData.addFile(file!);
      if (response['status'] == 'success') {
        final downloadUrl =
            '${Links.scannedFiles}/${file!.path.split('/').last}';
        final qrData = downloadUrl;
        link.text = qrData;
        emit(CreateQrCodeLoaded());
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error uploading file')),
        );
      }
    } else {
      emit(CreateQrCodeFailure("No internet access"));
      serverErrorMessage = "No internet access";
    }
  }

  void viewQR() {
    emit(CreateQrCodeLoading());
    qrData = link.text;
    if (qrData.isNotEmpty) {
      emit(CreateQrCodeLoaded());
    } else {
      emit(CreateQrCodeFailure('Please enter a valid link.'));
    }
  }

// Generate QR Code
  void generateQRCode(BuildContext context) {
    if (createForm.currentState!.validate()) {
      if (logoFile == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Please select a logo before proceeding.')),
        );
        return;
      }

      if (file == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Please upload a file before proceeding.')),
        );
        return;
      }

      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => ResultCreateQrCodeScreen(
                  qrData: qrData,
                  qrColor: qrColor,
                  logoImage: logoImage,
                  logoFile: logoFile,
                  name: name.text,
                )),
      );
      viewQR();
    }
  }

  // Helpes
  Future<File> _saveImageFromAssets(
      ImageProvider imageProvider, String path) async {
    final byteData = await rootBundle.load(path);
    final buffer = byteData.buffer.asUint8List();
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/logo.png');
    await file.writeAsBytes(buffer);
    return file;
  }
}
