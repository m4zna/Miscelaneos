import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../config/config.dart';
import '../providers.dart';

final adBannerProvider = FutureProvider<BannerAd>((ref) async {
  final showAds = ref.watch(showAdsProvider);
  if (!showAds) throw 'Ads estan bloqueadas';
  final ad = await AdmobPlugin.loadBannerAd();
  return ad;
});

final adInterstitialProvider = FutureProvider.autoDispose<InterstitialAd>((ref) async {
  final showAds = ref.watch(showAdsProvider);
  if (!showAds) throw 'Ads estan bloqueadas';
  final ad = await AdmobPlugin.loadInterstitialAd();
  return ad;
});

final adRewardedProvider = FutureProvider.autoDispose<RewardedAd>((ref) async {
  final showAds = ref.watch(showAdsProvider);
  if (!showAds) throw 'Ads estan bloqueadas';
  final ad = await AdmobPlugin.loadRewardedAd();
  return ad;
});
