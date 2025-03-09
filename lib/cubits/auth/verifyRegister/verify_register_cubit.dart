import 'dart:async';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:qrcode_creator/view/screen/auth/login_screen.dart';
import '../../../core/function/check_internet.dart';
import '../authServices/auth_services.dart';
import 'verify_register_state.dart';

class VerifyRegisterCubit extends Cubit<VerifyRegisterState> {
  VerifyRegisterCubit() : super(VerifyRegisterInitial());
  // Services & Data layer
  final AuthServices _authServices = AuthServices();
  String? serverErrorMessage;

  // verify code timer
  int seconds = 60;
  late Timer timer;

  // Initializer
  initialData() {
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        seconds--;
        emit(VerifyRegisterLoaded());
      } else {
        timer.cancel();
      }
    });
  }

  // Verify register
  Future<void> verifyRegister(
      BuildContext context, String verifyCode, String email) async {
    if (!await _checkInternetAndEmitFailure()) return;
    emit(VerifyRegisterLoading());
    final response = await _authServices.verifyRegister(email, verifyCode);
    if (response["status"] == "success") {
      _showSuccessAnimation(context);
      Future.delayed(const Duration(seconds: 3), () {
        _navigateToLogin(context);
      });
      emit(VerifyRegisterLoaded());
    } else {
      _showToast(context, "Verify code is not correct");
      emit(VerifyRegisterFailure("Verify code is not correct"));
    }
  }

  // resend
  onResend(String email, BuildContext context) async {
    if (!await _checkInternetAndEmitFailure()) return;
    emit(VerifyRegisterLoading());
    final response = await _authServices.resend(email);
    if (response["status"] == "success") {
      emit(VerifyRegisterLoaded());
    } else {
      _showToast(context, "Failed to resend verification code");
      emit(VerifyRegisterFailure("Failed to resend verification code"));
    }
  }

  // Helpers
  Future<bool> _checkInternetAndEmitFailure() async {
    if (await checkInternet()) return true;

    emit(VerifyRegisterFailure('No internet access'));
    serverErrorMessage = 'No internet access';
    return false;
  }

  void _showToast(BuildContext context, String message) {
    CherryToast.warning(
      title: const Text("Warning", style: TextStyle(color: Colors.black)),
      action: Text(message, style: const TextStyle(color: Colors.black)),
    ).show(context);
  }

  void _navigateToLogin(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => LoginScreen()),
      (route) => false,
    );
  }

  void _showSuccessAnimation(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset('assets/lottie/success.json', height: 150),
            const Text(
              "Verification Successful!",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
