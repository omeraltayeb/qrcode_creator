import 'dart:io';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'register_state.dart';
import '../../../core/function/check_internet.dart';
import '../../../view/screen/auth/login_screen.dart';
import '../../../view/screen/auth/verify_register.dart';
import '../authServices/auth_services.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  // Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  // Form keys
  final registerForm = GlobalKey<FormState>();
  // State variables
  bool obscureText = true;
  bool obscureConfirmPassword = true;
  String? serverErrorMessage;
  File? image;

  // Services & Data layer
  final AuthServices _authServices = AuthServices();
  final ImagePicker _picker = ImagePicker();

  // Toggle password visibility
  void toggleVisibility() {
    obscureText = !obscureText;
    emit(state is Authenticated ? Authenticated() : RegisterInitial());
  }

  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword = !obscureConfirmPassword;
    emit(state is Authenticated ? Authenticated() : RegisterInitial());
  }

  // Pick image from gallery or camera
  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        image = File(pickedFile.path);
        emit(Authenticated());
      }
    } catch (e) {
      emit(RegisterFailure('Failed to pick image'));
    }
  }

  // Register
  Future<void> register(BuildContext context) async {
    if (!registerForm.currentState!.validate()) return;

    if (!await _checkInternetAndEmitFailure()) return;

    if (image == null) {
      _showToast(context, "Please select a profile image");
      return;
    }

    emit(RegisterLoading());

    final response = await _authServices.register(
      nameController.text,
      emailController.text,
      passwordController.text,
      image!,
    );

    if (response["status"] == "success") {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => VerifyRegisterScreen(email: emailController.text),
      ));
      emit(Authenticated());
    } else {
      _showToast(context, "Email already exists");
      emit(RegisterFailure("Email already exists"));
    }
  }

  // Change profile picture (bottom sheet)
  void changeProfile(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Camera Option
              InkWell(
                onTap: () {
                  pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.camera_alt, size: 50, color: Colors.blue),
                    SizedBox(height: 8),
                    Text('Camera', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              // Gallery Option
              InkWell(
                onTap: () {
                  pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.photo_library, size: 50, color: Colors.green),
                    SizedBox(height: 8),
                    Text('Gallery', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Helpers
  Future<bool> _checkInternetAndEmitFailure() async {
    if (await checkInternet()) return true;

    emit(RegisterFailure('No internet access'));
    serverErrorMessage = 'No internet access';
    return false;
  }

  void _showToast(BuildContext context, String message) {
    CherryToast.warning(
      title: const Text("Warning", style: TextStyle(color: Colors.black)),
      action: Text(message, style: const TextStyle(color: Colors.black)),
    ).show(context);
  }

  void loginNav(BuildContext context) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen()));
  }
}
