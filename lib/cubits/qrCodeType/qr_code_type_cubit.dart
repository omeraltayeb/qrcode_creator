import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../view/screen/create_qrcode.dart';
import 'qr_code_type_state.dart';

class QrCodeTypeCubit extends Cubit<QrCodeTypeState> {
  QrCodeTypeCubit() : super(QrCodeTypeInitial());

  void navigateToQrCreation(BuildContext context, {required bool isLink}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CreateQrCodeScreen(isLink: isLink),
      ),
    );
  }
}
