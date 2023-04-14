// ignore_for_file: unused_import



import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:uber_scrape/helpers/ad_helper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: const Color(0xff764abc),
            onPrimary: Colors.white,
          ),
        ),
      ),
      home: MyHomePage(),
      //home: const MyHomePage(title: 'AdMob Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static final AdRequest request = AdRequest();

  int maxFailedLoadAttempts = 10;
  int life = 0;
  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;

  // InterstitialAd? _interstitialAd;
  // int _numInterstitialLoadAttempts = 0;

  RewardedAd? _rewardedAd;
  int _numRewardedLoadAttempts = 0;

  RewardedInterstitialAd? _rewardedInterstitialAd;
  int _numRewardedInterstitialLoadAttempts = 0;

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
    // _createInterstitialAd();
    _createRewardedAd();
    _createRewardedInterstitialAd();
  }

  // Ads creation starts here
  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );

    _bannerAd.load();
  }

  // void _createInterstitialAd() {
  //   InterstitialAd.load(
  //       adUnitId: AdHelper.interstitialAdUnitId,
  //       request: request,
  //       adLoadCallback: InterstitialAdLoadCallback(
  //         onAdLoaded: (InterstitialAd ad) {
  //           print('$ad loaded');
  //           _interstitialAd = ad;
  //           _numInterstitialLoadAttempts = 0;
  //           _interstitialAd!.setImmersiveMode(true);
  //         },
  //         onAdFailedToLoad: (LoadAdError error) {
  //           print('InterstitialAd failed to load: $error.');
  //           _numInterstitialLoadAttempts += 1;
  //           _interstitialAd = null;
  //           if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
  //             _createInterstitialAd();
  //           }
  //         },
  //       ));
  // }

  void _createRewardedAd() {
    RewardedAd.load(
        adUnitId: AdHelper.rewardedAdUnitId,
        request: request,
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            print('$ad loaded.');
            _rewardedAd = ad;
            _numRewardedLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd failed to load: $error');
            _rewardedAd = null;
            _numRewardedLoadAttempts += 1;
            if (_numRewardedLoadAttempts < maxFailedLoadAttempts) {
              _createRewardedAd();
            }
          },
        ));
  }

  void _createRewardedInterstitialAd() {
    RewardedInterstitialAd.load(
        adUnitId: AdHelper.rewardedInterstitialAd,
        request: request,
        rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
          onAdLoaded: (RewardedInterstitialAd ad) {
            print('$ad loaded.');
            _rewardedInterstitialAd = ad;
            _numRewardedInterstitialLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedInterstitialAd failed to load: $error');
            _rewardedInterstitialAd = null;
            _numRewardedInterstitialLoadAttempts += 1;
            if (_numRewardedInterstitialLoadAttempts < maxFailedLoadAttempts) {
              _createRewardedInterstitialAd();
            }
          },
        ));
  }

  // Showing ads from here
  // void _showInterstitialAd() {
  //   if (_interstitialAd == null) {
  //     print('Warning: attempt to show interstitial before loaded.');
  //     return;
  //   }
  //   _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
  //     onAdShowedFullScreenContent: (InterstitialAd ad) =>
  //         print('ad onAdShowedFullScreenContent.'),
  //     onAdDismissedFullScreenContent: (InterstitialAd ad) {
  //       print('$ad onAdDismissedFullScreenContent.');
  //       ad.dispose();
  //       _createInterstitialAd();
  //     },
  //     onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
  //       print('$ad onAdFailedToShowFullScreenContent: $error');
  //       ad.dispose();
  //       _createInterstitialAd();
  //     },
  //   );
  //   _interstitialAd!.show();
  //   _interstitialAd = null;
  // }

