// ignore_for_file: unused_import


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_scrape/cream_webview.dart';
import 'package:uber_scrape/fare_screen.dart';
import 'package:uber_scrape/map_screen.dart';
import 'package:uber_scrape/ola_webview.dart';
import 'package:uber_scrape/provider/my_provider.dart';
import 'package:uber_scrape/splash_screen.dart';
import 'package:uber_scrape/uber_webview.dart';
import 'package:uber_scrape/utils/color_constants.dart';
import 'package:uber_scrape/utils/root_screen.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
   const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
         ChangeNotifierProvider<MyProvider>(create: (context) => MyProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'TiltNeon', primarySwatch: Colors.purple),
        home:  const SplashScreen(),
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