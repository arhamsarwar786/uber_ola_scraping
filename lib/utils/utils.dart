// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

const kGoogleApiKey = 'AIzaSyBzb0omOYSIJrcfVdlipfqhKXEl1qZbZSQ';

fetchLocation() async {
  Location location = Location();
  // ignore: unused_local_variable
  LocationData _locationData;

  if (await Permission.location.request().isGranted) {
    return await location.getLocation();
  } else {
    await Permission.location.request();
  }

}
