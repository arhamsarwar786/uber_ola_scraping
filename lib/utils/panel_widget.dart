import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/gestures.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
// import 'package:uber_scrape/fare_screen.dart';
// import 'package:uber_scrape/ola_webview.dart';
import 'package:uber_scrape/search_handler.dart';
// import 'package:uber_scrape/uber_webview.dart';
import 'package:uber_scrape/utils/color_constants.dart';
import 'package:uber_scrape/utils/gloablState.dart';

// import '../bottom_sheet_dynamic.dart';
import '../map_screen.dart';
// import 'package:uber_scrape/utils/gloablState.dart';
// import 'package:uber_scrape/utils/utils.dart';
// import 'package:uber_scrape/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

// void togglePanel() => PanelController.isPanelOpen ? panelController.close() : panelController.open();

// This page shows a Google Map plugin with all stations (HvD and Total). The markers are pulled from a Firebase database.

class PanelWidget extends StatefulWidget {
  final ScrollController controller;
  final PanelController panelController;

  const PanelWidget({
    Key? key,
    required this.controller,
    required this.panelController,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PanelWidgetState createState() => _PanelWidgetState();
}

class _PanelWidgetState extends State<PanelWidget> {
  int _selectedContainer = 1;
  // final String data1 = "assets/images/bike_icon.png";
  // final String data2 = "assets/images/autorikshaw_icon.png";
  // final String data3 = "assets/images/small_car_icon.png";
  // final String data4 = "assets/images/big_car_icon.png";

  var imagesList = [
    "assets/images/bike_icon.png",
    "assets/images/autorikshaw_icon.png",
    "assets/images/small_car_icon.png",
    "assets/images/big_car_icon.png"
  ];
 final person = [
    "Mini","Mini",
    "uber go","uber go"

  ];
  final sub = [
    "Affordable",
    "Every day",
    "Every day","Every day"

  ];
  final image = [
    "assets/images/uber_icon_full.png",
    "assets/images/uber_icon_full.png",
    "assets/images/uber_icon_full.png","assets/images/uber_icon_full.png"
  ];
  late final WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    // if(
    //   GlobalState.destinationAddress != null && GlobalState.pickUpAddress != null
    // ){
    //   widget.panelController.close();
    // }
    return SingleChildScrollView(
      controller: ScrollController(
        initialScrollOffset: 0.0,
        keepScrollOffset: true,
      ),
      // physics: const NeverScrollableScrollPhysics(),
      child: Column(children: [
        const SizedBox(height: 15),
        buildDragHandle(),
        Container(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
          color: Colors.white,
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  handlePressButton(context, 'pickUp');
                  if (GlobalState.destinationAddress != null &&
                      GlobalState.pickUpAddress != null) {
                    widget.panelController.close();
                  }
                  // Navigator.push(context, MaterialPageRoute(builder: (_)=> SearchScreen('Pick Up') ));
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(7, 10, 15, 0),
                  child: TextField(
                    style: const TextStyle(fontSize: 16),
                    controller: pickUpController,
                    enabled: false,
                    decoration: const InputDecoration(
                        icon: Icon(
                          Icons.accessibility_new,
                          color: Colors.black,
                        ),
                        hintText: "Pick Up",
                        border: InputBorder.none),
                  ),
                ),
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                    child: SizedBox(
                      height: 20,
                      child: VerticalDivider(
                        color: Colors.grey,
                        thickness: 2.5,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.83,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.5,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (_)=> SearchScreen('Destination') ));
                  handlePressButton(context, 'destination');
                  if (GlobalState.destinationAddress != null &&
                      GlobalState.pickUpAddress != null) {
                    widget.panelController.close();
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(7, 0, 15, 0),
                  child: TextField(
                    style: const TextStyle(fontSize: 16),
                    controller: destinationController,
                    enabled: false,
                    decoration: const InputDecoration(
                        icon: Icon(
                          Icons.fmd_good_sharp,
                          color: Colors.red,
                        ),
                        hintText: "Destination",
                        border: InputBorder.none),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 24, 8, 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          _selectedContainer = 1;
                        });
                      },
                      child: Container(
                        width: 70,
                        height: 45,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: _selectedContainer == 1
                              ? MyColors.fareIconsColor
                              : Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: .5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.05,
                          ),
                          borderRadius: BorderRadius.circular(17.5),
                        ),
                        child: Image.asset(
                          'assets/images/bike_icon.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _selectedContainer = 2;
                        });
                      },
                      child: Container(
                        width: 70,
                        height: 45,
                        padding: const EdgeInsets.all(9),
                        decoration: BoxDecoration(
                          color: _selectedContainer == 2
                              ? MyColors.fareIconsColor
                              : Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: .5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.05,
                          ),
                          borderRadius: BorderRadius.circular(17.5),
                        ),
                        child: Image.asset(
                          "assets/images/autorikshaw_icon.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _selectedContainer = 3;
                        });
                      },
                      child: Container(
                        width: 70,
                        height: 45,
                        padding: const EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          color: _selectedContainer == 3
                              ? MyColors.fareIconsColor
                              : Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: .5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.05,
                          ),
                          borderRadius: BorderRadius.circular(17.5),
                        ),
                        child: Image.asset(
                          'assets/images/small_car_icon.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _selectedContainer = 4;
                        });
                      },
                      child: Container(
                        width: 70,
                        height: 45,
                        padding: const EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          color: _selectedContainer == 4
                              ? MyColors.fareIconsColor
                              : Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: .5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.05,
                          ),
                          borderRadius: BorderRadius.circular(17.5),
                        ),
                        child: Image.asset(
                          'assets/images/big_car_icon.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
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
                              const Padding(
                                padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                                child: Text(
                                  "Ola",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                        child: Row(
                          children: [
                            Container(
                              width: 190,
                              height: 40,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 218, 210, 231),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(13)),
                              ),
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const AlertDialog(
                                          contentPadding: EdgeInsets.zero,
                                          content: SizedBox(
                                            width: double.maxFinite,
                                            height: double.maxFinite,
                                            child: WebviewScaffold(
                                              url:
                                                  'https://book.olacabs.com/?serviceType=p2p&utm_source=widget_on_olacabs&drop_lat=25.8498572&drop_lng=85.6666046&drop_name=Tajpur%2C%20Bihar%2C%20India&lat=18.9224864&lng=72.8340377&pickup_name=WRCM%20XPX%2C%20Apollo%20Bandar%2C%20Colaba%2C%20Mumbai%2C%20Maharashtra%20400001%2C%20India&pickup=',
                                              withZoom: false,
                                              withLocalStorage: true,
                                            ),
                                          ),
                                        );
                                      });

                                  //                 Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => const olaWebView()),
                                  // );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    const Text(
                                      "Login to see prices ",
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Color.fromARGB(
                                              255, 137, 92, 146)),
                                    ),
                                    const Icon(
                                      Icons.logout_rounded,
                                      size: 18,
                                      color: Color.fromARGB(255, 137, 92, 146),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              const Padding(
                                padding: EdgeInsets.fromLTRB(15, 15, 0, 7.5),
                                child: CircleAvatar(
                                  backgroundImage: AssetImage(
                                    'assets/images/uber_icon_full.png',
                                  ),
                                  radius: 17,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(11, 10, 0, 0),
                                child: Text(
                                  "Uber",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                        child: Row(
                          children: [
                            Container(
                              width: 190,
                              height: 40,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 218, 210, 231),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(13)),
                              ),
                              child: InkWell(
                                onTap: (() {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const AlertDialog(
                                          contentPadding: EdgeInsets.zero,
                                          content: SizedBox(
                                            width: double.maxFinite,
                                            height: double.maxFinite,
                                            child: WebviewScaffold(
                                              url:
                                                  'https://auth.uber.com/v2/?breeze_local_zone=dca11&next_url=https%3A%2F%2Fm.uber.com%2F&state=lSiz3gpn8PSJM6ZYM3A_UkG24kwaH8AtQ54vYuGaf4s%3D',
                                              withZoom: false,
                                              withLocalStorage: true,
                                            ),
                                          ),
                                        );
                                      });

                                  //               Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => const uberWebView()),
                                  // );
                                }),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    const Text(
                                      "Login to see prices ",
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Color.fromARGB(
                                              255, 137, 92, 146)),
                                    ),
                                    const Icon(
                                      Icons.logout_rounded,
                                      size: 18,
                                      color: Color.fromARGB(255, 137, 92, 146),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(
                height: 32.5,
                thickness: 0.5,
                indent: 0,
                endIndent: 0,
                color: Colors.black,
              ),
              const SizedBox(
                height: 25,
              ),
              Column(
                children: [
                  SizedBox(
                    width: 100,
                    height: 75,
                    child: Image.asset(imagesList[_selectedContainer - 1]),
                  ),
                  // ignore: avoid_unnecessary_containers
                  Container(
                    child: const Text("No options available for now..."),
                  ),
                ],
              ),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          primary: false,
          padding: EdgeInsets.zero,
          itemCount: person.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 10, top: 2),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundImage: AssetImage(image[index]),
                  radius: 30,
                ),
                // Icon(Icons.person),
                trailing: Padding(
                  padding: const EdgeInsets.only(top: 5, right: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text(
                        "PKR216.00",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                title: Text(
                  person[index],
                ),

                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(sub[index]),
                ),
              ),
            );
          },
        )
      ]),
    );
  }

  Widget buildDragHandle() => GestureDetector(
        // /
        child: Center(
          child: Container(
            height: 5,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      );
}




// Deeplink Uber and Ola (redirect)
// Bottom Sheet Slide issue
// webview html find 
// alert box inside webview
