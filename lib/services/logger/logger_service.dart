import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logger_flutter_fork/logger_flutter_fork.dart';
import 'package:logger_fork/logger_fork.dart';

///
/// Service which gives access to `logger` and
/// helper methods to easily log stuff to the console
///

class LoggerService {
  ///
  /// CONSTRUCTOR
  ///

  LoggerService() {
    logger = Logger(
      printer: PrettyPrinter(
        methodCount: 0,
        errorMethodCount: 3,
        lineLength: 50,
        noBoxingByDefault: true,
      ),
    );

    LogConsole.init();
  }

  ///
  /// VARIABLES
  ///

  late final Logger logger;

  ///
  /// METHODS
  ///

  /// Verbose log, grey color
  void v(value) => logger.v(value);

  /// 🐛 Debug log, blue color
  void d(value) => logger.d(value);

  /// 💡 Info log, light blue color
  void i(value) => logger.i(value);

  /// ⚠️ Warning log, orange color
  void w(value) => logger.w(value);

  /// ⛔ Error log, red color
  void e(value) => logger.e(value);

  /// 👾 What a terrible failure log, purple color
  void wtf(value) => logger.wtf(value);

  /// Logs JSON responses with proper formatting
  void logJson(String data, {bool isError = false}) {
    final object = json.decode(data);
    final prettyString = const JsonEncoder.withIndent('  ').convert(object);
    isError ? logger.e(prettyString) : logger.v(prettyString);
  }

  /// Opens [Logger] screen
  void openLogger(BuildContext context) => LogConsole.open(context);
}
