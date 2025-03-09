import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode_creator/cubits/main/main_states.dart';

import '../../view/screen/qrcode_type.dart';
import '../../view/screen/my_qrcode.dart';
import '../../view/screen/scan_history.dart';
import '../../view/screen/scan_qrcode.dart';
import '../../view/screen/settings_screen.dart';

class MainScreenCubit extends Cubit<MainStates> {
  MainScreenCubit({int initialIndex = 0})
      : super(MainInitial(index: initialIndex));

  void updateIndex(int index) {
    emit(MainInitial(index: index));
  }

  Widget buildPage(int index) {
    switch (index) {
      case 0:
        return QrcodeType();
      case 1:
        return ScanHistory();
      case 2:
        return ScanQrcode();
      case 3:
        return MyQrcode();
      case 4:
        return SettingsScreen();
      default:
        return Container();
    }
  }
}
