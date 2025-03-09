import 'dart:io';

class GoogleAdsHelper {
  static const String androidAdUnitId =
      'ca-app-pub-2106091024236111/6914536017';
  static const String androidRewardedAd =
      'ca-app-pub-2106091024236111/5454910841';

  static const String iosAdUnitId = 'ca-app-pub-2106091024236111/2414375611';
  static const String iosRewardedAd = 'ca-app-pub-2106091024236111/8232844358';

  //   'ca-app-pub-3940256099942544/2934735716';  Test ad unit ID for iOS
  // 'ca-app-pub-3940256099942544/6300978111';  Test ad unit ID for Android

  static String getAdUnitId() {
    if (Platform.isAndroid) {
      return androidAdUnitId;
    } else if (Platform.isIOS) {
      return iosAdUnitId;
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String getRewardedId() {
    if (Platform.isAndroid) {
      return androidRewardedAd;
    } else if (Platform.isIOS) {
      return iosRewardedAd;
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
