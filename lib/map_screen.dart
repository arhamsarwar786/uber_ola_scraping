import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'dart:typed_data';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:uber_scrape/fare_screen.dart';
import 'package:uber_scrape/search_handler.dart';
import 'package:uber_scrape/search_screen.dart';
import 'package:uber_scrape/utils/gloablState.dart';
import 'package:uber_scrape/utils/utils.dart';
import 'package:uber_scrape/widgets.dart';


  
  final pickUpController = TextEditingController();
  final destinationController = TextEditingController();

// This page shows a Google Map plugin with all stations (HvD and Total). The markers are pulled from a Firebase database.

class MapView extends StatefulWidget {
  @override
  _MapView createState() => _MapView();
}

class _MapView extends State<MapView> {
  bool _isLocationGranted = false;

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
                      color: Color(0xff757575),
                      child: Container(
                        padding: EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(20.0),
                                topRight: const Radius.circular(20.0))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              specify['stationName'],
                              style: TextStyle(
                                  // color: PaletteBlue.hvdblue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10),
                            Text(specify['stationAddress']),
                            Text(specify['stationZIP'] +
                                ' ' +
                                specify['stationCity']),
                            SizedBox(height: 20),
                            ElevatedButton(
                                child: Text(
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
      infoWindow: InfoWindow(),
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
                      color: Color(0xff757575),
                      child: Container(
                        padding: EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(20.0),
                                topRight: const Radius.circular(20.0))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              specify['stationName'],
                              style: TextStyle(
                                  // color: PaletteBlue.hvdblue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10),
                            Text(specify['stationAddress']),
                            Text(specify['stationZIP'] +
                                ' ' +
                                specify['stationCity']),
                            SizedBox(height: 20),
                            ElevatedButton(
                                child: Text(
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
      infoWindow: InfoWindow(),
      // icon: BitmapDescriptor.fromBytes(markerTotal),
    );
    setState(() {
      markers[markerId] = marker;
    });
  }



// Below function initiates all previous functions on the page. This happens when the user navigates to the page.

  void initState() {
   
    super.initState();
      getCurrentLocation();
    
    
  }

  getCurrentLocation()async{
   var   location =  await fetchLocation();
   if(location  == null){
      
     setState(() {
        currentLocation = LatLng(37.8199286, -122.4782551);
        _isLocationGranted = true;
      });
      mapController!.moveCamera(CameraUpdate.newLatLng(const LatLng(37.8199286, -122.4782551))) as CameraPosition;
   }else{
      setState(() {
        currentLocation = location;
        _isLocationGranted = true;
      });
      mapController!.moveCamera(CameraUpdate.newLatLng(LatLng(currentLocation.latitude, currentLocation.longitude))) as CameraPosition;
   }

  }

  CameraPosition _initialCameraPosition =
      CameraPosition(target: const LatLng(51.9244201, 4.4777325), zoom: 12);


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: onMapCreated,
              markers: Set<Marker>.of(markers.values),
              gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
                new Factory<OneSequenceGestureRecognizer>(
                  () => new EagerGestureRecognizer(),
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
            Positioned(
              bottom: 0,
              child: locationPicker(context,size))
            ,
          ],
        ),
      )
   ;
  }

  locationPicker(context,size){
    return Container(
      height: 230,
      padding: EdgeInsets.all(20),
      color: Colors.white,
      width: size.width,
      child: Column(children: [
        InkWell(
          onTap: (){
            handlePressButton(context,'pickUp');
            // Navigator.push(context, MaterialPageRoute(builder: (_)=> SearchScreen('Pick Up') ));
          },
          child: TextField(
            controller: pickUpController,
            enabled: false,
            decoration: InputDecoration(
              hintText: "Pick Up",
              border: OutlineInputBorder(
                
              )
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
         InkWell(
          onTap: (){
            // Navigator.push(context, MaterialPageRoute(builder: (_)=> SearchScreen('Destination') ));    
            handlePressButton(context,'destination');        
          },
           child: TextField(
            controller: destinationController,
            enabled: false,
            decoration: InputDecoration(
              hintText: "Destination",
              border: OutlineInputBorder(
                
              )
            ),
                 ),
         ),
           SizedBox(
          height: 10,
        ),

         ElevatedButton(onPressed: (){

          if(GlobalState.pickUpLatLng == null){
            snackBar(context, "Please! Enter PickUp Address");
          }else 
          if(GlobalState.destinationLatLng == null){
            snackBar(context, "Please! Enter Destination Address");
          }else{
            // snackBar(context, 'HIT');
            Navigator.push(context, MaterialPageRoute(builder: (context)=> FareScreen(pickUp: GlobalState.pickUpLatLng, destination: GlobalState.destinationLatLng ) ));
          }

         }, child: Text("Check Fare"))
      ],),
    );
  }

  onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
}

