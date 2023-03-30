

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

import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: WillPopScope(
        onWillPop: _onBackPressed,
        child: Center(
          child: Text('Press the back button to exit'),
        ),
      ),
    );
  }

  DateTime? currentBackPressTime;
  Future<bool> _onBackPressed() async {
    final now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Press back again to exit')),
      );
      return false;
    }
    return true;
  }
}