void _showRewardedAd() {
  if (_rewardedAd == null) {
    // If the rewarded ad is null, load it and return.
    _createRewardedAd();
    return;
  }

  _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
    onAdShowedFullScreenContent: (RewardedAd ad) =>
        print('ad onAdShowedFullScreenContent.'),
    onAdDismissedFullScreenContent: (RewardedAd ad) {
      print('$ad onAdDismissedFullScreenContent.');
      ad.dispose();
      _createRewardedAd();
    },
    onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
      print('$ad onAdFailedToShowFullScreenContent: $error');
      ad.dispose();
      _createRewardedAd();
    },
  );

  _rewardedAd!.setImmersiveMode(true);
  _rewardedAd!.show(
      onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
    setState(() {
      life += 1;
    });
  });
  _rewardedAd = null;
}

  void _showRewardedInterstitialAd() {
    if (_rewardedInterstitialAd == null) {
      print('Warning: attempt to show rewarded interstitial before loaded.');
      return;
    }
    _rewardedInterstitialAd!.fullScreenContentCallback =
        FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedInterstitialAd ad) =>
          print('$ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedInterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createRewardedInterstitialAd();
      },
      onAdFailedToShowFullScreenContent:
          (RewardedInterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createRewardedInterstitialAd();
      },
    );

    _rewardedInterstitialAd!.setImmersiveMode(true);
    _rewardedInterstitialAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
      print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
    });
    _rewardedInterstitialAd = null;
  }

  @override
  void dispose() {
    super.dispose();
    _bannerAd.dispose();
    // _interstitialAd?.dispose();
    _rewardedAd?.dispose();
    _rewardedInterstitialAd?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AdMob Demo'),
        backgroundColor: const Color(0xff764abc),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Life',
                      style: TextStyle(fontSize: 30),
                    ),
                    Icon(
                      Icons.favorite,
                      size: 30,
                      color: Colors.redAccent,
                    ),
                    Text(
                      '$life',
                      style: TextStyle(fontSize: 30),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    // _showInterstitialAd();
                  },
                  child: Text(
                    ' InterstitialAd',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _showRewardedAd();
                  },
                  child: Text(
                    ' RewardedAd',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                // ElevatedButton(
                //   onPressed: () {
                //     _showRewardedInterstitialAd();
                //   },
                //   child: Text(
                //     'RewardedInterstitialAd',
                //     style: TextStyle(fontSize: 30),
                //   ),
                // ),
              ],
            ),
          ),
          if (_isBannerAdReady)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: _bannerAd.size.width.toDouble(),
                height: _bannerAd.size.height.toDouble(),
                child: AdWidget(ad: _bannerAd),
              ),
            ),
        ],
      ),
    );
  }
}








// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:uber_scrape/cream_webview.dart';
// import 'package:uber_scrape/fare_screen.dart';
// import 'package:uber_scrape/map_screen.dart';
// import 'package:uber_scrape/ola_webview.dart';
// import 'package:uber_scrape/provider/my_provider.dart';
// import 'package:uber_scrape/splash_screen.dart';
// import 'package:uber_scrape/uber_webview.dart';
// import 'package:uber_scrape/utils/color_constants.dart';
// import 'package:uber_scrape/utils/root_screen.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';


// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   MobileAds.instance.initialize();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//    const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//          ChangeNotifierProvider<MyProvider>(create: (context) => MyProvider())
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(fontFamily: 'TiltNeon', primarySwatch: Colors.purple),
//         home:  const SplashScreen(),
//       ),
//     );
//   }
// }




// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:uber_scrape/cream_webview.dart';
// import 'package:uber_scrape/fare_screen.dart';
// import 'package:uber_scrape/map_screen.dart';
// import 'package:uber_scrape/ola_webview.dart';
// import 'package:uber_scrape/provider/my_provider.dart';
// import 'package:uber_scrape/splash_screen.dart';
// import 'package:uber_scrape/uber_webview.dart';
// import 'package:uber_scrape/utils/color_constants.dart';
// import 'package:uber_scrape/utils/root_screen.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'dart:io';


// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   MobileAds.instance.initialize();
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//    const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//     List screenList = [
//     const MapView(),
//     const olaWebView(),
//     const uberWebView(),
//     const creamWebView(),
//   ];

//   int activeContainerIndex = 0;

//   List selectedScreenIndex = [0, 1, 2, 3];

//   InterstitialAd? _interstitialAd;

//   String getAdUnitId() {
//     if (Platform.isAndroid) {
//       return 'ca-app-pub-3940256099942544/1033173712'; // Android Ad Unit ID
//     } else if (Platform.isIOS) {
//       return 'ca-app-pub-3940256099942544/4411468910'; // iOS Ad Unit ID
//     } else {
//       throw UnsupportedError('Unsupported platform');
//     }
//   }

//   void _showInterstitialAd() {
//     _interstitialAd?.show();
//     _createInterstitialAd();
//   }

// void _createInterstitialAd() {
//   InterstitialAd.load(
//       adUnitId: getAdUnitId(),
//       request: const AdRequest(),
//       adLoadCallback: InterstitialAdLoadCallback(
//         onAdLoaded: (InterstitialAd ad) {
//           _interstitialAd = ad;
//           // Show the ad if it's loaded and an item has been tapped
//           if (activeContainerIndex != null) {
//             _showInterstitialAd();
//           }
//         },
//         onAdFailedToLoad: (LoadAdError error) {
//           _interstitialAd = null;
//         },
//       ));
// }

