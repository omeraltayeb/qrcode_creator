import 'dart:async';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../../core/function/check_internet.dart';
import '../../../view/screen/forgetpassword/reset_password.dart';
import '../../auth/authServices/auth_services.dart';
import 'verify_reset_state.dart';

class VerifyResetCubit extends Cubit<VerifyResetState> {
  VerifyResetCubit() : super(VerifyResetInitial());
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
        emit(VerifyResetLoaded());
      } else {
        timer.cancel();
      }
    });
  }

  // Verify reset
  Future<void> verifyReset(
      BuildContext context, String verifyCode, String email) async {
    if (!await _checkInternetAndEmitFailure()) return;
    emit(VerifyResetLoading());
    final response = await _authServices.verifyReset(email, verifyCode);
    if (response["status"] == "success") {
      _showSuccessAnimation(context);
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => ResetPassword(email: email)));
      });
      emit(VerifyResetLoaded());
    } else {
      _showToast(context, "Verify code is not correct");
      emit(VerifyResetFailure("Verify code is not correct"));
    }
  }

  // resend
  onResend(String email, BuildContext context) async {
    if (!await _checkInternetAndEmitFailure()) return;
    emit(VerifyResetLoading());
    final response = await _authServices.resend(email);
    if (response["status"] == "success") {
      emit(VerifyResetLoaded());
    } else {
      _showToast(context, "Failed to resend verification code");
      emit(VerifyResetFailure("Failed to resend verification code"));
    }
  }

  // Helpers
  Future<bool> _checkInternetAndEmitFailure() async {
    if (await checkInternet()) return true;

    emit(VerifyResetFailure('No internet access'));
    serverErrorMessage = 'No internet access';
    return false;
  }

  void _showToast(BuildContext context, String message) {
    CherryToast.warning(
      title: const Text("Warning", style: TextStyle(color: Colors.black)),
      action: Text(message, style: const TextStyle(color: Colors.black)),
    ).show(context);
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
