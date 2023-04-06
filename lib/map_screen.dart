// ignore_for_file: unused_local_variable, unused_field, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:uber_scrape/utils/gloablState.dart';
// import 'package:uber_scrape/polygon.dart';
// import 'package:uber_scrape/fare_screen.dart';
// import 'package:uber_scrape/ola_webview.dart';
// import 'package:uber_scrape/search_handler.dart';
// import 'package:uber_scrape/uber_webview.dart';
// import 'package:uber_scrape/utils/gloablState.dart';
import 'package:uber_scrape/utils/panel_widget.dart';
import 'package:uber_scrape/utils/utils.dart';
// import 'package:uber_scrape/widgets.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:geocoding/geocoding.dart';

final pickUpController = TextEditingController();
final destinationController = TextEditingController();

List cars = [
  {'id': 0, 'name': 'Select a Ride', 'price': 0.0},
  {'id': 1, 'name': 'Uber Go', 'price': 230.0},
  {'id': 2, 'name': 'Go Sedan', 'price': 300.0},
  {'id': 3, 'name': 'Uber XL', 'price': 500.0},
  {'id': 4, 'name': 'Uber Auto', 'price': 140.0},
];

// List<LatLng> polylineCoordinates = [
//     const LatLng(31.567450936169315, 74.3251400258807),
//     const LatLng(31.53237971497983, 74.35280689295801),
//     const LatLng(31.567450936169315, 74.3251400258807),
//     const LatLng(31.53237971497983, 74.35280689295801),
//   ];

// This page shows a Google Map plugin with all stations (HvD and Total). The markers are pulled from a Firebase database.

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

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
   PolylinePoints polylinePoints = PolylinePoints();

  String googleAPiKey = kGoogleApiKey;

  // Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

// Below function initiates all HvD stations and shows them as markers on the map. It also generates a Bottom Sheet for each location with corresponding information.

  // void initMarkerHvD(specify, specifyId) async {
  //   var markerIdVal = specifyId;
  //   // final Uint8List markerHvD =
  //   //     await getBytesFromAsset('images/Pin-HvD.JPG', 70);
  //   final MarkerId markerId = MarkerId(markerIdVal);
  //   final Marker marker = Marker(
  //     markerId: markerId,
  //     onTap: () {
  //       showModalBottomSheet(
  //           context: context,
  //           builder: (context) => SingleChildScrollView(
  //                 child: Container(
  //                   padding: EdgeInsets.only(
  //                       bottom: MediaQuery.of(context).viewInsets.bottom),
  //                   child: Container(
  //                     color: const Color(0xff757575),
  //                     child: Container(
  //                       padding: const EdgeInsets.all(20.0),
  //                       decoration: const BoxDecoration(
  //                           color: Colors.white,
  //                           borderRadius: BorderRadius.only(
  //                               topLeft: Radius.circular(20.0),
  //                               topRight: Radius.circular(20.0))),
  //                       child: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.stretch,
  //                         children: [
  //                          // MyMap(),
  //                           //TestMapPolyline(),
  //                           Text(
  //                             specify['stationName'],
  //                             style: const TextStyle(
  //                                 // color: PaletteBlue.hvdblue,
  //                                 fontWeight: FontWeight.bold,
  //                                 fontSize: 16),
  //                             textAlign: TextAlign.center,
  //                           ),
  //                           const SizedBox(height: 10),
  //                           Text(specify['stationAddress']),
  //                           Text(specify['stationZIP'] +
  //                               ' ' +
  //                               specify['stationCity']),
  //                           const SizedBox(height: 20),
  //                           ElevatedButton(
  //                               child: const Text(
  //                                 'Navigeer naar locatie',
  //                                 style: TextStyle(
  //                                   color: Colors.white,
  //                                 ),
  //                               ),
  //                               onPressed: () {
  //                                 // MapUtils.openMap(
  //                                 //     specify['stationLocation'].latitude,
  //                                 //     specify['stationLocation'].longitude);
  //                               }),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ));
  //     },
  //     position: LatLng(specify['stationLocation'].latitude,
  //         specify['stationLocation'].longitude),
  //     infoWindow: const InfoWindow(),
  //     // icon: BitmapDescriptor.fromBytes(markerHvD),
  //   );
  //   setState(() {
  //     markers[markerId] = marker;
  //   });
  // }

// Below function initiates all Total stations and shows them as markers on the map. It also generates a Bottom Sheet for each location with corresponding information.

  // void initMarkerTotal(specify, specifyId) async {
  //   var markerIdVal = specifyId;
  //   // final Uint8List markerTotal =
  //   //     await getBytesFromAsset('images/Pin-Total.JPG', 70);
  //   final MarkerId markerId = MarkerId(markerIdVal);
  //   final Marker marker = Marker(
  //     markerId: markerId,
  //     onTap: () {
  //       showModalBottomSheet(
  //           context: context,
  //           builder: (context) => SingleChildScrollView(
  //                 child: Container(
  //                   padding: EdgeInsets.only(
  //                       bottom: MediaQuery.of(context).viewInsets.bottom),
  //                   child: Container(
  //                     color: const Color(0xff757575),
  //                     child: Container(
  //                       padding: const EdgeInsets.all(20.0),
  //                       decoration: const BoxDecoration(
  //                           color: Colors.white,
  //                           borderRadius: BorderRadius.only(
  //                               topLeft: Radius.circular(20.0),
  //                               topRight: Radius.circular(20.0))),
  //                       child: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.stretch,
  //                         children: [
  //                           Text(
  //                             specify['stationName'],
  //                             style: const TextStyle(
  //                                 // color: PaletteBlue.hvdblue,
  //                                 fontWeight: FontWeight.bold,
  //                                 fontSize: 16),
  //                             textAlign: TextAlign.center,
  //                           ),
  //                           const SizedBox(height: 10),
  //                           Text(specify['stationAddress']),
  //                           Text(specify['stationZIP'] +
  //                               ' ' +
  //                               specify['stationCity']),
  //                           const SizedBox(height: 20),
  //                           ElevatedButton(
  //                               child: const Text(
  //                                 'Navigeer naar locatie',
  //                                 style: TextStyle(
  //                                   color: Colors.white,
  //                                 ),
  //                               ),
  //                               onPressed: () {
  //                                 // MapUtils.openMap(
  //                                 //     specify['stationLocation'].latitude,
  //                                 //     specify['stationLocation'].longitude);
  //                               }),
                                
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ));
  //     },
  //     position: LatLng(specify['stationLocation'].latitude,
  //         specify['stationLocation'].longitude),
  //     infoWindow: const InfoWindow(),
  //     // icon: BitmapDescriptor.fromBytes(markerTotal),
  //   );
  //   setState(() {
  //     markers[markerId] = marker;
  //   });
  // }

