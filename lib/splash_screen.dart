// ignore_for_file: file_names

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:uber_scrape/map_screen.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  late Animation colorAnimation;
 
  @override
  void initState() {
    super.initState();
   
    Timer(Duration(seconds: 3), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) =>  MapView() ));
      
      
    });
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 150, end: 300).animate(controller);
    // colorAnimation =
    //     ColorTween(begin: kprimayColor, end: primayColor).animate(controller);
    animation.addListener(() {
      setState(() {});
    });
    controller.forward();
  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

 
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            height: animation.value,
            width: animation.value,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'assets/images/logo.png',
                    ),
                    fit: BoxFit.fitWidth)),
          ),
        ),
      ),
    );
  }
}