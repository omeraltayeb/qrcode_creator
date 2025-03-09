import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/services/services.dart';
import '../../view/screen/auth/login_screen.dart';
import '../../view/screen/main_screen.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitial());
  String? serverErrorMessage;
  final myServices = MyServices();

  void onTapSection(
      String sectionTitle, int initialIndex, BuildContext context) async {
    final isLogin = await myServices.getValue("isLogin") == "true";

    if (sectionTitle == 'Create QR Code' || sectionTitle == 'My QR Codes') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>
              isLogin ? MainScreen(initialIndex: initialIndex) : LoginScreen(),
        ),
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => MainScreen(initialIndex: initialIndex),
        ),
      );
    }
  }
}