// Below function initiates all previous functions on the page. This happens when the user navigates to the page.
  // Set<Polygon> _polygons = {};

  // @override
  // void initState() {
  //   super.initState();
  //   getCurrentLocation();
  // }

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
  // Set<Marker> markers = Set(); //markers for google map
  Map<PolylineId, Polyline> polylines = {}; //polylines to show direction

  // LatLng startLocation = LatLng(31.567565948234733, 74.32517348348192);
  // LatLng endLocation = LatLng(31.539356089917025, 74.33581876733875);

  // @override
  // void initState() {

  //    markers.add(Marker( //add start location marker
  //       markerId: MarkerId(startLocation.toString()),
  //       position: startLocation, //position of marker
  //       infoWindow: const InfoWindow( //popup info 
  //         title: 'Starting Point ',
  //         snippet: 'Start Marker',
  //       ),
  //       icon: BitmapDescriptor.defaultMarker, //Icon for Marker
  //     ));

  //     markers.add(Marker( //add distination location marker
  //       markerId: MarkerId(endLocation.toString()),
  //       position: endLocation, //position of marker
  //       infoWindow: const InfoWindow( //popup info 
  //         title: 'Destination Point ',
  //         snippet: 'Destination Marker',
  //       ),
  //       icon: BitmapDescriptor.defaultMarker, //Icon for Marker
  //     ));
      
  //     getDirections(); //fetch direction polylines from Google API
  //     getCurrentLocation();
  //   super.initState();
  // }

  // getDirections() async {
  //     List<LatLng> polylineCoordinates = [];
     
  //     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //         googleAPiKey,
  //         PointLatLng(startLocation.latitude, startLocation.longitude),
  //         PointLatLng(endLocation.latitude, endLocation.longitude),
  //         travelMode: TravelMode.driving,
  //     );

  //     if (result.points.isNotEmpty) {
  //           result.points.forEach((PointLatLng point) {
  //               polylineCoordinates.add(LatLng(point.latitude, point.longitude));
  //           });
  //     } else {
  //        print(result.errorMessage);
  //     }
  //     addPolyLine(polylineCoordinates);
  // }

addPolyLine(List<LatLng> polylineCoordinates) {
    // String polylineIdVal = "${GlobalState.pickUpLatLng!.latitude},${GlobalState.pickUpLatLng!.longitude}-${GlobalState.destinationLatLng!.latitude},${GlobalState.destinationLatLng!.longitude}";
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.deepPurpleAccent,
      points: polylineCoordinates,
      width: 4,
    );
    polylines[id] = polyline;
    setState(() {});
  }

      List<Marker> markers = [];

  LatLng? startLocation = GlobalState.pickUpLatLng;
  LatLng? endLocation = GlobalState.destinationLatLng;

  //   getDirections() async {
  //     List<LatLng> polylineCoordinates = [];
     
  //     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //         googleAPiKey,
  //         PointLatLng(startLocation.latitude, startLocation.longitude),
  //         PointLatLng(endLocation.latitude, endLocation.longitude),
  //         travelMode: TravelMode.driving,
  //     );

  //     if (result.points.isNotEmpty) {
  //           result.points.forEach((PointLatLng point) {
  //               polylineCoordinates.add(LatLng(point.latitude, point.longitude));
  //           });
  //     } else {
  //        print(result.errorMessage);
  //     }
  //     addPolyLine(polylineCoordinates);
  // }

    @override
  void initState() {

    markers.add(Marker(
      markerId: const MarkerId('start'),
      position: startLocation ?? const LatLng(0, 0),
      infoWindow: const InfoWindow(
        title: 'Starting Point',
        snippet: 'Start Marker',
      ),
      icon: BitmapDescriptor.defaultMarker,
    ));

    markers.add(Marker(
      markerId: const MarkerId('end'),
      position: endLocation ?? const LatLng(0, 0),
      infoWindow: const InfoWindow(
        title: 'Destination Point',
        snippet: 'Destination Marker',
      ),
      icon: BitmapDescriptor.defaultMarker,
    ));

    // getDirections();
    getCurrentLocation();
    super.initState();
  }




  @override
  Widget build(BuildContext context) {


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
                initialCameraPosition: const CameraPosition(
              
          target: LatLng(37.785419, -122.404164),
          zoom: 14,
                ),
                  onMapCreated: onMapCreated,
                  markers: markers.toSet(), //markers to show on map
                    polylines: Set<Polyline>.of(polylines.values), //polylines
                    mapType: MapType.normal, 
                  
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 1/3.4,
                ),
              
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

  onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
}
