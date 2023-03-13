import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

const kGoogleApiKey = 'AIzaSyBzb0omOYSIJrcfVdlipfqhKXEl1qZbZSQ';

fetchLocation() async {
  Location location = Location();
  LocationData _locationData;

  if (await Permission.location.request().isGranted) {
    return await location.getLocation();
  } else {
    await Permission.location.request();
  }

// bool _serviceEnabled;
// PermissionStatus _permissionGranted;

// _serviceEnabled = await location.serviceEnabled();
// if (!_serviceEnabled) {
//   _serviceEnabled = await location.requestService();
//   if (!_serviceEnabled) {
//     return;
//   }
// }

// _permissionGranted = await location.hasPermission();
// if (_permissionGranted == PermissionStatus.denied) {
//   _permissionGranted = await location.requestPermission();
//   if (_permissionGranted != PermissionStatus.granted) {
//     return;
//   }
// }
}
