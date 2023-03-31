import "package:flutter/material.dart";
import 'package:uber_scrape/map_screen.dart';
import 'package:uber_scrape/ola_webview.dart';
import 'package:uber_scrape/uber_webview.dart';
// import 'package:store_redirect/store_redirect.dart';


class RootScreen extends StatefulWidget {
   const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  List screenList = [
    const MapView(),
     olaWebView(),
      uberWebView(),
  ];

  int activeContainerIndex = 0;

  List selectedScreenIndex = [0,1,2];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: screenList[activeContainerIndex],
        bottomNavigationBar: Container(
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
        ),
     
    );
  }
}