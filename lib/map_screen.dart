import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_scrape/fare_screen.dart';
import 'package:uber_scrape/search_handler.dart';
import 'package:uber_scrape/utils/gloablState.dart';
import 'package:uber_scrape/utils/utils.dart';
import 'package:uber_scrape/widgets.dart';

final pickUpController = TextEditingController();
final destinationController = TextEditingController();

// This page shows a Google Map plugin with all stations (HvD and Total). The markers are pulled from a Firebase database.

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MapView createState() => _MapView();
}

class _MapView extends State<MapView> {
  bool _isLocationGranted = false;

  // ignore: prefer_typing_uninitialized_variables
  var currentLocation;

  GoogleMapController? mapController;

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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: onMapCreated,
            markers: Set<Marker>.of(markers.values),
            // ignore: prefer_collection_literals
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
              Factory<OneSequenceGestureRecognizer>(
                () => EagerGestureRecognizer(),
              ),
            ].toSet(),
            mapToolbarEnabled: false,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: false,
            scrollGesturesEnabled: true,
            myLocationEnabled: _isLocationGranted,
            myLocationButtonEnabled: true,
            initialCameraPosition: _initialCameraPosition,
          ),
          Positioned(bottom: 0, child: locationPicker(context, size)),
        ],
      ),
    );
  }

  locationPicker(context, size) {
    return Container(
      height: 190,
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      color: Colors.white,
      width: size.width,
      child: Column(
        children: [
          InkWell(
            onTap: () {
              handlePressButton(context, 'pickUp');
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
          // const SizedBox(
          //   height: 15,
          // ),
          const Spacer(),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    width: 60,
                    height: 60,
                    color: Colors.purple[700],
                    child: const Icon(
                      Icons.home_sharp,
                      size: 30.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  width: 110,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(
                      width: 1,
                      color: Colors.grey,
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
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Ola",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  width: 110,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(
                      width: 1,
                      color: Colors.grey,
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
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Uber",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // ElevatedButton.icon(
          //   icon: const Icon(Icons.car_repair_outlined),
          //   onPressed: () {
          //     if (GlobalState.pickUpLatLng == null) {
          //       snackBar(context, "Please! Enter PickUp Address");
          //     } else if (GlobalState.destinationLatLng == null) {
          //       snackBar(context, "Please! Enter Destination Address");
          //     } else {
          //       // snackBar(context, 'HIT');
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) => FareScreen(
          //                   pickUp: GlobalState.pickUpLatLng,
          //                   destination: GlobalState.destinationLatLng)));
          //     }
          //   },
          //   // style: ElevatedButton.styleFrom(
          //   //   primary: Colors.black, // Background color
          //   // ),
          //   label: const Text(
          //     "Check Drive",
          //     // style: TextStyle(fontSize: 15),
          //   ),
          //   style: ButtonStyle(
          //       shape: MaterialStateProperty.all(const RoundedRectangleBorder(
          //     borderRadius: BorderRadius.all(Radius.circular(10)),
          //   ))),
          // ),
        ],
      ),
    );
  }

  onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
}
