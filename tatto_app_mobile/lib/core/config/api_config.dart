import 'dart:io' show Platform;

class ApiConfig {
  static String get baseUrl {
    // Use 10.0.2.2 for Android emulator, localhost for iOS simulator
    final host = Platform.isAndroid ? '10.0.2.2' : '127.0.0.1';
    return 'http://$host:8000/api/v1';
  }
  static const String generateEndpoint = '/generate';
}
