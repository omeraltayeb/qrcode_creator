import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qrcode_creator/core/function/handling_page.dart';
import 'package:qrcode_creator/cubits/scan_qr/scan_qr_cubit.dart';
import 'package:qrcode_creator/cubits/scan_qr/scan_qr_states.dart';

class ScanQrcode extends StatelessWidget {
  const ScanQrcode({super.key});

  @override
  Widget build(BuildContext context) {
    final scanCubit = context.read<ScanQrCubit>();
    return Scaffold(
      body: BlocBuilder<ScanQrCubit, ScanQrStates>(
        builder: (context, state) {
          return HandlingPage(
            isLoading: state is ScanQrLoading,
            serverErrorMessage: scanCubit.serverErrorMessage,
            child: Stack(
              children: [
                MobileScanner(
                  controller: scanCubit.cameraController,
                  onDetect: (capture) {
                    final List<Barcode> barcodes = capture.barcodes;
                    for (final barcode in barcodes) {
                      final scannedValue =
                          barcode.rawValue ?? "No Data found in QR";
                      scanCubit.navigateResult(scannedValue, context);
                    }
                  },
                ),
                BlocBuilder<ScanQrCubit, ScanQrStates>(
                  builder: (context, state) {
                    return Positioned(
                      top: 20,
                      left: 0,
                      right: 0,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () => scanCubit.flashToggle(),
                              icon: Icon(
                                scanCubit.isFlashOn
                                    ? Icons.flash_on
                                    : Icons.flash_off,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                            IconButton(
                              onPressed: () =>
                                  scanCubit.pickImageAndScan(context),
                              icon: SvgPicture.asset(
                                'assets/icons/image-solid.svg',
                                height: 40,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
