import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart';

class LocationHelper {
  double? latitude;
  double? longitude;

  Future<void> getCurrentLocation() async {
    Location location = Location();

    bool _ServiceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    //location servisi ayakta mı,?
    _ServiceEnabled = await location.serviceEnabled();

    if (!_ServiceEnabled) {
      _ServiceEnabled = await location.requestService();
      if (!_ServiceEnabled) {
        return;
      }
    }
    //konum izin kontrolü
    _permissionGranted = await location.hasPermission();

    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.granted) {
        return;
      }
    }
    //izinler tamamsa
    _locationData = await location.getLocation();
    latitude = _locationData.latitude;
    longitude = _locationData.longitude;
  }
}
