// import 'package:flutter/material.dart';
// import 'package:uber_scrape/map_screen.dart';
// import 'package:uber_scrape/ola_webview.dart';
// import 'package:uber_scrape/uber_webview.dart';

// class BottomNavigationBar extends StatefulWidget {
//   const BottomNavigationBar({super.key});

//   @override
//   State<BottomNavigationBar> createState() => _BottomNavigationBarState();
// }

// class _BottomNavigationBarState extends State<BottomNavigationBar> {

//   int _selectedIndex = 0;

//   final List<Widget> _widgetOptions = [
//     const MapView(),
//     const olaWebView(),
//     const uberWebView(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//        body: Center(
//         child: _widgetOptions.elementAt(_selectedIndex),
//       ),

//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Fragment One',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.search),
//             label: 'Fragment Two',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings),
//             label: 'Fragment Three',
//           ),
//         ],
//       ),
//     );
//   }
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
// }