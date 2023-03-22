import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_scrape/polygon.dart';
// import 'package:uber_scrape/fare_screen.dart';
// import 'package:uber_scrape/ola_webview.dart';
// import 'package:uber_scrape/search_handler.dart';
// import 'package:uber_scrape/uber_webview.dart';
// import 'package:uber_scrape/utils/gloablState.dart';
import 'package:uber_scrape/utils/panel_widget.dart';
import 'package:uber_scrape/utils/utils.dart';
// import 'package:uber_scrape/widgets.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

final pickUpController = TextEditingController();
final destinationController = TextEditingController();

List cars = [
  {'id': 0, 'name': 'Select a Ride', 'price': 0.0},
  {'id': 1, 'name': 'Uber Go', 'price': 230.0},
  {'id': 2, 'name': 'Go Sedan', 'price': 300.0},
  {'id': 3, 'name': 'Uber XL', 'price': 500.0},
  {'id': 4, 'name': 'Uber Auto', 'price': 140.0},
];
// List<LatLng> polygonLatLngs = [  LatLng(37.785419, -122.404164),  LatLng(37.787810, -122.403866),  LatLng(37.789327, -122.408751),  LatLng(37.787080, -122.410427),  LatLng(37.785419, -122.404164)];
// Polygon polygon = Polygon(
//   polygonId: PolygonId('myPolygon'),
//   points: polygonLatLngs,
//   strokeWidth: 2,
//   strokeColor: Colors.red,
//   fillColor: Colors.transparent,
// );
// Set<Polygon> myPolygons = Set<Polygon>();
 //Polygons.add(polygon);
// GoogleMap(
//   polygons: myPolygons,
//   initialCameraPosition: CameraPosition(target: LatLng(37.78825, -122.4324), zoom: 12),
// );


// This page shows a Google Map plugin with all stations (HvD and Total). The markers are pulled from a Firebase database.

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MapView createState() => _MapView();
}

class _MapView extends State<MapView> {
  bool _isLocationGranted = false;
 int activeContainerIndex = -1;

  // ignore: prefer_typing_uninitialized_variables
  var currentLocation;

  GoogleMapController? mapController;
  GoogleMapController? _controller;
  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

// Below function initiates all HvD stations and shows them as markers on the map. It also generates a Bottom Sheet for each location with corresponding information.

  void initMarkerHvD(specify, specifyId) async {
    var markerIdVal = specifyId;
    // final Uint8List markerHvD =
    //     await getBytesFromAsset('images/Pin-HvD.JPG', 70);
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      markerId: markerId,
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (context) => SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Container(
                      color: const Color(0xff757575),
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                           // MyMap(),
                            //TestMapPolyline(),
                            Text(
                              specify['stationName'],
                              style: const TextStyle(
                                  // color: PaletteBlue.hvdblue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Text(specify['stationAddress']),
                            Text(specify['stationZIP'] +
                                ' ' +
                                specify['stationCity']),
                            const SizedBox(height: 20),
                            ElevatedButton(
                                child: const Text(
                                  'Navigeer naar locatie',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () {
                                  // MapUtils.openMap(
                                  //     specify['stationLocation'].latitude,
                                  //     specify['stationLocation'].longitude);
                                }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ));
      },
      position: LatLng(specify['stationLocation'].latitude,
          specify['stationLocation'].longitude),
      infoWindow: const InfoWindow(),
      // icon: BitmapDescriptor.fromBytes(markerHvD),
    );
    setState(() {
      markers[markerId] = marker;
    });
  }

// Below function initiates all Total stations and shows them as markers on the map. It also generates a Bottom Sheet for each location with corresponding information.

  void initMarkerTotal(specify, specifyId) async {
    var markerIdVal = specifyId;
    // final Uint8List markerTotal =
    //     await getBytesFromAsset('images/Pin-Total.JPG', 70);
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      markerId: markerId,
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (context) => SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Container(
                      color: const Color(0xff757575),
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              specify['stationName'],
                              style: const TextStyle(
                                  // color: PaletteBlue.hvdblue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Text(specify['stationAddress']),
                            Text(specify['stationZIP'] +
                                ' ' +
                                specify['stationCity']),
                            const SizedBox(height: 20),
                            ElevatedButton(
                                child: const Text(
                                  'Navigeer naar locatie',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () {
                                  // MapUtils.openMap(
                                  //     specify['stationLocation'].latitude,
                                  //     specify['stationLocation'].longitude);
                                }),
                                
                          ],
                        ),
                      ),
                    ),
                  ),
                ));
      },
      position: LatLng(specify['stationLocation'].latitude,
          specify['stationLocation'].longitude),
      infoWindow: const InfoWindow(),
      // icon: BitmapDescriptor.fromBytes(markerTotal),
    );
    setState(() {
      markers[markerId] = marker;
    });
  }

