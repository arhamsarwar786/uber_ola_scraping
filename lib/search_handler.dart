// ignore_for_file: depend_on_referenced_packages, avoid_print

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
    GlobalState.pickUpLat = lat;
    GlobalState.pickUpLng = lng;
    GlobalState.pickUpAddress = p.description;
    pickUpController.text = GlobalState.pickUpAddress!;
    // Reset destination lat/lng to null if not already set
    if (GlobalState.destinationLatLng == null) {
      GlobalState.destinationLat = null;
      GlobalState.destinationLng = null;
    }
  } else {
    GlobalState.destinationLatLng = LatLng(lat, lng);
    GlobalState.destinationLat = lat;
    GlobalState.destinationLng = lng;
    GlobalState.destinationAddress = p.description;
    destinationController.text = GlobalState.destinationAddress!;
    // Reset pickup lat/lng to null if not already set
    if (GlobalState.pickUpLatLng == null) {
      GlobalState.pickUpLat = null;
      GlobalState.pickUpLng = null;
    }
  }

  print('${'PickUpLat'} - ${GlobalState.pickUpLat}');
  print('${'PickUpLng'} - ${GlobalState.pickUpLng}');
  print('${'DestinationLat'} - ${GlobalState.destinationLat}');
  print('${'DestinationLng'} - ${GlobalState.destinationLng}');
}

