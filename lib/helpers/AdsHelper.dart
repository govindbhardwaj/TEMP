import 'package:firebase_admob/firebase_admob.dart';

BannerAd createBannerAd() {
  return new BannerAd(
      adUnitId: "ca-app-pub-1790548623336527/7780948871",
      size: AdSize.smartBanner,
      targetingInfo: targetInfo,
      listener: (MobileAdEvent event) {
        print("Banner event : $event");
      });
}

final MobileAdTargetingInfo targetInfo = new MobileAdTargetingInfo(
  testDevices: <String>[],
  keywords: <String>['quotes', 'inspiration', 'motivation', 'category'],
  birthday: new DateTime.now(),
  childDirected: true,
);