//   @override
//   void initState() {
//     super.initState();
//     _createInterstitialAd();
//   }

//   @override
//   void dispose() {
//     _interstitialAd?.dispose();
//     super.dispose();
//   }

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//          ChangeNotifierProvider<MyProvider>(create: (context) => MyProvider())
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(fontFamily: 'TiltNeon', primarySwatch: Colors.purple),
//         home:  Scaffold(
//           body: screenList[activeContainerIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: Colors.grey[300],
//   currentIndex: activeContainerIndex,
//   onTap: (int index) {
//     setState(() {
//       activeContainerIndex = index;
//     });
//     _showInterstitialAd(); // Show interstitial ad when a bottom navigation bar item is tapped
//   },
//   items: [
//     BottomNavigationBarItem(
//       icon: Container(
//         padding: const EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           border: Border.all(
//                               width: 1,
//                               color: activeContainerIndex == 0
//                                   ? Colors.purple
//                                   : Colors.grey,
//                             ),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: const Icon(Icons.home_sharp),
//       ),
//       label: 'Home',
//     ),
//     BottomNavigationBarItem(
//       icon: Container(
//         padding: const EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           border: Border.all(
//                               width: 1,
//                               color: activeContainerIndex == 1
//                                   ? Colors.purple
//                                   : Colors.grey,
//                             ),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: const CircleAvatar(
//           backgroundImage: AssetImage('assets/images/ola_icon_full.png'),
//           radius: 15,
//         ),
//       ),
//       label: 'Ola',
//     ),
//     BottomNavigationBarItem(
//       icon: Container(
//         padding: const EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           border: Border.all(
//                               width: 1,
//                               color: activeContainerIndex == 2
//                                   ? Colors.purple
//                                   : Colors.grey,
//                             ),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: const CircleAvatar(
//           backgroundImage: AssetImage('assets/images/uber_icon_full.png'),
//           radius: 15,
//         ),
//       ),
//       label: 'Uber',
//     ),
//     BottomNavigationBarItem(
//       icon: Container(
//         padding: const EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           border: Border.all(
//                               width: 1,
//                               color: activeContainerIndex == 3
//                                   ? Colors.purple
//                                   : Colors.grey,
//                             ),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: const CircleAvatar(
//           backgroundImage: AssetImage('assets/images/cream_icon.png'),
//           radius: 15,
//         ),
//       ),
//       label: 'Careem',
//     ),
//   ],
//   selectedItemColor: Colors.purple,
//   unselectedItemColor: Colors.black,
//   type: BottomNavigationBarType.fixed,
// ),

//         )
//       ),
//     );
//   }
// }





// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   MobileAds.instance.initialize();
//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   InterstitialAd? _interstitialAd;

//   String getAdUnitId() {
//     if (Platform.isAndroid) {
//       return 'ca-app-pub-3940256099942544/1033173712'; // Android Ad Unit ID
//     } else if (Platform.isIOS) {
//       return 'ca-app-pub-3940256099942544/4411468910'; // iOS Ad Unit ID
//     } else {
//       throw UnsupportedError('Unsupported platform');
//     }
//   }

//   void _showInterstitialAd() {
//     _interstitialAd?.show();
//     _createInterstitialAd();
//   }

//   void _createInterstitialAd() {
//     InterstitialAd.load(
//         adUnitId: getAdUnitId(),
//         request: const AdRequest(),
//         adLoadCallback: InterstitialAdLoadCallback(
//           onAdLoaded: (InterstitialAd ad) {
//             _interstitialAd = ad;
//           },
//           onAdFailedToLoad: (LoadAdError error) {
//             _interstitialAd = null;
//           },
//         ));
//   }

//   @override
//   void initState() {
//     super.initState();
//     _createInterstitialAd();
//   }

//   @override
//   void dispose() {
//     _interstitialAd?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Interstitial Ad Demo'),
//         ),
//         body: const Center(
//           child: Text(
//             'I love you So much',
//             style: TextStyle(fontSize: 18),
//           ),
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           items: const [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               label: 'Home',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.search),
//               label: 'Search',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.add_circle_outline),
//               label: 'Add',
//             ),
//           ],
//           onTap: (int index) {
//           _showInterstitialAd();
//         },
//         ),
//       ),
//     );
//   }
// }