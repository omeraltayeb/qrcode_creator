import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode_creator/cubits/forgetpassword/checkEmail/check_email_state.dart';
import 'package:qrcode_creator/view/screen/auth/login_screen.dart';
import 'package:qrcode_creator/view/screen/forgetpassword/verify_reset.dart';

import '../../../core/function/check_internet.dart';
import '../../auth/authServices/auth_services.dart';

class CheckEmailCubit extends Cubit<CheckEmailState> {
  CheckEmailCubit() : super(CheckEmailInitial());

  String? serverErrorMessage;
  final emailController = TextEditingController();
  // Form keys
  final checkForm = GlobalKey<FormState>();
  // Services & Data layer
  final AuthServices _authServices = AuthServices();

  // check email
  Future<void> checkEmail(BuildContext context) async {
    if (!checkForm.currentState!.validate()) return;
    if (!await _checkInternetAndEmitFailure()) return;
    emit(CheckEmailLoaded());
    final response = await _authServices.checkEmail(emailController.text);

    if (response["status"] == "success") {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => VerifyReset(email: emailController.text)));
      emit(CheckEmailLoaded());
    } else {
      _showToast(context, "Email not found");
      emit(CheckEmailFailure("Email not found"));
    }
  }

  // Helpers
  Future<bool> _checkInternetAndEmitFailure() async {
    if (await checkInternet()) return true;

    emit(CheckEmailFailure('No internet access'));
    serverErrorMessage = 'No internet access';
    return false;
  }

  void _showToast(BuildContext context, String message) {
    CherryToast.warning(
      title: const Text("Warning", style: TextStyle(color: Colors.black)),
      action: Text(message, style: const TextStyle(color: Colors.black)),
    ).show(context);
  }

  loginNav(BuildContext context) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen()));
  }
}
