import 'package:flutter_app_badger/flutter_app_badger.dart';

class AppBadgePlugin {
  static Future<bool> get isBadgeSupported {
    return FlutterAppBadger.isAppBadgeSupported();
  }

  static updateBadgeCount(int count) async {
    if (!await isBadgeSupported) {
      print("Badge not supported");
      return;
    }
    FlutterAppBadger.updateBadgeCount(count);
    if (!await isBadgeSupported) {
      print("Badge not supported");
      return;
    }
    if (count == 0) FlutterAppBadger.removeBadge();
  }

  static Future<void> removeBadge() async {
    if (!await isBadgeSupported) {
      print("Badge not supported");
      return;
    }
    FlutterAppBadger.removeBadge();
  }
}
