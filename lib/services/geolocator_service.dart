import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GeoLocatorService with ChangeNotifier {
  Position? currentPosition;

  String? address;
  late LocationPermission izinLokasi;

  Future<LocationPermission> getUserLocationPermission() async {
    return await Geolocator.checkPermission();
  }

  Future<Position?> getLocation() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<List<Placemark?>> getAddress({required Position currPosition}) async {
    List<Placemark?> currentAddress = [];
    List<Placemark> pos = await placemarkFromCoordinates(
        currPosition.latitude, currPosition.longitude);
    currentAddress = pos;
    // print('currentAddress $currentAddress');
    return currentAddress;
  }

  Future<String?> getCurrentAddress() async {
    LocationPermission permissionUser = await getUserLocationPermission();

    if (permissionUser == LocationPermission.denied) {
      // print("denied");
      izinLokasi = await Geolocator.requestPermission();
    } else {
      currentPosition = await getLocation();
      notifyListeners();
      if (currentPosition != null) {
        // print(currentPosition!.latitude);
        List<Placemark?> pos = await getAddress(currPosition: currentPosition!);
        Placemark? currAddress = pos[0];
        address = "${currAddress?.country}, ${currAddress?.locality}, ${currAddress?.postalCode}";
        return address;
      } else {
        return 'Posisi saat ini tidak diketahui';
      }
    }
  }
}
