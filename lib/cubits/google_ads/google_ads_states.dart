abstract class GoogleAdsStates {}

class GoogleAdsInitial extends GoogleAdsStates {}

class GoogleAdsLoading extends GoogleAdsStates {}

class GoogleAdsLoaded extends GoogleAdsStates {
  GoogleAdsLoaded();
}

class GoogleAdsFailure extends GoogleAdsStates {
  final String error;
  GoogleAdsFailure(this.error);
}
