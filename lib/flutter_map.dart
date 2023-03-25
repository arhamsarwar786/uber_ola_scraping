// // import 'package:flutter/material.dart';
// // import 'package:flutter_map/flutter_map.dart';
// // import 'package:latlong2/latlong.dart';


// // void main() => runApp(MyApp());

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Flutter Map Example',
// //       home: MapPage(),
// //     );
// //   }
// // }

// // class MapPage extends StatefulWidget {
// //   @override
// //   _MapPageState createState() => _MapPageState();
// // }

// // class _MapPageState extends State<MapPage> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Flutter Map Example'),
// //       ),
// //       body: FlutterMap(
// //         options: MapOptions(
// //           center: LatLng(51.5, -0.09),
// //           zoom: 13.0,
// //         ),
// //         layers: [
// //           TileLayerOptions(
// //             urlTemplate:
// //                 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
// //             subdomains: ['a', 'b', 'c'],
// //           ),
// //           PolygonLayerOptions(
// //             polygons: [
// //               Polygon(
// //                 points: [
// //                   LatLng(51.52297, -0.125537),
// //                   LatLng(51.51673, -0.120977),
// //                   LatLng(51.51378, -0.129297),
// //                   LatLng(51.52082, -0.136547),
// //                   LatLng(51.52609, -0.13217),
// //                 ],
// //                 color: Colors.blue.withOpacity(0.3),
// //                 borderColor: Colors.blue,
// //                 borderStrokeWidth: 2,
// //               ),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Map Example',
//       home: MapPage(),
//     );
//   }
// }

// class MapPage extends StatefulWidget {
//   @override
//   _MapPageState createState() => _MapPageState();
// }

// class _MapPageState extends State<MapPage> {
//   List<LatLng> points = [    LatLng(51.52297, -0.125537),    LatLng(51.51673, -0.120977),    LatLng(51.51378, -0.129297),    LatLng(51.52082, -0.136547),    LatLng(51.52609, -0.13217),  ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flutter Map Example'),
//       ),
//       body: FlutterMap(
//         options: MapOptions(
//           center: LatLng(51.5, -0.09),
//           zoom: 13.0,
//         ),
//         layers: [
//           TileLayerOptions(
//             urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
//             subdomains: ['a', 'b', 'c'],
//           ),
//           PolygonLayerOptions(
//             polygons: [
//               Polygon(
//                 points: points,
//                 color: Colors.blue.withOpacity(0.3),
//                 borderColor: Colors.blue,
//                 borderStrokeWidth: 2,
//               ),
//             ],
//             borderColor: Colors.blue,
//             borderStrokeWidth: 2,
//             color: Colors.blue.withOpacity(0.3),
//           ),
//         ],
//       ),
//     );
//   }
// }