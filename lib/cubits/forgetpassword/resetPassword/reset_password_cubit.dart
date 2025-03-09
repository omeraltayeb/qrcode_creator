import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:qrcode_creator/view/screen/auth/login_screen.dart';

import '../../../core/function/check_internet.dart';
import '../../auth/authServices/auth_services.dart';
import 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());
  // Controllers
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Form keys
  final resetForm = GlobalKey<FormState>();

  // State variables
  bool obscureText = true;
  bool obscureConfirmPassword = true;
  String? serverErrorMessage;

  // Services & Data layer
  final AuthServices _authServices = AuthServices();

  // Toggle password visibility
  void toggleVisibility() {
    obscureText = !obscureText;
    emit(state is ResetPasswordLoaded
        ? ResetPasswordLoaded()
        : ResetPasswordInitial());
  }

  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword = !obscureConfirmPassword;
    emit(state is ResetPasswordLoaded
        ? ResetPasswordLoaded()
        : ResetPasswordInitial());
  }

  // reset password
  Future<void> resetPassword(BuildContext context, String email) async {
    if (!await _checkInternetAndEmitFailure()) return;
    emit(ResetPasswordLoading());
    final response =
        await _authServices.resetPassword(email, passwordController.text);
    if (response["status"] == "success") {
      _showSuccessAnimation(context);
      Future.delayed(const Duration(seconds: 3), () {
        _navigateToLogin(context);
      });
      emit(ResetPasswordLoaded());
    } else {
      _showToast(context, "Verify code is not correct");
      emit(ResetPasswordFailure("Verify code is not correct"));
    }
  }

  // Helpers
  Future<bool> _checkInternetAndEmitFailure() async {
    if (await checkInternet()) return true;

    emit(ResetPasswordFailure('No internet access'));
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
              "Password changed Successful!",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
