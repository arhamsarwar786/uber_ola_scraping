import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_scrape/provider/my_provider.dart';
import 'package:uber_scrape/splash_screen.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
    MyApp({super.key});

   MaterialColor mycolor = MaterialColor(const Color.fromARGB(255, 0, 33, 90).value, const <int, Color>{
      50: Color.fromRGBO(255, 0, 33, 0.1),
      100: Color.fromRGBO(0, 137, 123, 0.2),
      200: Color.fromRGBO(0, 137, 123, 0.3),
      300: Color.fromRGBO(0, 137, 123, 0.4),
      400: Color.fromRGBO(0, 137, 123, 0.5), 
      500: Color.fromRGBO(0, 137, 123, 0.6),
      600: Color.fromRGBO(0, 137, 123, 0.7),
      700: Color.fromRGBO(0, 137, 123, 0.8),
      800: Color.fromRGBO(0, 137, 123, 0.9),
      900: Color.fromRGBO(0, 137, 123, 1),
    },
  ); 

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
         ChangeNotifierProvider<MyProvider>(create: (context) => MyProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'TiltNeon', primarySwatch: mycolor),
        home:  const SplashScreen(),
        // home: DemoTest(),
      ),
    );
  }
}