import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/config/config.dart';

const storeKey = 'showAds';

class ShowAdsNotifier extends StateNotifier<bool> {
  ShowAdsNotifier() : super(false) {
    checkAdsState();
  }

  void checkAdsState() async {
    state = await SharePreferencesPlugin.getBool(storeKey) ?? true;
  }

  void toggleAdsState() async {
    state ? removeAds() : showAds();
  }

  void removeAds() {
    state = false;
    SharePreferencesPlugin.setBool(storeKey, state);
  }

  void showAds() {
    state = true;
    SharePreferencesPlugin.setBool(storeKey, state);
  }
}

final showAdsProvider = StateNotifierProvider<ShowAdsNotifier, bool>((ref) {
  return ShowAdsNotifier();
});
