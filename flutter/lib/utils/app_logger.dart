import 'dart:developer' as developer;

class AppLogger {
  AppLogger._();
  static logDebug(String message) {
    developer.log(message, name: "DEBUG");
  }

  static logInfo(String message) {
    developer.log(message, name: "INFO");
  }

  static logError(String message) {
    developer.log(message, name: "ERROR");
  }
}
