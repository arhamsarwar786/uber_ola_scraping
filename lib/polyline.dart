import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:http/http.dart' as http;
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:uber_scrape/utils/panel_widget.dart';
import 'package:uber_scrape/utils/utils.dart';

import 'model/polyline_response.dart';

final pickUpController = TextEditingController();
final destinationController = TextEditingController();

List cars = [
  {'id': 0, 'name': 'Select a Ride', 'price': 0.0},
  {'id': 1, 'name': 'Uber Go', 'price': 230.0},
  {'id': 2, 'name': 'Go Sedan', 'price': 300.0},
  {'id': 3, 'name': 'Uber XL', 'price': 500.0},
  {'id': 4, 'name': 'Uber Auto', 'price': 140.0},
];

class PolylineScreen extends StatefulWidget {
  const PolylineScreen({Key? key}) : super(key: key);

  @override
  State<PolylineScreen> createState() => _PolylineScreenState();
}

class _PolylineScreenState extends State<PolylineScreen> {
   bool _isLocationGranted = false;
 
  var currentLocation;
  GoogleMapController? mapController;

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

  static const CameraPosition initialPosition =
      CameraPosition(target: LatLng(31.51110801, 74.27774), zoom: 14);

  final Completer<GoogleMapController> _controller = Completer();
  List<LatLng> latlng = [
    LatLng(31.528298548992247, 74.32748116149881),
    // LatLng(32.19690071242614, 74.188635025401),
    LatLng(31.475254327997412, 74.44234800837617),

    LatLng(31.528298548992247, 74.32748116149881),
  ];
  final List<Marker> _marker = [];
  final List<Marker> _list = [
    const Marker(
        markerId: MarkerId('1'),
        position: LatLng(31.567423512473322, 74.32512929704535),
        infoWindow: InfoWindow(title: "My position")),
    const Marker(
        markerId: MarkerId('2'),
        position: LatLng(31.53232941929845, 74.3528337150464),)
   
  ];
  final panelController = PanelController();

  String totalDistance = "";
  String totalTime = "";

  String apiKey = kGoogleApiKey;

  LatLng origin = const LatLng(31.567423512473322, 74.32512929704535);
  LatLng destination = const LatLng(31.53232941929845, 74.3528337150464);

  PolylineResponse polylineResponse = PolylineResponse();

  Set<Polyline> polylinePoints = {};
  List<LatLng> points = [
    LatLng(31.567423512473322, 74.32512929704535),
    LatLng(31.53232941929845, 74.3528337150464),
  ];

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    drawPolyline();
    for (var i = 0; i < points.length; i++) {
    _marker.add(
  Marker(markerId: MarkerId(i.toString()),position: points[i],infoWindow: InfoWindow(title: 'Really cool place',snippet: '5 star rating'),icon: BitmapDescriptor.defaultMarker),
);setState(() {
  
});    
      
    }
    //getCurrentLocation();
  }

  Widget build(BuildContext context) {
    final panelHeightClosed = MediaQuery.of(context).size.height * 0.225;
    final panelHeightOpen = MediaQuery.of(context).size.height;

    return SafeArea(
        child: Scaffold(
            body: SlidingUpPanel(
      controller: panelController,
      minHeight: panelHeightClosed,
      maxHeight: panelHeightOpen,
      body: Column(children: [
        Expanded(
          child: GoogleMap(
            zoomControlsEnabled: true,
            //  polygons: _polygone,
            polylines: polylinePoints,
            markers: Set<Marker>.of(_marker),
            myLocationEnabled: true,
            compassEnabled: true,
            mapType: MapType.normal,
            initialCameraPosition: initialPosition,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),

//
        ),
        
      ]),
      panelBuilder: (controller) => PanelWidget(
        controller: controller,
        panelController: panelController,
      ),
    )));

    // Container(
    //   margin: const EdgeInsets.all(20),
    //   padding: const EdgeInsets.all(20),
    //   color: Colors.white,
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     mainAxisSize: MainAxisSize.min,
    //     children: [
    //       Text("Total Distance: " + totalDistance),
    //       Text("Total Time: " + totalTime),
    //     ],
    //   ),
    // );
  }

  void drawPolyline() async {
    var response = await http.post(Uri.parse(
        "https://maps.googleapis.com/maps/api/directions/json?key=" +
            apiKey +
            "&units=metric&origin=" +
            origin.latitude.toString() +
            "," +
            origin.longitude.toString() +
            "&destination=" +
            destination.latitude.toString() +
            "," +
            destination.longitude.toString() +
            "&mode=driving"));

    print(response.body);

    polylineResponse = PolylineResponse.fromJson(jsonDecode(response.body));

    totalDistance = polylineResponse.routes![0].legs![0].distance!.text!;
    totalTime = polylineResponse.routes![0].legs![0].duration!.text!;

    for (int i = 0;
        i < polylineResponse.routes![0].legs![0].steps!.length;
        i++) {
      polylinePoints.add(Polyline(
          polylineId: PolylineId(
              polylineResponse.routes![0].legs![0].steps![i].polyline!.points!),
          points: [
            LatLng(
                polylineResponse
                    .routes![0].legs![0].steps![i].startLocation!.lat!,
                polylineResponse
                    .routes![0].legs![0].steps![i].startLocation!.lng!),
            LatLng(
                polylineResponse
                    .routes![0].legs![0].steps![i].endLocation!.lat!,
                polylineResponse
                    .routes![0].legs![0].steps![i].endLocation!.lng!),
          ],
          width: 3,
          color: Colors.red));
    }

    setState(() {});
  }
}
