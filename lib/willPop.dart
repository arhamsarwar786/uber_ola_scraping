

// class HomePage extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {

//     Future<bool> showExitPopup() async {
//       return await showDialog( //show confirm dialogue 
//         //the return value will be from "Yes" or "No" options
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text('Exit App'),
//           content: Text('Do you want to exit an App?'),
//           actions:[
//             ElevatedButton(
//               onPressed: () => Navigator.of(context).pop(false),
//                //return false when click on "NO"
//               child:Text('No'),
//             ),

//             ElevatedButton(
//               onPressed: () => Navigator.of(context).pop(true), 
//               //return true when click on "Yes"
//               child:Text('Yes'),
//             ),

//           ],
//         ),
//       )??false; //if showDialouge had returned null, then return false
//     }

//     return WillPopScope( 
//       onWillPop: showExitPopup, //call function on back button press
//       child:Scaffold( 
//         appBar: AppBar( 
//           title: Text("Override Back Button"),
//           backgroundColor: Colors.redAccent,
//         ),
//         body: Center( 
//           child: Text("Override Back Buttton"),
//         )
//       )
//     );
//   }
// }

// import 'package:flutter/material.dart';

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My App'),
//       ),
//       body: WillPopScope(
//         onWillPop: _onBackPressed,
//         child: Center(
//           child: Text('Press the back button to exit'),
//         ),
//       ),
//     );
//   }

//   DateTime? currentBackPressTime;
//   Future<bool> _onBackPressed() async {
//     final now = DateTime.now();
//     if (currentBackPressTime == null ||
//         now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
//       currentBackPressTime = now;
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Press back again to exit')),
//       );
//       return false;
//     }
//     return true;
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';

Future<bool> showExitPopup(context) async{
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 90,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Do you want to exit?"),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          print('yes selected');
                          exit(0);
                        },
                        child: Text("Yes"),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.red.shade800),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                        child: ElevatedButton(
                      onPressed: () {
                        print('no selected');
                        Navigator.of(context).pop();
                      },
                      child: Text("No", style: TextStyle(color: Colors.black)),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                      ),
                    ))
                  ],
                )
              ],
            ),
          ),
        );
      });
} 