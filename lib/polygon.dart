// // import 'package:google_maps_flutter/google_maps_flutter.dart';

// // static const LatLng _center = const LatLng(33.738045, 73.084488);
// // final Set<Marker> _markers = {};
// // final Set<Polyline>_polyline={};

// // //add your lat and lng where you wants to draw polyline
// // LatLng _lastMapPosition = _center;
// // List<LatLng> latlng = List();
// // LatLng _new = LatLng(33.738045, 73.084488);
// // LatLng _news = LatLng(33.567997728, 72.635997456);

// // latlng.add(_new);
// // latlng.add(_news);

// // //call this method on button click that will draw a polyline and markers

// // void _onAddMarkerButtonPressed() {
// //     getDistanceTime();
// //     setState(() {
// //         _markers.add(Marker(
// //             // This marker id can be anything that uniquely identifies each marker.
// //             markerId: MarkerId(_lastMapPosition.toString()),
// //             //_lastMapPosition is any coordinate which should be your default 
// //             //position when map opens up
// //             position: _lastMapPosition,
// //             infoWindow: InfoWindow(
// //                 title: 'Really cool place',
// //                 snippet: '5 Star Rating',
// //             ),
// //             icon: BitmapDescriptor.defaultMarker,

// //         ));
// //         _polyline.add(Polyline(
// //             polylineId: PolylineId(_lastMapPosition.toString()),
// //             visible: true,
// //             //latlng is List<LatLng>
// //             points: latlng,
// //             color: Colors.blue,
// //         ));
// //     });

// //     //in your build widget method
// //     GoogleMap(
// //     //that needs a list<Polyline>
// //         polylines:_polyline,
// //         markers: _markers,
// //         onMapCreated: _onMapCreated,
// //         myLocationEnabled:true,
// //         onCameraMove: _onCameraMove,
// //         initialCameraPosition: CameraPosition(
// //             target: _center,
// //             zoom: 11.0,
// //         ),

// //         mapType: MapType.normal,

// //     );
// // }

import 'package:flutter/material.dart';
 import 'package:google_maps_flutter/google_maps_flutter.dart';

// class TestMapPolyline extends StatefulWidget {
//   @override
//   _TestMapPolylineState createState() => _TestMapPolylineState();
// }

// class _TestMapPolylineState extends State<TestMapPolyline> {
//   final Set<Marker> _markers = {};
//   final Set<Polyline> _polyline = {};

//   GoogleMapController controller;

//   List<LatLng> latlngSegment1 = List();
//   List<LatLng> latlngSegment2 = List();
//   static LatLng _lat1 = LatLng(13.035606, 77.562381);
//   static LatLng _lat2 = LatLng(13.070632, 77.693071);
//   static LatLng _lat3 = LatLng(12.970387, 77.693621);
//   static LatLng _lat4 = LatLng(12.858433, 77.575691);
//   static LatLng _lat5 = LatLng(12.948029, 77.472936);
//   static LatLng _lat6 = LatLng(13.069280, 77.455844);
//   LatLng _lastMapPosition = _lat1;

//   @override
//   void initState() {
//     super.initState();
//     //line segment 1
//     latlngSegment1.add(_lat1);
//     latlngSegment1.add(_lat2);
//     latlngSegment1.add(_lat3);
//     latlngSegment1.add(_lat4);

//     //line segment 2
//     latlngSegment2.add(_lat4);
//     latlngSegment2.add(_lat5);
//     latlngSegment2.add(_lat6);
//     latlngSegment2.add(_lat1);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GoogleMap(
//         //that needs a list<Polyline>
//         polylines: _polyline,
//         markers: _markers,
//         onMapCreated: _onMapCreated,
//         initialCameraPosition: CameraPosition(
//           target: _lastMapPosition,
//           zoom: 11.0,
//         ),
//         mapType: MapType.normal,
//       ),
//     );
//   }

//   void _onMapCreated(GoogleMapController controllerParam) {
//     setState(() {
//       controller = controllerParam;
//       _markers.add(Marker(
//         // This marker id can be anything that uniquely identifies each marker.
//         markerId: MarkerId(_lastMapPosition.toString()),
//         //_lastMapPosition is any coordinate which should be your default
//         //position when map opens up
//         position: _lastMapPosition,
//         infoWindow: InfoWindow(
//           title: 'Awesome Polyline tutorial',
//           snippet: 'This is a snippet',
//         ),
//       ));

//       _polyline.add(Polyline(
//         polylineId: PolylineId('line1'),
//         visible: true,
//         //latlng is List<LatLng>
//         points: latlngSegment1,
//         width: 2,
//         color: Colors.blue,
//       ));

//       //different sections of polyline can have different colors
//       _polyline.add(Polyline(
//         polylineId: PolylineId('line2'),
//         visible: true,
//         //latlng is List<LatLng>
//         points: latlngSegment2,
//         width: 2,
//         color: Colors.red,
//       ));
//     });
//   }
// }//this is below code is good
class MyMap extends StatefulWidget {
  const MyMap({Key? key}) : super(key: key);

  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  Set<Polygon> _polygons = {};

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

    return Scaffold(
      body: GoogleMap(
        polygons: _polygons,
        initialCameraPosition: CameraPosition(
          target: LatLng(37.785419, -122.404164),
          zoom: 14,
        ),
      ),
    );
  }
}
