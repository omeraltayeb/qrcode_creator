import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../core/function/handling_page.dart';
import '../../cubits/resultCreateQrCode/result_create_cubit.dart';
import '../../cubits/resultCreateQrCode/result_create_state.dart';

class ResultCreateQrCodeScreen extends StatelessWidget {
  const ResultCreateQrCodeScreen(
      {super.key,
      this.qrData = "",
      this.qrColor = Colors.black,
      this.logoImage,
      this.logoFile,
      this.name});

  final String qrData;
  final Color qrColor;
  final ImageProvider? logoImage;
  final File? logoFile;
  final String? name;

  @override
  Widget build(BuildContext context) {
    final resultCubit = context.read<ResultCreateQrCodeCubit>();
    return Scaffold(
      body: BlocBuilder<ResultCreateQrCodeCubit, ResultCreateState>(
        builder: (context, state) {
          return HandlingPage(
            isLoading: state is ResultCreateLoading,
            child: ListView(
              children: [
                Column(
                  children: [
                    QrImageView(
                      data: qrData,
                      version: QrVersions.auto,
                      size: 200.0,
                      backgroundColor: Colors.white,
                      eyeStyle: QrEyeStyle(
                        color: qrColor,
                      ),
                      dataModuleStyle: QrDataModuleStyle(
                        color: qrColor,
                        dataModuleShape: QrDataModuleShape.square,
                      ),
                      embeddedImage: logoImage,
                      embeddedImageStyle: QrEmbeddedImageStyle(
                        size: Size(40, 40),
                      ),
                    ),
                    const SizedBox(height: 20),
                    MaterialButton(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 70, vertical: 10),
                      color: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                      onPressed: () => resultCubit.saveQRCode(
                          context, logoFile!, qrData, name!, qrColor),
                      child: Text(
                        'Download QR Code',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
