// ignore_for_file: unused_local_variable, unused_field, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uber_scrape/provider/my_provider.dart';
import 'package:uber_scrape/utils/panel_widget.dart';
import 'package:uber_scrape/utils/utils.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

final pickUpController = TextEditingController();
final destinationController = TextEditingController();


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
  void initState() {
    getCurrentLocation();
    var provider = Provider.of<MyProvider>(context,listen: false);
      provider.getDirections();

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
                child: Consumer<MyProvider>(
                  builder: (context,provider,child) {
                    return 
                      
                          GoogleMap(
                        rotateGesturesEnabled: true,
                        minMaxZoomPreference: MinMaxZoomPreference.unbounded,
                        initialCameraPosition: const CameraPosition(
                          target: LatLng(37.785419, -122.404164),
                          zoom: 13,
                        ),
                        onMapCreated: onMapCreated,
                        markers: provider.markers.toSet(), //markers to show on map
                        polylines: Set<Polyline>.of(provider.polylines.values), //polylines
                        mapType: MapType.normal,
                    
                        // ignore: prefer_collection_literals
                        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
                          Factory<OneSequenceGestureRecognizer>(
                            () => EagerGestureRecognizer(),
                          ),
                        ].toSet(),
                        buildingsEnabled: true,
                        mapToolbarEnabled: true,
                        zoomGesturesEnabled: true,
                        zoomControlsEnabled: true,
                        scrollGesturesEnabled: true,
                        myLocationEnabled: _isLocationGranted,
                        myLocationButtonEnabled: true,
                        compassEnabled: true,
                        indoorViewEnabled: true,
                        // trafficEnabled: true,
                      );
                    
                       
                   
                  }
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.30,
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


