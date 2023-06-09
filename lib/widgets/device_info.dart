import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';

class DeviceInfo {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  static String name = "";
  static String id = "";
  static String version = "";

  /// checks if platform is IOS and has ios version is 14 or above
  static Future<bool> isIos14andAbove() async {
    bool _isIos14andAbove = false;
    try {
      if (Platform.isIOS) {
        var version = await getIOSVersion();
        _isIos14andAbove = version >= 14 ? true : false;
      }
    } catch (e) {
      _isIos14andAbove = false;
    }
    return _isIos14andAbove;
  }

  /// returns IOS version
  static Future<double> getIOSVersion() async {
    var iosInfo = await DeviceInfoPlugin().iosInfo;
    var version = double.parse(iosInfo.systemVersion);
    print("IOS version => $version");
    return version;
  }

  /// initialize the class to read devcie info
  Future<void> initPlatformState() async {
    try {
      if (Platform.isAndroid) {
        _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }
    } on PlatformException {
      print("Error: 'Failed to get platform version.'");
    } finally {
      print("device info: $name | $id");
    }
  }

  /// set the device info for android
  void _readAndroidBuildData(AndroidDeviceInfo build) {
    name = build.model;
    id = build.androidId;
    version = build.version.release.toString();
  }

  /// set the device info for ios
  void _readIosDeviceInfo(IosDeviceInfo data) {
    name = "${data.systemName} ${data.systemVersion}";
    id = data.identifierForVendor;
    version = data.systemVersion;
  }
}