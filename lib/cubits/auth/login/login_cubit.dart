import 'dart:developer';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../core/function/check_internet.dart';
import 'login_state.dart';
import '../../../view/screen/auth/register_screen.dart';
import '../../../view/screen/auth/verify_register.dart';
import '../../../view/screen/forgetpassword/check_email.dart';
import '../../../view/screen/main_screen.dart';
import '../authServices/auth_services.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  // Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  // Form keys
  final loginForm = GlobalKey<FormState>();
  // Services & Data layer
  final AuthServices _authServices = AuthServices();
  // State variables
  bool obscureText = true;
  String? serverErrorMessage;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  // Toggle password visibility
  void toggleVisibility() {
    obscureText = !obscureText;
    emit(state is Authenticated ? Authenticated() : LoginInitial());
  }

  // Login
  Future<void> login(BuildContext context) async {
    if (!loginForm.currentState!.validate()) return;
    if (!await _checkInternetAndEmitFailure()) return;
    emit(LoginLoading());
    final response = await _authServices.login(
      emailController.text,
      passwordController.text,
    );

    if (response["status"] == "success") {
      final user = response["data"];
      if (user["user_approve"] == 1) {
        await _authServices.saveUserData(user);
        _navigateToMainScreen(context);
        emit(Authenticated());
      } else {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => VerifyRegisterScreen(email: emailController.text),
        ));
        emit(Authenticated());
      }
    } else {
      _showToast(context, "Email not found");
      emit(LoginFailure("Email not found"));
    }
  }

  Future<void> loginWithGoogle(BuildContext context) async {
    try {
      emit(LoginLoading());

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        emit(LoginFailure("Google sign-in aborted"));
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        await _authServices.saveUserData({
          "user_id": user.uid,
          "username": user.displayName ?? "Google User",
          "user_email": user.email,
          "profile_image": user.photoURL ?? "",
          "user_created_at": user.metadata.creationTime.toString(),
        });

        _navigateToMainScreen(context);
        emit(Authenticated());
      } else {
        emit(LoginFailure("Google sign-in failed"));
      }
    } catch (e) {
      log("Error: ${e.toString()}");
      emit(LoginFailure("Error: ${e.toString()}"));
    }
  }

  // Helpers
  Future<bool> _checkInternetAndEmitFailure() async {
    if (await checkInternet()) return true;

    emit(LoginFailure('No internet access'));
    serverErrorMessage = 'No internet access';
    return false;
  }

  void _showToast(BuildContext context, String message) {
    CherryToast.warning(
      title: const Text("Warning", style: TextStyle(color: Colors.black)),
      action: Text(message, style: const TextStyle(color: Colors.black)),
    ).show(context);
  }

  void _navigateToMainScreen(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => MainScreen()),
      (route) => false,
    );
  }

  void forgetPassNav(BuildContext context) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => CheckEmail()));
  }

  void registerNav(BuildContext context) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => RegisterScreen()));
  }
}
