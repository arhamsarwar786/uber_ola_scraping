// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_scrape/utils/gloablState.dart';
import 'package:uber_scrape/utils/utils.dart';

class MyProvider extends ChangeNotifier {
  PolylinePoints polylinePoints = PolylinePoints();

  Map<PolylineId, Polyline> polylines = {};
  List<Marker> markers = [];

  getDirections() async {
    markers.clear();
    if (GlobalState.pickUpLatLng != null &&
        GlobalState.destinationLatLng != null) {
      markers.add(Marker(
        markerId: const MarkerId('start'),
        position: GlobalState.pickUpLatLng!,
        infoWindow: const InfoWindow(
          title: 'Starting Point',
          snippet: 'Start Marker',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));

      markers.add(Marker(
        markerId: const MarkerId('end'),
        position: GlobalState.destinationLatLng!,
        infoWindow: const InfoWindow(
          title: 'Destination Point',
          snippet: 'Destination Marker',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
      List<LatLng> polylineCoordinates = [];

      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        kGoogleApiKey,
        PointLatLng(GlobalState.pickUpLatLng!.latitude,
            GlobalState.pickUpLatLng!.longitude),
        PointLatLng(GlobalState.destinationLatLng!.latitude,
            GlobalState.destinationLatLng!.longitude),
        travelMode: TravelMode.driving,
      );
      print(result.toString() + "===================");
      if (result.points.isNotEmpty) {
        result.points.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });
      } else {
        print(result.errorMessage);
      }
      addPolyLine(polylineCoordinates);
      notifyListeners();
    }
  }

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
  }

  
}
