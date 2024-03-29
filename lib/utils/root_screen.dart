import "package:flutter/material.dart";
import 'package:uber_scrape/cream_webview.dart';
import 'package:uber_scrape/map_screen.dart';
import 'package:uber_scrape/ola_webview.dart';
import 'package:uber_scrape/uber_webview.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  List screenList = [
    const MapView(),
     olaWebView(),
    const uberWebView(),
    const creamWebView(),
  ];

  int activeContainerIndex = 0;

  List selectedScreenIndex = [0, 1, 2, 3];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenList[activeContainerIndex],
      bottomNavigationBar: BottomSheet(
        builder: (BuildContext context) {
          return Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: InkWell(
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
                            color: selectedScreenIndex[0] == activeContainerIndex
                                ? Colors.purple
                                : Colors.white,
                            borderRadius: BorderRadius.circular(0),
                            border: Border.all(
                              width: 1,
                              color: activeContainerIndex == 0
                                  ? Colors.purple
                                  : Colors.grey,
                            ),
                          ),
                          child: Icon(
                            activeContainerIndex == 0
                                ? Icons.home_sharp
                                : Icons.home_sharp,
                            size: 35,
                            color: activeContainerIndex == 0
                                ? Colors.white
                                : Colors.black,
                          )),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        activeContainerIndex = 1;
                      });
                    },
                    child: Container(
                      width: 100,
                      height: 60,
                      decoration: BoxDecoration(
                        color: selectedScreenIndex[1] == activeContainerIndex
                            ? Colors.purple
                            : Colors.white,
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(
                          width: 1,
                          color: activeContainerIndex == 1
                              ? Colors.purple
                              : Colors.grey,
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
                ),
                Expanded(
                  flex: 2,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        activeContainerIndex = 2;
                      });
                    },
                    child: Container(
                      width: 105,
                      height: 60,
                      decoration: BoxDecoration(
                        color: selectedScreenIndex[2] == activeContainerIndex
                            ? Colors.purple
                            : Colors.white,
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(
                          width: 1,
                          color: activeContainerIndex == 2
                              ? Colors.purple
                              : Colors.grey,
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
                ),
                Expanded(
                  flex: 2,
                  child: FittedBox(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          activeContainerIndex = 3;
                        });
                      },
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: selectedScreenIndex[3] == activeContainerIndex
                              ? Colors.purple
                              : Colors.white,
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(
                            width: 1,
                            color: activeContainerIndex == 3
                                ? Colors.purple
                                : Colors.grey,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(6.0),
                              child: CircleAvatar(
                                backgroundImage: AssetImage(
                                  'assets/images/cream_icon.png',
                                ),
                                radius: 15,
                              ),
                            ),
                            Text(
                              "Careem",
                              style: TextStyle(
                                  color: activeContainerIndex == 3
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        onClosing: () {},
      ),
    );
  }
}
