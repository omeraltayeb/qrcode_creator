import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../cubits/notificationHelper/notification_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../firebase_options.dart';

class MyServices {
  static final MyServices _instance = MyServices._internal();
  late FlutterSecureStorage _secureStorage;

  bool isLocationEnabled = false;

  MyServices._internal();
  factory MyServices() => _instance;

  // Initialize Secure Storage
  Future<void> init() async {
    _secureStorage = const FlutterSecureStorage();
    MobileAds.instance.initialize();
    await NotificationHelper.initialize();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  // Save a value securely
  Future<void> setValue(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  // Retrieve a value securely
  Future<String?> getValue(String key) async {
    return await _secureStorage.read(key: key);
  }

  // Check if a key exists
  Future<bool> containsKey(String key) async {
    String? value = await _secureStorage.read(key: key);
    return value != null;
  }

  // Remove a value securely
  Future<void> removeValue(String key) async {
    await _secureStorage.delete(key: key);
  }

  // Clear all values securely
  Future<void> clear() async {
    await _secureStorage.deleteAll();
  }
}
