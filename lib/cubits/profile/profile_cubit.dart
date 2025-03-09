import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qrcode_creator/core/services/services.dart';
import 'package:qrcode_creator/view/screen/auth/login_screen.dart';
import '../auth/authServices/auth_services.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  String? serverErrorMessage;
  File? image;
  String name = "";
  String email = "";
  String imagePath = "";
  String userCreatedAt = "";
  String isLoggedIn = "";

  final AuthServices authServices = AuthServices();
  final ImagePicker _picker = ImagePicker();
  final myServices = MyServices();

  void initialData() {
    getUserData();
  }

  Future<void> getUserData() async {
    name = (await myServices.getValue("username")) ?? "";
    email = (await myServices.getValue("userEmail")) ?? "";
    imagePath = (await myServices.getValue("profileImage")) ?? "";
    userCreatedAt = (await myServices.getValue("userCreatedAt")) ?? "";
    isLoggedIn = (await myServices.getValue("isLogin")) ?? "";

    emit(ProfileLoaded());
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        image = File(pickedFile.path);
        emit(ProfileLoaded());
      }
    } catch (e) {
      emit(ProfileFailure('Failed to pick image'));
    }
  }

  void changeProfile(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
      ),
      builder: (_) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.close,
                      size: 40,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.delete,
                      size: 40,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
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
                  InkWell(
                    onTap: () {
                      pickImage(ImageSource.gallery);
                      Navigator.of(context).pop();
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.photo_library,
                            size: 50, color: Colors.green),
                        SizedBox(height: 8),
                        Text('Gallery', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> logOut(BuildContext context) async {
    await myServices.clear();
    emit(ProfileInitial());
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => LoginScreen()), (route) => false);
  }
}
