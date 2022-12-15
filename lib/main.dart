import 'package:flutter/material.dart';
import 'package:uber_scrape/example.dart';
import 'package:uber_scrape/fare_screen.dart';
import 'package:uber_scrape/map_screen.dart';
import 'package:uber_scrape/search_screen.dart';
import 'package:uber_scrape/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple
      ),
    // home: SearchScreen("demox"),
    home: SplashScreen(),
    );
  }
}
