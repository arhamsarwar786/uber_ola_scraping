import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_scrape/mytest.dart';
import 'package:uber_scrape/provider/my_provider.dart';
import 'package:uber_scrape/splash_screen.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
        theme: ThemeData(fontFamily: 'TiltNeon', primarySwatch: Colors.amber),
        home:  const SplashScreen(),
        // home: DemoTest(),
      ),
    );
  }
}