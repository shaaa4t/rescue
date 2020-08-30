import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

//Class for getting user current Location
class Location {
  Future<void> openGoogleMapApp({double latitude, double longitude}) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
      print('opnenig');
    } else {
      throw 'Could not open the map.';
    }
  }

  Future<Position> getCurrentLocation() async {
    return await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
}
