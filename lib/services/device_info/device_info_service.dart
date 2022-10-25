import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

///
/// Service which stores information regarding the device
/// which is running the app
///

class DeviceInfoService {
  ///
  /// VARIABLES
  ///

  late final deviceInfoPlugin = DeviceInfoPlugin();

  BaseDeviceInfo? baseDeviceInfo;

  dynamic get deviceInfo => defaultTargetPlatform == TargetPlatform.android
      ? baseDeviceInfo as AndroidDeviceInfo?
      : defaultTargetPlatform == TargetPlatform.iOS
          ? baseDeviceInfo as IosDeviceInfo?
          : baseDeviceInfo as WebBrowserInfo?;

  ///
  /// METHODS
  ///

  /// Logs proper info depending on the platform running the app
  Future<void> initProperInfo() async {
    baseDeviceInfo = await deviceInfoPlugin.deviceInfo;
  }
}
