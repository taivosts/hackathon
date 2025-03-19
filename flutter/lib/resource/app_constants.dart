class AppConstants {
  AppConstants._();

  static String appName = 'AI Dreamers';
  static String baseURL = const String.fromEnvironment('BASE_URL');
  static bool isDebugUI = const String.fromEnvironment('DEBUGUI') == "TRUE";
}
