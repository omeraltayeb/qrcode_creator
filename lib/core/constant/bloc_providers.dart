import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import '../../cubits/Theme/theme_cubit.dart';
import '../../cubits/auth/login/login_cubit.dart';
import '../../cubits/auth/register/register_cubit.dart';
import '../../cubits/auth/verifyRegister/verify_register_cubit.dart';
import '../../cubits/create_qrcode/create_qrcode_cubit.dart';
import '../../cubits/forgetpassword/checkEmail/check_email_cubit.dart';
import '../../cubits/forgetpassword/resetPassword/reset_password_cubit.dart';
import '../../cubits/forgetpassword/verifyReset/verify_reset_cubit.dart';
import '../../cubits/google_ads/google_ads_cubit.dart';
import '../../cubits/home/home_cubit.dart';
import '../../cubits/main/main_screen_cubit.dart';
import '../../cubits/myQr/my_qr_cubit.dart';
import '../../cubits/profile/profile_cubit.dart';
import '../../cubits/qrCodeType/qr_code_type_cubit.dart';
import '../../cubits/resultCreateQrCode/result_create_cubit.dart';
import '../../cubits/scan_history/scan_history_cubit.dart';
import '../../cubits/scan_qr/scan_qr_cubit.dart';

List<SingleChildWidget> providers = [
  BlocProvider(create: (context) => ThemeCubit()),
  BlocProvider(create: (context) => LoginCubit()),
  BlocProvider(create: (context) => RegisterCubit()),
  BlocProvider(create: (context) => VerifyRegisterCubit()..initialData()),
  BlocProvider(create: (context) => CheckEmailCubit()),
  BlocProvider(create: (context) => VerifyResetCubit()..initialData()),
  BlocProvider(create: (context) => ResetPasswordCubit()),
  BlocProvider(create: (context) => ProfileCubit()..initialData()),
  BlocProvider(create: (context) => HomeCubit()),
  BlocProvider(create: (context) => MainScreenCubit()),
  BlocProvider(create: (context) => ScanQrCubit()),
  BlocProvider(create: (context) => ScanHistoryCubit()..fetchScannedData(0)),
  BlocProvider(create: (context) => CreateQrCodeCubit()),
  BlocProvider(create: (context) => MyQrCubit()..fetchData()),
  BlocProvider(create: (context) => GoogleAdsCubit()..loadBannerAd()),
  BlocProvider(create: (context) => QrCodeTypeCubit()),
  BlocProvider(create: (context) => ResultCreateQrCodeCubit()),
];
