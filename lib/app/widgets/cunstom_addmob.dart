// import 'package:firebase_admob/firebase_admob.dart';
//
// class CunstomAddmob{
//   MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
//     keywords: <String>['flutterio', 'beautiful apps'],
//     contentUrl: 'https://google.com',
//     childDirected: false,
//     testDevices: <String>["android"],
//   );
//
//   BannerAd myBanner(){
//     return BannerAd(
//       adUnitId: 'ca-app-pub-5388821069914560~9286586672',
//       size: AdSize.smartBanner,
//       targetingInfo: targetingInfo,
//       listener: (MobileAdEvent event) {
//         print("BannerAd event is $event");
//       },
//     );
//   }
//
//   InterstitialAd myInterstitial(){
//     return InterstitialAd(
//       adUnitId: InterstitialAd.testAdUnitId,
//       targetingInfo: targetingInfo,
//       listener: (MobileAdEvent event) {
//         print("InterstitialAd event is $event");
//       },
//     );
//   }
// }