import 'dart:async';
import 'dart:collection';


import 'package:flutter/material.dart';
 import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_scrape/utils/panel_widget.dart';
import 'package:uber_scrape/utils/utils.dart';
// import 'package:uber_scrape/widgets.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter/src/widgets/framework.dart';
final pickUpController = TextEditingController();
final destinationController = TextEditingController();

List cars = [
  {'id': 0, 'name': 'Select a Ride', 'price': 0.0},
  {'id': 1, 'name': 'Uber Go', 'price': 230.0},
  {'id': 2, 'name': 'Go Sedan', 'price': 300.0},
  {'id': 3, 'name': 'Uber XL', 'price': 500.0},
  {'id': 4, 'name': 'Uber Auto', 'price': 140.0},
];

class Map_polygon extends StatefulWidget {
  const Map_polygon({super.key});

  @override
  State<Map_polygon> createState() => _Map_polygonState();
}

class _Map_polygonState extends State<Map_polygon> {
   bool _isLocationGranted = false;
 int activeContainerIndex = -1;
  Completer<GoogleMapController>_controller=Completer();
  static final CameraPosition _KGooglePlex= CameraPosition(target:LatLng(31.567286334227802, 74.32516146459717),zoom: 14);
 Set<Polygon> _polygone=HashSet<Polygon>();
  final Set<Polyline>_polyline={};
  List<LatLng> points=[
    LatLng(31.528298548992247, 74.32748116149881),
    // LatLng(32.19690071242614, 74.188635025401),
    LatLng( 31.582794501125193, 74.41669823993631),
    LatLng( 31.582341264884725, 74.39770747945322),
    //LatLng( 31.808776780069152, 74.25306532295872),

    LatLng(31.528298548992247, 74.32748116149881),


  ];
  List<LatLng> latlng=[
    LatLng(31.528298548992247, 74.32748116149881),
    // LatLng(32.19690071242614, 74.188635025401),
    LatLng( 31.475254327997412, 74.44234800837617),

    LatLng(31.528298548992247, 74.32748116149881),


  ];
 List<Marker> _marker=[];
 List<Marker> _list=const[
  Marker(markerId: MarkerId('1'),position: LatLng(31.567286334227802, 74.32516146459717), 
  infoWindow:InfoWindow(title: "My position") 
  ), Marker(markerId: MarkerId('2'),position: LatLng(31.58009804133426, 74.35629683972273),
  infoWindow:InfoWindow(title: "Another Location") 
  ),Marker(markerId: MarkerId('3'),position: LatLng(34.91927355838453, 103.53220215464391),
  infoWindow:InfoWindow(title: "china") )
  // ),Marker(markerId: MarkerId('4'),position: LatLng(32.19690071242614, 74.188635025401),
  // infoWindow:InfoWindow(title: "gujranwala") 
  // ),
  // 
  
 ];
 final panelController = PanelController();
  @override
  void initState(){
    super.initState();
    for (var i = 0; i < points.length; i++) {
_marker.add(
  Marker(markerId: MarkerId(i.toString()),position: points[i],infoWindow: InfoWindow(title: 'Really cool place',snippet: '5 star rating'),icon: BitmapDescriptor.defaultMarker),
);setState(() {
  
});      
    _polyline.add(Polyline(polylineId: PolylineId('6'),points: points,width: 4));
    }
    _marker.addAll(_list);
   _polygone.add(Polygon(polygonId:PolygonId('3'),points:latlng,
   fillColor: Colors.red,strokeColor: Colors.deepOrange,strokeWidth: 7,geodesic: true ));
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
          body: Column(
            children: [
             
              Expanded(
                child: GoogleMap(
                   polygons: _polygone,
        polylines: _polyline,
        markers: Set<Marker>.of(_marker),
        myLocationEnabled: true,
        compassEnabled: true,
        mapType: MapType.normal,
        initialCameraPosition: _KGooglePlex,
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
      ),
// rotateGesturesEnabled:true,
      
               

   
//                    minMaxZoomPreference: MinMaxZoomPreference.unbounded,
//                  polygons: _polygons,
//                 initialCameraPosition: CameraPosition(
              
//           target: LatLng(37.785419, -122.404164),
//           zoom: 14,
//                 ),
//                   onMapCreated: onMapCreated, 
//                   markers: Set<Marker>.of(markers.values),
//                   // ignore: prefer_collection_literals
//                   gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
//                     Factory<OneSequenceGestureRecognizer>(
//                       () => EagerGestureRecognizer(),
//                     ),
//                   ].toSet(),
                  
//                   mapToolbarEnabled: true,
//                   zoomGesturesEnabled: true,
//                   zoomControlsEnabled: true,
//                   scrollGesturesEnabled: true,
//                   myLocationEnabled: _isLocationGranted,
//                   myLocationButtonEnabled: true,
                  //initialCameraPosition: _initialCameraPosition,
                ),
        ]      ),
          //     Padding(
          //   padding: const EdgeInsets.all(16),
          //   child: Column(
          //     // mainAxisAlignment: MainAxisAlignment.end,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
                 
          //       ElevatedButton(
          //         onPressed: () {
          //           if (_controller != null) {
          //             _controller!.animateCamera(
          //               CameraUpdate.zoomIn(),
          //             );
          //           }
          //         },
          //         child: const Icon(Icons.add),
          //       ),
          //       const SizedBox(height: 16),
          //       ElevatedButton(
          //         onPressed: () {
          //           if (_controller != null) {
          //             _controller!.animateCamera(
          //               CameraUpdate.zoomOut(),
          //             );
          //           }
          //         },
          //         child: const Icon(Icons.remove),
          //       ),//map3333
              
          //     ],
          //   ),
          // ),
        
          
          
          panelBuilder: (controller) => PanelWidget(
            controller: controller,
             panelController: panelController,
          ),
              ))        );
  }}
        

        // ignore: avoid_unnecessary_containers
       
    
     
  //   return Scaffold(
  //     body:GoogleMap(
  //       polygons: _polygone,
  //       polylines: _polyline,
  //       markers: Set<Marker>.of(_marker),
  //       myLocationEnabled: true,
  //       compassEnabled: true,
  //       mapType: MapType.normal,
  //       initialCameraPosition: _KGooglePlex,
  //       onMapCreated: (GoogleMapController controller){
  //         _controller.complete(controller);
  //       },
  //     ),
  //       floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        
  //     floatingActionButton: SizedBox(
  //       height: 40,width: 40,
  //       child: FittedBox(
  //         child: FloatingActionButton(
  //           child: Icon(Icons.location_disabled_outlined),
  //           onPressed: ()async {
  //             setState(() {
                
  //             });
  //             GoogleMapController controller=await _controller.future;
  //             controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(34.91927355838453, 103.53220215464391))));
  //         },),
  //       ),
  //     ),
  //   );
   