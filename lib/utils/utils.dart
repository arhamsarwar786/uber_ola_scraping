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

}
