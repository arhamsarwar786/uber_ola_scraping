import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/gestures.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_scrape/map_screen.dart';
// import 'package:uber_scrape/fare_screen.dart';
import 'package:uber_scrape/search_handler.dart';
import 'package:uber_scrape/search_screen.dart';
// import 'package:uber_scrape/utils/gloablState.dart';
import 'package:uber_scrape/utils/utils.dart';
// import 'package:uber_scrape/widgets.dart';

// final pickUpController = TextEditingController();
// final destinationController = TextEditingController();

// This page shows a Google Map plugin with all stations (HvD and Total). The markers are pulled from a Firebase database.

class DynamicBottomSheet extends StatefulWidget {
  const DynamicBottomSheet({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DynamicBottomSheet createState() => _DynamicBottomSheet();
}

class _DynamicBottomSheet extends State<DynamicBottomSheet> {
  // ignore: unused_field
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

  // ignore: unused_field
  final CameraPosition _initialCameraPosition =
      const CameraPosition(target: LatLng(51.9244201, 4.4777325), zoom: 12);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: locationPicker(context, size),
    );
  }

  locationPicker(context, size) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      color: Colors.white,
      child: Column(
        children: [
          InkWell(
            onTap: () {
              handlePressButton(context, 'pickUp');
              Navigator.push(context, MaterialPageRoute(builder: (_)=> const SearchScreen('Pick Up') ));
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
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 24, 8, 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  child: Container(
                    width: 70,
                    height: 45,
                    decoration: BoxDecoration(
                      // color: Colors.amber,
                      image: const DecorationImage(
                        image: AssetImage('assets/images/bike.png'),
                        fit: BoxFit.fill,
                      ),
                      // color: Colors.purple,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: .5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      border: Border.all(
                        color: Colors.grey,
                        width: 0.05,
                      ),
                      borderRadius: BorderRadius.circular(17.5),
                    ),
                  ),
                  onTap: () {
                    // ignore: avoid_print
                    print("Container is Tapped");
                  },
                ),
                InkWell(
                  child: Container(
                    width: 70,
                    height: 45,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('assets/images/auto_rikshaw.png'),
                        fit: BoxFit.fill,
                      ),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: .5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      border: Border.all(
                        color: Colors.grey,
                        width: 0.05,
                      ),
                      borderRadius: BorderRadius.circular(17.5),
                    ),
                  ),
                  onTap: () {},
                ),
                InkWell(
                  child: Container(
                    width: 70,
                    height: 45,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('assets/images/small_car.jpg'),
                        fit: BoxFit.fill,
                      ),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: .5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      border: Border.all(
                        color: Colors.grey,
                        width: 0.05,
                      ),
                      borderRadius: BorderRadius.circular(17.5),
                    ),
                  ),
                  onTap: () {},
                ),
                InkWell(
                  child: Container(
                    width: 70,
                    height: 45,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('assets/images/big_car.jpg'),
                        fit: BoxFit.fill,
                      ),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: .5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      border: Border.all(
                        color: Colors.grey,
                        width: 0.05,
                      ),
                      borderRadius: BorderRadius.circular(17.5),
                    ),
                  ),
                  onTap: () {},
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
                                  fontSize: 17, fontWeight: FontWeight.bold),
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
                            borderRadius: BorderRadius.all(Radius.circular(13)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              const Text(
                                "Login to see prices ",
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Color.fromARGB(255, 137, 92, 146)),
                              ),
                              const Icon(
                                Icons.logout_rounded,
                                size: 18,
                                color: Color.fromARGB(255, 137, 92, 146),
                              ),
                            ],
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
                                  fontSize: 17, fontWeight: FontWeight.bold),
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
                            borderRadius: BorderRadius.all(Radius.circular(13)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              const Text(
                                "Login to see prices ",
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Color.fromARGB(255, 137, 92, 146)),
                              ),
                              const Icon(
                                Icons.logout_rounded,
                                size: 18,
                                color: Color.fromARGB(255, 137, 92, 146),
                              ),
                            ],
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
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 15, 0, 0),
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/images/rapido.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(11, 10, 0, 0),
                            child: Text(
                              "Rapido",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
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
                            borderRadius: BorderRadius.all(Radius.circular(13)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              const Text(
                                "Login to see prices ",
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Color.fromARGB(255, 137, 92, 146)),
                              ),
                              const Icon(
                                Icons.logout_rounded,
                                size: 18,
                                color: Color.fromARGB(255, 137, 92, 146),
                              ),
                            ],
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
              Container(
                width: 100,
                height: 75,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bike.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              // ignore: avoid_unnecessary_containers
              Container(
                child: const Text("No options available for now..."),
              ),
            ],
          ),
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
        ],
      ),
    );
  }

  onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
}
