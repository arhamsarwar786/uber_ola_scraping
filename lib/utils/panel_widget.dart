import 'dart:async';
import 'dart:developer';
import 'package:html/parser.dart' show parse;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:uber_scrape/provider/my_provider.dart';
import 'package:uber_scrape/search_handler.dart';
import 'package:uber_scrape/uber_webview.dart';
import 'package:uber_scrape/utils/color_constants.dart';
import 'package:uber_scrape/utils/gloablState.dart';
import '../map_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:html/dom.dart' as dom;

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

  bool get isFormFilled =>
      pickUpController.text.isNotEmpty && destinationController.text.isNotEmpty;

  Future<bool> _onWillPop() async {
    if (isFormFilled) {
      return (await showDialog<bool>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Center(child: Text('Exit Ek CapFare?')),
                  actions: <Widget>[
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.purple[800],
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: TextButton(
                          child: const Text(
                            'Exit',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                        ),
                      ),
                    ),
                    Center(
                      child: TextButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                      ),
                    ),
                  ],
                );
              })) ??
          false;
    } else {
      return true;
    }
  }

  List<String> listItems = [];
  late WebViewController _webViewController;
  String _htmlContent = '';
  Timer? _timer;


  @override
  void dispose() {    
    super.dispose();
    _timer!.cancel();
  }

  @override
  void initState() {
    super.initState();
    // String? htmlContent = GlobalState.uberHTML;
    // dom.Document document = parse(htmlContent!);
    // List<dom.Element> listElements = document.querySelectorAll('div > ul > li');
    // listItems = listElements
    //     .where((element) => !element.querySelectorAll('li > p').isNotEmpty)
    //     .map((e) => e.text)
    //     .toList();
  }

  var imagesList = [
    "assets/images/bike_icon.png",
    "assets/images/autorikshaw_icon.png",
    "assets/images/small_car_icon.png",
    "assets/images/big_car_icon.png"
  ];
  // ignore: unused_field

  late String _initialUrl;

  // final String _pickupAddressLine1 = 'Jail Road';
  final String? _pickupAddressLine2 = GlobalState.pickUpAddress;
  final double? _pickupLat = GlobalState.pickUpLat;
  final double? _pickupLng = GlobalState.pickUpLng;

  // final String _dropAddressLine1 = 'Kinnaird College For Women University';
  final String? _dropAddressLine2 = GlobalState.destinationAddress;
  final double? _dropLat = GlobalState.destinationLat;
  final double? _dropLng = GlobalState.destinationLng;

   WebViewController? webViewController;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Stack(
        children: [
          // uberHandler(),

        // GlobalState.pickUpAddress != null && GlobalState.destinationAddress != null ?

          Container(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
            color: Colors.white,
            child: Column(
              children: [
          uberHandler(),
                // ElevatedButton(onPressed: ()async{
                //   await _webViewController!.reload();
                //   // await _webViewController!.clearCache();
                //   setState(() {
                    
                //   });
                // }, child: Text("HIT MY")),
                const SizedBox(
                  height: 10,
                ),
                buildDragHandle(),
                InkWell(
                  onTap: () async {
                    await handlePressButton(context, 'pickUp');
                    if (GlobalState.pickUpAddress != null) {
                      widget.panelController.close();
              
                      var provider =
                          Provider.of<MyProvider>(context, listen: false);
                      provider.getDirections();
                    }
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
                  onTap: () async {
                    await handlePressButton(context, 'destination');

                    if (GlobalState.destinationAddress != null &&
                        GlobalState.pickUpAddress != null) {
                      widget.panelController.open();

                      var provider =
                          Provider.of<MyProvider>(context, listen: false);
                      provider.getDirections();

                      //  await uberHandler();
                      setState(() {});

                      // if (GlobalState.pickUpAddress != null &&
                      //     GlobalState.destinationAddress != null) {
                      //   _initialUrl =
                      //       'https://m.uber.com/looking?drop%5B0%5D=%7B%22latitude%22%3A$_dropLat%2C%22longitude%22%3A$_dropLng%2C%22addressLine1%22%3A%22Lakshmi%20Chowk%20Lahore%22%2C%22addressLine2%22%3A%22$_dropAddressLine2%22%2C%22id%22%3A%22ChIJ4a_MbE4bGTkR-zNVBLJbROU%22%2C%22provider%22%3A%22google_places%22%2C%22index%22%3A0%7D&pickup=%7B%22latitude%22%3A$_pickupLat%2C%22longitude%22%3A$_pickupLng%2C%22addressLine1%22%3A%22Jail%20Road%22%2C%22addressLine2%22%3A%22$_pickupAddressLine2%22%2C%22id%22%3A%22EjRKYWlsIFJkLCBCbG9jayBIIEd1bGJlcmcgMiwgTGFob3JlLCBQdW5qYWIsIFBha2lzdGFuIi4qLAoUChIJSS1TpeoEGTkR5jAiNXi0VFgSFAoSCc8qSr38BBk5EWk44xfJjxc6%22%2C%22provider%22%3A%22google_places%22%2C%22index%22%3A0%7D&vehicle=10285';
                      // } else {
                      //   _initialUrl =
                      //       'https://auth.uber.com/v2/?breeze_local_zone=dca11&next_url=https%3A%2F%2Fm.uber.com%2F&state=lSiz3gpn8PSJM6ZYM3A_UkG24kwaH8AtQ54vYuGaf4s%3D';
                      // }
                      // log(_initialUrl);
                      // var html = await getHtml(_initialUrl);
                      // if (html != null) {
                      //   final document = parse(html);
                      //   log(document.outerHtml.toString());
                      //   // log(document.innerHtml.toString());
                      //   List<dom.Element> listElements =
                      //       document.querySelectorAll('div > ul');
                      //   print(listElements);
                      //   debugger();
                      //   listItems = listElements
                      //       .where((element) =>
                                // !element.querySelectorAll('li > p').isNotEmpty)
                      //       .map((e) => e.text)
                      //       .toList();

                      //   print(listItems);
                      //   debugger();
                      // }
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
                                          return Dialog(
                                            // contentPadding: EdgeInsets.all(4),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(10),
                                                      topRight:
                                                          Radius.circular(10),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Text(
                                                          'Ola Rides',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 20),
                                                        ),
                                                      ),
                                                      IconButton(
                                                        icon: const Icon(
                                                          Icons.close,
                                                          size: 20,
                                                        ),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const Expanded(
                                                  child: WebView(
                                                    initialUrl:
                                                        'https://drive.olacabs.com/login',
                                                    javascriptMode:
                                                        JavascriptMode
                                                            .unrestricted,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        });
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
                                        color:
                                            Color.fromARGB(255, 137, 92, 146),
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
                    listItems.length > 1
                        ? Container()
                        : Row(
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
                                        padding:
                                            EdgeInsets.fromLTRB(15, 15, 0, 7.5),
                                        child: CircleAvatar(
                                          backgroundImage: AssetImage(
                                            'assets/images/uber_icon_full.png',
                                          ),
                                          radius: 17,
                                        ),
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(11, 10, 0, 0),
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
                                        color:
                                            Color.fromARGB(255, 218, 210, 231),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(13)),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Dialog(
                                                  // contentPadding: EdgeInsets.all(4),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    10),
                                                            topRight:
                                                                Radius.circular(
                                                                    10),
                                                          ),
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            const Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                'Uber Rides',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        20),
                                                              ),
                                                            ),
                                                            IconButton(
                                                              icon: const Icon(
                                                                Icons.close,
                                                                size: 20,
                                                              ),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const Expanded(
                                                        child: WebView(
                                                          initialUrl:
                                                              'https://auth.uber.com/v2/?breeze_local_zone=dca11&next_url=https%3A%2F%2Fm.uber.com%2F&state=lSiz3gpn8PSJM6ZYM3A_UkG24kwaH8AtQ54vYuGaf4s%3D',
                                                          javascriptMode:
                                                              JavascriptMode
                                                                  .unrestricted,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              });
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                              color: Color.fromARGB(
                                                  255, 137, 92, 146),
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
                  height: 12.5,
                  thickness: 0.5,
                  indent: 0,
                  endIndent: 0,
                  color: Colors.black,
                ),
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: listItems.length > 1
                          ? Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  for (var i = 1; i < listItems.length; i++)
                                    Row(
                                      children: [
                                        const CircleAvatar(
                                          backgroundImage: AssetImage(
                                            'assets/images/uber_icon_full.png',
                                          ),
                                          radius: 15,
                                        ),
                                        const SizedBox(width: 10),
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const uberWebView()));
                                                },
                                                child: Text(
                                                  listItems[i],
                                                  softWrap: true,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            )
                          : Column(
                              children: [
                                SizedBox(
                                  width: 100,
                                  height: 75,
                                  child: Image.asset(
                                      imagesList[_selectedContainer - 1]),
                                ),
                                const Text("No options available for now..."),
                              ],
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
bool isLoading = false;
  uberDataFetcher(){
    isLoading = true;
      _timer = Timer.periodic(const Duration(seconds: 5), (Timer t) async {
      final String content = await _getHtmlContent();
      _updateHtmlContent(content);
    setState(() {
      String? htmlContent = GlobalState.uberHTML;
  dom.Document document = parse(htmlContent!);
  List<dom.Element> listElements = document.querySelectorAll('div > ul > li');
  listItems = listElements
      .where((element) => !element.querySelectorAll('li > p').isNotEmpty)
      .map((e) => e.text)
      .toList();
    });
    if (listItems.length > 2) {
      _timer!.cancel();
       isLoading = false;
        // widget.panelController.close();
        widget.panelController.open();
    }else{
                  _webViewController.reload();

    }
    Future.delayed(const Duration(seconds: 10), () {
        setState(() {
          isLoading = false;
        });
      });
    });
  }

  uberHandler() {
    // debugger(); 
    if (pickUpController.text.isNotEmpty && destinationController.text.isNotEmpty) {
      _initialUrl =
          'https://m.uber.com/looking?drop%5B0%5D=%7B%22latitude%22%3A31.4661753%2C%22longitude%22%3A74.2657503%2C%22addressLine1%22%3A%22Emporium%20Mall%22%2C%22addressLine2%22%3A%2216M%20Abdul%20Haque%20Rd%2C%20Trade%20Centre%20Commercial%20Area%20Phase%202%20Johar%20Town%2C%20Lahore%2C%20Punjab%22%2C%22id%22%3A%22ChIJK_FA2dQDGTkRJlKdafaDjNs%22%2C%22provider%22%3A%22google_places%22%2C%22index%22%3A0%7D&pickup=%7B%22latitude%22%3A31.53229169999999%2C%22longitude%22%3A74.3528196%2C%22addressLine1%22%3A%22Jail%20Road%22%2C%22addressLine2%22%3A%22Jail%20Rd%2C%20Block%20H%20Gulberg%202%2C%20Lahore%2C%20Punjab%22%2C%22id%22%3A%22EjRKYWlsIFJkLCBCbG9jayBIIEd1bGJlcmcgMiwgTGFob3JlLCBQdW5qYWIsIFBha2lzdGFuIi4qLAoUChIJSS1TpeoEGTkR5jAiNXi0VFgSFAoSCc8qSr38BBk5EWk44xfJjxc6%22%2C%22provider%22%3A%22google_places%22%2C%22index%22%3A0%7D&vehicle=10285';
    return  SizedBox(
      height: 1,
      width: 1,
      child: WebView(            
         initialUrl: _initialUrl,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _webViewController = webViewController;
                // _reloadWebView();                 
              },
        // onPageStarted:  (String url) async {
        //   debugger();
        //   final String content = await _getHtmlContent();
        //   _updateHtmlContent(content);
        // },
        // onProgress: (progress) {
        //   log(progress.toString());
        // },
        onPageFinished: (String url) async {
          final String content = await _getHtmlContent();
          _updateHtmlContent(content);
          if (listItems.length < 3) {
             uberDataFetcher();            
          }
        },
       javascriptChannels: Set.from([
                JavascriptChannel(
                    name: 'internalChannel',
                    onMessageReceived: (JavascriptMessage message) {
                      _updateHtmlContent(message.message);
                    }),
              ]),
      ),
    );
  
    } 
    else {
     return Container();
    }
  }

  Future<String> _getHtmlContent() async {
    final String content =
        await _webViewController.evaluateJavascript('document.body.innerHTML');
    return content;
  }
  //  void _reloadWebView() {
  //   webViewController?.reload();
  // }

  void _updateHtmlContent(String newHtmlContent) {
    setState(() {
      _htmlContent = newHtmlContent;
      _htmlContent = _htmlContent.replaceAll("\\u003C", "<");
      if (_htmlContent != "" || _htmlContent != null) {
        GlobalState.uberHTML = _htmlContent;
        dom.Document document = parse(_htmlContent);
        List<dom.Element> listElements =
            document.querySelectorAll('div > ul > li');
        listItems = listElements
            .where((element) => !element.querySelectorAll('li > p').isNotEmpty)
            .map((e) => e.text)
            .toList();

        log(listItems.toString());

      }
    });
    log('Updated HTML content: $_htmlContent'.toString());
   
  }

    // List<String> listItems = [];


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



// class UberWebView extends StatefulWidget {
  

//   @override
//   State<UberWebView> createState() => _UberWebViewState();
// }

// class _UberWebViewState extends State<UberWebView> {

//  late WebViewController _webViewController;
//   String _htmlContent = '';
//     List<String> listItems = [];


//   // @override
//   // void dispose() {    
//   //   super.dispose();
//   //   _webViewController.clearCache();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     var url = "https://m.uber.com/looking?drop%5B0%5D=%7B%22latitude%22%3A${GlobalState.destinationLatLng!.latitude}%2C%22longitude%22%3A${GlobalState.destinationLatLng!.longitude}%2C%22addressLine1%22%3A%22Lakshmi%20Chowk%20Lahore%22%2C%22addressLine2%22%3A%22${GlobalState.destinationAddress}%22%2C%22id%22%3A%22ChIJ4a_MbE4bGTkR-zNVBLJbROU%22%2C%22provider%22%3A%22google_places%22%2C%22index%22%3A0%7D&pickup=%7B%22latitude%22%3A${GlobalState.pickUpLatLng!.latitude}%2C%22longitude%22%3A${GlobalState.pickUpLatLng!.longitude}%2C%22addressLine1%22%3A%22Jail%20Road%22%2C%22addressLine2%22%3A%22${GlobalState.pickUpAddress}%22%2C%22id%22%3A%22EjRKYWlsIFJkLCBCbG9jayBIIEd1bGJlcmcgMiwgTGFob3JlLCBQdW5qYWIsIFBha2lzdGFuIi4qLAoUChIJSS1TpeoEGTkR5jAiNXi0VFgSFAoSCc8qSr38BBk5EWk44xfJjxc6%22%2C%22provider%22%3A%22google_places%22%2C%22index%22%3A0%7D&vehicle=10285";
//     print("====================================================================");
//     // _webViewController.reload();
//     // _webViewController.clearCache();
//     return Column(children: [
//       //  if (GlobalState.pickUpAddress != null &&
//       //   GlobalState.destinationAddress != null) 
    
//     Container(
//       height: 0,
//       width: 0,
//       child: WebView(      
//         initialUrl: url,      
//         javascriptMode: JavascriptMode.unrestricted,
//         // onPageStarted:  (String url) async {
//         //   debugger();
//         //   print("--------------------------------------------------");
//         //   final String content = await _getHtmlContent();
//         //   _updateHtmlContent(content);
//         // },
//         onProgress: (progress) {
//           print("-------------------------------------------------- progress");

//           log(progress.toString());
//         },
//         onWebViewCreated: (WebViewController webViewController) {
//           print("-------------------------------------------------- created");

//           _webViewController = webViewController;
//           setState(() {
            
//           });
//           debugger();
//         },
//         onPageFinished: (String url) async {
//           final String content = await _getHtmlContent();
//           _updateHtmlContent(content);
//         },
//         javascriptChannels: {
//           JavascriptChannel(
//               name: 'internalChannel',
//               onMessageReceived: (JavascriptMessage message) {
//                 _updateHtmlContent(message.message);
//               }),
//         },
//       ),
//     )
//     ],);
//   }

//   Future<String> _getHtmlContent() async {
//     final String content =
//         await _webViewController.evaluateJavascript('document.body.innerHTML');
//     return content;
//   }

//   void _updateHtmlContent(String newHtmlContent) {
//     setState(() {
//       _htmlContent = newHtmlContent;
//       _htmlContent = _htmlContent.replaceAll("\\u003C", "<");
//       if (_htmlContent != "" || _htmlContent != null) {
//         GlobalState.uberHTML = _htmlContent;
//         dom.Document document = parse(_htmlContent);
//         List<dom.Element> listElements =
//             document.querySelectorAll('div > ul > li');
//         listItems = listElements
//             .where((element) => !element.querySelectorAll('li > p').isNotEmpty)
//             .map((e) => e.text)
//             .toList();

//         log(listItems.toString());

//         debugger();
//       }
//     });
//     log('Updated HTML content: $_htmlContent'.toString());
//   }
// }