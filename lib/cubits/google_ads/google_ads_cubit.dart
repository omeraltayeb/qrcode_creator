import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'google_ads_helper.dart';
import 'google_ads_states.dart';

class GoogleAdsCubit extends Cubit<GoogleAdsStates> {
  GoogleAdsCubit() : super(GoogleAdsInitial());

  BannerAd? bannerAd;

  void loadBannerAd() {
    bannerAd = BannerAd(
      adUnitId: GoogleAdsHelper.getAdUnitId(),
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          bannerAd = ad as BannerAd?;
          emit(GoogleAdsLoaded());
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          emit(GoogleAdsFailure('Banner ad failed to load: $error'));
          log('Banner ad failed to load: $error');
        },
      ),
    )..load();
  }

  //        reward ads
  RewardedAd? _rewardedAd;
  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: GoogleAdsHelper.getRewardedId(),
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          _rewardedAd = ad;
          emit(GoogleAdsLoaded());
        },
        onAdFailedToLoad: (LoadAdError error) {
          emit(GoogleAdsFailure('Rewarded ad failed to load: $error'));
          log('Rewarded ad failed to load: $error');
        },
      ),
    );
  }

  void showRewardedAd() {
    if (_rewardedAd != null) {
      _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (RewardedAd ad) {
          ad.dispose();
          _loadRewardedAd();
          emit(GoogleAdsLoaded());
        },
        onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
          ad.dispose();
          emit(GoogleAdsFailure('Rewarded ad failed to show: $error'));

          log('Rewarded ad failed to show: $error');
        },
      );

      _rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
          log('User earned reward: ${reward.amount} ${reward.type}');
        },
      );
    } else {
      log('Rewarded ad is not loaded yet.');
    }
  }
}
