import 'dart:math';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

import '../utils/toast.dart';

Future<Position> getCurrentLatLng() async {
  bool serviceEnabled;
  LocationPermission permission;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    showToast(
      "ERROR".tr,
      "LOCATION_SERVICES_ARE_DISABLED".tr,
      ToastType.DANGER,
    );
    Get.offAllNamed('location-permission');
    return Future.error('LOCATION_SERVICES_ARE_DISABLED'.tr);
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      showToast(
        "ERROR".tr,
        "LOCATION_PERMISSIONS_ARE_DENIED".tr,
        ToastType.DANGER,
      );
      Get.offAllNamed('location-permission');
      return Future.error("LOCATION_PERMISSIONS_ARE_DENIED".tr);
    }
  }

  if (permission == LocationPermission.deniedForever) {
    showToast(
      "ERROR".tr,
      "LOCATION_PERMISSIONS_ARE_PERMANENTLY_DENIED_WE_CANNOT_REQUEST_PERMISSIONS"
          .tr,
      ToastType.DANGER,
    );
    Get.offAllNamed('location-permission');
    return Future.error(
        'LOCATION_PERMISSIONS_ARE_PERMANENTLY_DENIED_WE_CANNOT_REQUEST_PERMISSIONS'
            .tr);
  }
  return await Geolocator.getCurrentPosition();
}

Future<Placemark> getUserAddress(lat, lng) async {
  List<Placemark> newPlace = await placemarkFromCoordinates(lat, lng);
  Placemark placeMark = newPlace[0];
  return placeMark;
}

Future<String> getUserCity(lat, lng) async {
  List<Placemark> newPlace = await placemarkFromCoordinates(lat, lng);
  Placemark placeMark = newPlace[0];
  String locality = placeMark.locality ?? "";
  String city = locality;
  return city;
}

Future<String> getUserCountry(lat, lng) async {
  List<Placemark> newPlace = await placemarkFromCoordinates(lat, lng);
  Placemark placeMark = newPlace[0];
  String country = placeMark.country ?? "";
  return country;
}

double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  var temp = 12742 * asin(sqrt(a));
  return (temp * 1000);
}
