// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_scrape/map_screen.dart';
import 'package:uber_scrape/utils/gloablState.dart';
import 'package:uber_scrape/utils/utils.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';

Future<void> handlePressButton(context, source) async {
  void onError(PlacesAutocompleteResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(response.errorMessage ?? 'Unknown error'),
      ),
    );
  }

  final p = await PlacesAutocomplete.show(
    
    context: context,
    apiKey: kGoogleApiKey,
    onError: onError,
    mode: Mode.fullscreen,
    
  );

  await displayPrediction(p, ScaffoldMessenger.of(context), source);
}

Future<void> displayPrediction(
    Prediction? p, ScaffoldMessengerState messengerState, source) async {
  if (p == null) {
    return;
  }

  // get detail (lat/lng)
  // ignore: no_leading_underscores_for_local_identifiers
  final _places = GoogleMapsPlaces(    
    apiKey: kGoogleApiKey,
    apiHeaders: await const GoogleApiHeaders().getHeaders(),
  );

  final detail = await _places.getDetailsByPlaceId(p.placeId!);
  final geometry = detail.result.geometry!;
  final lat = geometry.location.lat;
  final lng = geometry.location.lng;

  if (source == "pickUp") {
    GlobalState.pickUpLatLng = LatLng(lat, lng);
    GlobalState.pickUpAddress = p.description;
    pickUpController.text = GlobalState.pickUpAddress!;
  } else {
    GlobalState.destinationLatLng = LatLng(lat, lng);
    GlobalState.destinationAddress = p.description;
    destinationController.text = GlobalState.destinationAddress!;
  }

  // ignore: avoid_print
  print('${p.description} - $lat/$lng ');

  // messengerState.showSnackBar(
  //   SnackBar(
  //     content: Text('${p.description} - $lat/$lng'),
  //   ),
  // );
}
