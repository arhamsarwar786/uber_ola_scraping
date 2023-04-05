import 'dart:collection';
import 'dart:io';

import "package:flutter/material.dart";
import 'package:uber_scrape/cream_webview.dart';
import 'package:uber_scrape/map_screen.dart';
import 'package:uber_scrape/ola_webview.dart';
import 'package:uber_scrape/polyline.dart';
import 'package:uber_scrape/uber_webview.dart';
// import 'package:store_redirect/store_redirect.dart';

import '../polygone+Map_screen.dart';
import '../willPop.dart';
 


class RootScreen extends StatefulWidget {
   const RootScreen({super.key,});

  @override
  State<RootScreen> createState() => _RootScreenState();
}



class _RootScreenState extends State<RootScreen> with TickerProviderStateMixin {
   late AnimationController _animationController;
  late Animation<double> _animation;
  List screenList = [
    const MapView(),
      olaWebView(),
      const uberWebView(),
        const creamWebView(),
  ];

  int activeContainerIndex = 0;

  List selectedScreenIndex = [0,1,2,3];
    _animationController =
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
  }
  
  void _onItemTapped(int index) {
    if (activeContainerIndex != index) {
      setState(() {
        activeContainerIndex = index;
      });
      _animationController.forward(from: 3);
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: screenList[activeContainerIndex],
        bottomNavigationBar: BottomSheet(
          builder: (BuildContext context){
              return Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      
                      activeContainerIndex = 0;
                      
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Container(
                        width: 40,
                        height: 60,
                        decoration: BoxDecoration(
                          color: selectedScreenIndex[0] == activeContainerIndex ? Colors.purple : Colors.white,
                          borderRadius: BorderRadius.circular(0),
                          border: Border.all(
                            width: 1,
                            color: activeContainerIndex == 0 ? Colors.purple : Colors.grey,
                          ),
                        ),
        
                        // color: Colors.purple[900],
                        child: Icon(
                          activeContainerIndex == 0 ? Icons.home_sharp : Icons.home_sharp,
                          size: 35,
                          color: activeContainerIndex == 0 ? Colors.white : Colors.black,
                        )
                        // child:  const Icon(
                        //   Icons.home_sharp,
                        //   size: 30.0,
                        //   color: Colors.white,
                        // ),
                        ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                    
                      activeContainerIndex = 1;
                      
                    });
        
                  },
                  child: Container(
                    width: 100,
                    height: 60,
                    decoration: BoxDecoration(
                      color: selectedScreenIndex[1] == activeContainerIndex ? Colors.purple : Colors.white,
        
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(
                        width: 1,
                        color: activeContainerIndex == 1 ? Colors.purple : Colors.grey,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0.0),
                          child: CircleAvatar(
                            backgroundImage: AssetImage(
                              'assets/images/ola_icon_full.png',
                            ),
                            radius: 15,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Ola",
                            style: TextStyle(
                                color: activeContainerIndex == 1
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                     
                    activeContainerIndex = 2;
                     
                    });
                  },
                  child: Container(
                    width: 105,
                    height: 60,
                    decoration: BoxDecoration(
                                            color: selectedScreenIndex[2] == activeContainerIndex ? Colors.purple : Colors.white,
        
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(
                        width: 1,
                        color: activeContainerIndex == 2 ? Colors.purple : Colors.grey,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0.0),
                          child: CircleAvatar(
                            backgroundImage: AssetImage(
                              'assets/images/uber_icon_full.png',
                            ),
                            radius: 15,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Uber",
                            style: TextStyle(
                                color: activeContainerIndex == 2
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                     
                    activeContainerIndex = 3;
                     
                    });
                  },
                  child: Container(
                    width: 115,
                    height: 60,
                    decoration: BoxDecoration(
                                            color: selectedScreenIndex[3] == activeContainerIndex ? Colors.purple : Colors.white,
        
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(
                        width: 1,
                        color: activeContainerIndex == 3 ? Colors.purple : Colors.grey,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0.0),
                          child: CircleAvatar(
                            backgroundImage: AssetImage(
                              'assets/images/cream_icon.png',
                            ),
                            radius: 15,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Careem",
                            style: TextStyle(
                                color: activeContainerIndex == 3
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
          }, onClosing: () {  },
           
        ),
          bottomNavigationBar: Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                
                InkWell(
                  onTap: () {
                    setState(() {
                    _onItemTapped(index) ;
                                 
                      activeContainerIndex = 0;
                      //here i am starting the use of animation
          
        
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: selectedScreenIndex[0] == activeContainerIndex ? Colors.purple : Colors.white,
                          borderRadius: BorderRadius.circular(0),
                          border: Border.all(
                            width: 1,
                            color: activeContainerIndex == 0 ? Colors.purple : Colors.grey,
                          ),
                        ),
    
                        // color: Colors.purple[900],
                        child: Icon(
                          activeContainerIndex == 0 ? Icons.home_sharp : Icons.home_sharp,
                          size: 35,
                          color: activeContainerIndex == 0 ? Colors.white : Colors.black,
                        )
                        // child:  const Icon(
                        //   Icons.home_sharp,
                        //   size: 30.0,
                        //   color: Colors.white,
                        // ),
                        ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                    _onItemTapped(index) ;
                      activeContainerIndex = 1;
                    
                      
                    });
                  },
                  child: Container(
                    width: 110,
                    height: 60,
                    decoration: BoxDecoration(
                      color: selectedScreenIndex[1] == activeContainerIndex ? Colors.purple : Colors.white,
    
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(
                        width: 1,
                        color: activeContainerIndex == 1 ? Colors.purple : Colors.grey,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(15, 10, 0, 7.5),
                          child: CircleAvatar(
                            backgroundImage: AssetImage(
                              'assets/images/ola_icon_full.png',
                            ),
                            radius: 15,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Ola",
                            style: TextStyle(
                                color: activeContainerIndex == 1
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                     _onItemTapped(index) ;
                    activeContainerIndex = 2;
                     
                    });
                  },
                  child: Container(
                    width: 110,
                    height: 60,
                    decoration: BoxDecoration(
                                            color: selectedScreenIndex[2] == activeContainerIndex ? Colors.purple : Colors.white,
    
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(
                        width: 1,
                        color: activeContainerIndex == 2 ? Colors.purple : Colors.grey,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(15, 10, 0, 7.5),
                          child: CircleAvatar(
                            backgroundImage: AssetImage(
                              'assets/images/uber_icon_full.png',
                            ),
                            radius: 15,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Uber",
                            style: TextStyle(
                                color: activeContainerIndex == 2
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
       
      ),
    );
  }
}