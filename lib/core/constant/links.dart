class Links {
  static const String server = 'http://qrcodecreator.atwebpages.com/qrcodeapp';
// image server
  static const String imageServer =
      'http://qrcodecreator.atwebpages.com/qrcodeapp/upload';
// profile image
  static const String profileImage = '$imageServer/profile_image';
  static const String qrcodeImage = '$imageServer/qr_codes_images';
  static const String scannedFiles = '$imageServer/scanned_files';

// history
  static const String addHistory = '$server/history/add.php';
  static const String viewHistory = '$server/history/view.php';
  static const String deleteHistory = '$server/history/delete.php';
// auth
  static const String login = '$server/auth/login.php';
  static const String register = '$server/auth/register.php';
  static const String verifyRegister = '$server/auth/verify_register.php';
  static const String resend = '$server/auth/resend.php';
// auth
  static const String checkEmail = '$server/forgetpassword/checkEmail.php';
  static const String verifyReset = '$server/forgetpassword/verifyReset.php';
  static const String resetPassword =
      '$server/forgetpassword/resetPassword.php';

// myQrCodes
  static const String addQRcode = '$server/myQrCodes/addqrcode.php';
  static const String addFile = '$server/myQrCodes/add_file.php';
  static const String viewQRcode = '$server/myQrCodes/view.php';
  static const String deleteQRcode = '$server/myQrCodes/delete.php';
}
