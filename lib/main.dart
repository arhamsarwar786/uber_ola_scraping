// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:uber_scrape/example.dart';
import 'package:uber_scrape/fare_screen.dart';
import 'package:uber_scrape/map_screen.dart';
import 'package:uber_scrape/polygon.dart';
import 'package:uber_scrape/splash_screen.dart';
// import 'package:uber_scrape/bottom_sheet.dart';
import 'package:uber_scrape/uber_webview.dart';
// import 'package:uber_scrape/webView.dart';
import 'package:uber_scrape/utils/color_constants.dart';
import 'package:uber_scrape/utils/root_screen.dart';
import 'html_view.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    
      theme: ThemeData(fontFamily: 'TiltNeon', primarySwatch: Colors.purple),
      // home: SearchScreen("demox"),
      // ignore: prefer_const_constructors
      // home: MapView(),
      home:  const RootScreen(),
    //  home:  WebViewExample(),
   // home: MyWebView()
  // home: MyMap(),

    );
  }
}