// Below function initiates all previous functions on the page. This happens when the user navigates to the page.
  Set<Polygon> _polygons = {};

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  getCurrentLocation() async {
    var location = await fetchLocation();
    if (location == null) {
      setState(() {
        currentLocation = const LatLng(37.8199286, -122.4782551);
        _isLocationGranted = true;
      });
      mapController!.moveCamera(
              CameraUpdate.newLatLng(const LatLng(37.8199286, -122.4782551)))
          as CameraPosition;
    } else {
      setState(() {
        currentLocation = location;
        _isLocationGranted = true;
      });
      mapController!.moveCamera(CameraUpdate.newLatLng(
              LatLng(currentLocation.latitude, currentLocation.longitude)))
          as CameraPosition;
    }
  }

  final CameraPosition _initialCameraPosition =
      const CameraPosition(target: LatLng(51.9244201, 4.4777325), zoom: 12);
  final panelController = PanelController();

  @override
  Widget build(BuildContext context) {
      final LatLngBounds bounds = LatLngBounds(
      southwest: const LatLng(37.785419, -122.404164),
      northeast: const LatLng(37.789327, -122.403866),
    );
    final Polygon polygon = Polygon(
      polygonId: const PolygonId('myPolygon'),
      points: <LatLng>[
        const LatLng(37.785419, -122.404164),
        const LatLng(37.787810, -122.403866),
        const LatLng(37.789327, -122.408751),
        const LatLng(37.787080, -122.410427),
        const LatLng(37.785419, -122.404164),
      ],
      strokeWidth: 2,
      strokeColor: Colors.blue,
      fillColor: Colors.red,
    );

    _polygons.add(polygon);

    final panelHeightClosed = MediaQuery.of(context).size.height * 0.225;
    final panelHeightOpen = MediaQuery.of(context).size.height;
    // Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SlidingUpPanel(
          controller: panelController,
          minHeight: panelHeightClosed,
          maxHeight: panelHeightOpen,
          body: Column(
            children: [
             
              Expanded(
                child: GoogleMap(
rotateGesturesEnabled:true,
      
               

   
                   minMaxZoomPreference: MinMaxZoomPreference.unbounded,
                 polygons: _polygons,
                initialCameraPosition: CameraPosition(
              
          target: LatLng(37.785419, -122.404164),
          zoom: 14,
                ),
                  onMapCreated: onMapCreated, 
                  markers: Set<Marker>.of(markers.values),
                  // ignore: prefer_collection_literals
                  gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
                    Factory<OneSequenceGestureRecognizer>(
                      () => EagerGestureRecognizer(),
                    ),
                  ].toSet(),
                  
                  mapToolbarEnabled: true,
                  zoomGesturesEnabled: true,
                  zoomControlsEnabled: true,
                  scrollGesturesEnabled: true,
                  myLocationEnabled: _isLocationGranted,
                  myLocationButtonEnabled: true,
                  //initialCameraPosition: _initialCameraPosition,
                ),
              ),
              Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 
                ElevatedButton(
                  onPressed: () {
                    if (_controller != null) {
                      _controller!.animateCamera(
                        CameraUpdate.zoomIn(),
                      );
                    }
                  },
                  child: const Icon(Icons.add),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_controller != null) {
                      _controller!.animateCamera(
                        CameraUpdate.zoomOut(),
                      );
                    }
                  },
                  child: const Icon(Icons.remove),
                ),//map3333
              
              ],
            ),
          ),
            ],
          ),
          
          panelBuilder: (controller) => PanelWidget(
            controller: controller,
            panelController: panelController,
          ),
        ),

        

        // ignore: avoid_unnecessary_containers
       ),
    );
  }

 

  // locationPicker(context, size) {
  //   return Container(
  //     height: 190,
  //     padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
  //     color: Colors.white,
  //     width: size.width,
  //     child: Column(
  //       children: [
  //         InkWell(
  //           onTap: () {
  //             handlePressButton(context, 'pickUp');
  //             // Navigator.push(context, MaterialPageRoute(builder: (_)=> SearchScreen('Pick Up') ));
  //           },
  //           child: Padding(
  //             padding: const EdgeInsets.fromLTRB(7, 10, 15, 0),
  //             child: TextField(
  //               style: const TextStyle(fontSize: 16),
  //               controller: pickUpController,
  //               enabled: false,
  //               decoration: const InputDecoration(
  //                   icon: Icon(
  //                     Icons.accessibility_new,
  //                     color: Colors.black,
  //                   ),
  //                   hintText: "Pick Up",
  //                   border: InputBorder.none),
  //             ),
  //           ),
  //         ),
  //         Row(
  //           children: [
  //             const Padding(
  //               padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
  //               child: SizedBox(
  //                 height: 20,
  //                 child: VerticalDivider(
  //                   color: Colors.grey,
  //                   thickness: 2.5,
  //                 ),
  //               ),
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
  //               child: Container(
  //                 width: MediaQuery.of(context).size.width * 0.83,
  //                 decoration: BoxDecoration(
  //                   border: Border.all(
  //                     width: 0.5,
  //                     color: Colors.grey,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //         InkWell(
  //           onTap: () {
  //             // Navigator.push(context, MaterialPageRoute(builder: (_)=> SearchScreen('Destination') ));
  //             handlePressButton(context, 'destination');
  //           },
  //           child: Padding(
  //             padding: const EdgeInsets.fromLTRB(7, 0, 15, 0),
  //             child: TextField(
  //               style: const TextStyle(fontSize: 16),
  //               controller: destinationController,
  //               enabled: false,
  //               decoration: const InputDecoration(
  //                   icon: Icon(
  //                     Icons.fmd_good_sharp,
  //                     color: Colors.red,
  //                   ),
  //                   hintText: "Destination",
  //                   border: InputBorder.none),
  //             ),
  //           ),
  //         ),
  //         // const SizedBox(
  //         //   height: 15,
  //         // ),
  //         const Spacer(),

  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           children: [
  //             InkWell(
  //               onTap: () {
  //                 setState(() {
  //                   Navigator.push(
  //                     context,
  //                     MaterialPageRoute(builder: (context) => const MapView()),
  //                   );

  //                   if (click2 != click) {
  //                     click = !click;
  //                   } else if (click1 != click) {
  //                     click = !click;
  //                   }
  //                 });
  //               },
  //               child: Padding(
  //                 padding: const EdgeInsets.all(0.0),
  //                 child: Container(
  //                     width: 60,
  //                     height: 60,
  //                     decoration: BoxDecoration(
  //                       color: (click == false)
  //                           ? Colors.white
  //                           : Colors.purple[900],
  //                       borderRadius: BorderRadius.circular(0),
  //                       border: Border.all(
  //                         width: 1,
  //                         color: (click == false)
  //                             ? Colors.grey
  //                             : Colors.purple.shade900,
  //                       ),
  //                     ),

  //                     // color: Colors.purple[900],
  //                     child: Icon(
  //                       (click == false) ? Icons.home_sharp : Icons.home_sharp,
  //                       size: 35,
  //                       color: (click == false) ? Colors.black : Colors.white,
  //                     )
  //                     // child:  const Icon(
  //                     //   Icons.home_sharp,
  //                     //   size: 30.0,
  //                     //   color: Colors.white,
  //                     // ),
  //                     ),
  //               ),
  //             ),
  //             InkWell(
  //               onTap: () {
  //                 Navigator.push(context,
  //                     MaterialPageRoute(builder: ((context) => olaWebView())));
  //                 setState(() {
  //                   if (click1 != click) {
  //                     click1 = !click1;
  //                   } else if (click1 != click2) {
  //                     click1 = !click1;
  //                   }
  //                 });
  //               },
  //               child: Container(
  //                 width: 110,
  //                 height: 60,
  //                 decoration: BoxDecoration(
  //                   color:
  //                       (click1 == false) ? Colors.white : Colors.purple[900],
  //                   borderRadius: BorderRadius.circular(3),
  //                   border: Border.all(
  //                     width: 1,
  //                     color: (click1 == false)
  //                         ? Colors.grey
  //                         : Colors.purple.shade900,
  //                   ),
  //                 ),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   // ignore: prefer_const_literals_to_create_immutables
  //                   children: [
  //                     const Padding(
  //                       padding: EdgeInsets.fromLTRB(15, 10, 0, 7.5),
  //                       child: CircleAvatar(
  //                         backgroundImage: AssetImage(
  //                           'assets/images/ola_icon_full.png',
  //                         ),
  //                         radius: 15,
  //                       ),
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.all(8.0),
  //                       child: Text(
  //                         "Ola",
  //                         style: TextStyle(
  //                             color: (click1 == false)
  //                                 ? Colors.black
  //                                 : Colors.white,
  //                             fontSize: 17,
  //                             fontWeight: FontWeight.bold),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //             InkWell(
  //               onTap: () {
  //                 setState(() {
  //                   if (click2 != click) {
  //                     click2 = !click2;
  //                   } else if (click2 != click1) {
  //                     click2 = !click2;
  //                   }
  //                 });
  //               },
  //               child: Container(
  //                 width: 110,
  //                 height: 60,
  //                 decoration: BoxDecoration(
  //                   color:
  //                       (click2 == false) ? Colors.white : Colors.purple[900],
  //                   borderRadius: BorderRadius.circular(3),
  //                   border: Border.all(
  //                     width: 1,
  //                     color: (click2 == false)
  //                         ? Colors.grey
  //                         : Colors.purple.shade900,
  //                   ),
  //                 ),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   // ignore: prefer_const_literals_to_create_immutables
  //                   children: [
  //                     const Padding(
  //                       padding: EdgeInsets.fromLTRB(15, 10, 0, 7.5),
  //                       child: CircleAvatar(
  //                         backgroundImage: AssetImage(
  //                           'assets/images/uber_icon_full.png',
  //                         ),
  //                         radius: 15,
  //                       ),
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.all(8.0),
  //                       child: Text(
  //                         "Uber",
  //                         style: TextStyle(
  //                             color: (click2 == false)
  //                                 ? Colors.black
  //                                 : Colors.white,
  //                             fontSize: 17,
  //                             fontWeight: FontWeight.bold),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),

  //         // ElevatedButton.icon(
  //         //   icon: const Icon(Icons.car_repair_outlined),
  //         //   onPressed: () {
  //         //     if (GlobalState.pickUpLatLng == null) {
  //         //       snackBar(context, "Please! Enter PickUp Address");
  //         //     } else if (GlobalState.destinationLatLng == null) {
  //         //       snackBar(context, "Please! Enter Destination Address");
  //         //     } else {
  //         //       // snackBar(context, 'HIT');
  //         //       Navigator.push(
  //         //           context,
  //         //           MaterialPageRoute(
  //         //               builder: (context) => FareScreen(
  //         //                   pickUp: GlobalState.pickUpLatLng,
  //         //                   destination: GlobalState.destinationLatLng)));
  //         //     }
  //         //   },
  //         //   // style: ElevatedButton.styleFrom(
  //         //   //   primary: Colors.black, // Background color
  //         //   // ),
  //         //   label: const Text(
  //         //     "Check Drive",
  //         //     // style: TextStyle(fontSize: 15),
  //         //   ),
  //         //   style: ButtonStyle(
  //         //       shape: MaterialStateProperty.all(const RoundedRectangleBorder(
  //         //     borderRadius: BorderRadius.all(Radius.circular(10)),
  //         //   ))),
  //         // ),
  //       ],
  //     ),
  //   );
  // }

  onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
}
