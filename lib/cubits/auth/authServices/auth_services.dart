import 'dart:io';
import '../../../core/services/services.dart';
import '../../../data/datasource/remote/auth_data.dart';

class AuthServices {
  final AuthData _authData = AuthData();
  final MyServices _myServices = MyServices();

// register
  Future<Map<String, dynamic>> register(
      String name, String email, String password, File image) async {
    return await _authData.registerData(name, email, password, image);
  }

// login
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await _authData.loginData(email, password);

    if (response['status'] == 'success') {
      /*   // حفظ التوكين بشكل آمن
      String token = response['data']['token'];
      await _myServices.setValue("authToken", token);
*/
      // حفظ باقي بيانات المستخدم
      await saveUserData(response['data']);
    }

    return response;
  }

// verifyRegister
  Future<Map<String, dynamic>> verifyRegister(
      String email, String verifyCode) async {
    return await _authData.verifyRegisterData(email, verifyCode);
  }

// resend
  Future<Map<String, dynamic>> resend(String email) async {
    return await _authData.resendData(email);
  }

  // check email
  Future<Map<String, dynamic>> checkEmail(String email) async {
    return await _authData.checkEmailData(email);
  }

  // verify reset
  Future<Map<String, dynamic>> verifyReset(
      String email, String verifyCode) async {
    return await _authData.verifyReseData(email, verifyCode);
  }

  // reset password
  Future<Map<String, dynamic>> resetPassword(
      String email, String userpassword) async {
    return await _authData.verifyReseData(email, userpassword);
  }

// saveUserData
  Future<void> saveUserData(Map<String, dynamic> userData) async {
    await _myServices.setValue("isLogin", "true");
    await _myServices.setValue("userid", userData["user_id"].toString());
    await _myServices.setValue("username", userData["username"]);
    await _myServices.setValue("userEmail", userData["user_email"]);
    await _myServices.setValue("profileImage", userData["profile_image"]);
    await _myServices.setValue(
        "userCreatedAt", userData["user_created_at"].toString());
  }

  Future<String?> getAuthToken() async {
    return await _myServices.getValue("authToken");
  }

  Future<void> logout() async {
    await _myServices.clear();
  }
}
