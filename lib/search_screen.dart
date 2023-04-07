// import 'package:flutter/material.dart';
// // import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
// import 'package:google_api_headers/google_api_headers.dart';
// import 'package:google_maps_webservice/places.dart';
// import 'package:flutter_google_places/flutter_google_places.dart';
// import 'package:uber_scrape/utils/utils.dart';
// // import 'package:uber_scrape/utils/color_constants.dart';

// class SearchScreen extends StatefulWidget {
//   // ignore: prefer_typing_uninitialized_variables
//   // final title;
//   // const SearchScreen(this.title, {super.key});

//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {

//   final pickUpController = TextEditingController();
//   final destinationController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     String apikey = kGoogleApiKey;
//     googlePlace = GooglePlace(apikey);
    
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//          child: Scaffold(
//           body: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               children: [
//                 TextField(
//                   controller: pickUpController,
//                   autofocus: true,
//                   enabled: true,
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: Colors.grey[200],
//                     icon: const Icon(
//                           Icons.accessibility_new,
//                           color: Colors.black,
//                         ),
//                     hintText: 'Pick Up',
//                       border: const OutlineInputBorder()),
//                 ),
//                 Row(
//                 children: const [
//                   Padding(
//                     padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//                     child: SizedBox(
//                       height: 20,
//                       child: VerticalDivider(
//                         color: Colors.grey,
//                         thickness: 2.5,
//                       ),
//                     ),
//                   ),
//                 ],
//               ), 
//                 TextField(
//                   controller: destinationController,
//                   autofocus: true,
//                   enabled: true,
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: Colors.grey[200],
//                     icon: const Icon(
//                           Icons.fmd_good_sharp,
//                           color: Colors.red,
//                         ),
//                     hintText: 'Destination',
//                       border: const OutlineInputBorder()),
//                 )
//               ],
//             ),
//           ),
//         ),
     
//     );
//   }
// }
