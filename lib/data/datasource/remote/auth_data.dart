import 'dart:io';
import '../../../core/constant/links.dart';
import '../../../core/class/crud.dart';

class AuthData {
  Crud crud = Crud();

  registerData(
      String username, String email, String password, File profileImage) async {
    var response = await crud.postData(Links.register, {
      'username': username,
      'email': email,
      'password': password,
      'profile_image': profileImage,
    });
    return response;
  }

  loginData(String email, String password) async {
    var response = await crud.postData(Links.login, {
      'email': email,
      'password': password,
    });
    return response;
  }

  verifyRegisterData(String email, String verifycode) async {
    var response = await crud.postData(Links.verifyRegister, {
      'email': email,
      'verifycode': verifycode,
    });
    return response;
  }

  resendData(String email) async {
    var response = await crud.postData(Links.resend, {
      'email': email,
    });
    return response;
  }

  checkEmailData(String email) async {
    var response = await crud.postData(Links.checkEmail, {
      'email': email,
    });
    return response;
  }

  verifyReseData(String email, String verifycode) async {
    var response = await crud.postData(Links.verifyReset, {
      'email': email,
      'verifycode': verifycode,
    });
    return response;
  }

  resePasswordData(String email, String userpassword) async {
    var response = await crud.postData(Links.verifyReset, {
      'email': email,
      'userpassword': userpassword,
    });
    return response;
  }
}
