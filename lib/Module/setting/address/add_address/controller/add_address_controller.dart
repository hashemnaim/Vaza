import 'dart:async';

import 'package:faza_app/Module/setting/address/address_list/controller/address_list_controller.dart';
import 'package:faza_app/services/address_service.dart';
import 'package:faza_app/services/location_service.dart';
import 'package:faza_app/helper/loading.dart';
import 'package:faza_app/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddressController extends GetxController {
  var addressListController = Get.put(AddressListController());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late GoogleMapController mapController;
  Rx<Completer<GoogleMapController>> completedController =
      Completer<GoogleMapController>().obs;

  RxBool isLoading = false.obs;

  Rx<LatLng> currentLatLng = const LatLng(0, 0).obs;
  Rx<LatLng> latLngAfterMapMove = const LatLng(0, 0).obs;
  RxDouble zoom = 14.4746.obs;

  TextEditingController titleController = TextEditingController();
  Rx<TextEditingController> locationController = TextEditingController().obs;
  RxDouble latitude = 31.3792233.obs;
  RxDouble longitude = 73.0638604.obs;

  @override
  void onInit() {
    getCurrentLocation();
    super.onInit();
  }

  getCurrentLocation() async {
    try {
      currentLatLng.value = const LatLng(0, 0);
      Position position = await getCurrentLatLng();
      currentLatLng.value = LatLng(position.latitude, position.longitude);
      latLngAfterMapMove.value = LatLng(position.latitude, position.longitude);
      setLocationByLatLng();
    } catch (e) {
      Get.offAllNamed('location-permission');
    }
  }

  setLocationByLatLng() async {
    isLoading.value = true;
    List<Placemark> placemarks = await placemarkFromCoordinates(
      latLngAfterMapMove.value.latitude,
      latLngAfterMapMove.value.longitude,
    );
    locationController.value.text =
        "${placemarks.first.street} ${placemarks.first.subLocality} ${placemarks.first.locality} ${placemarks.first.administrativeArea}";

    isLoading.value = false;
    locationController.refresh();
  }

  onAddAddressClick() async {
    if (formKey.currentState!.validate()) {
      if (titleController.text.isEmpty &&
          locationController.value.text.isEmpty) {
        showSnackBar(
          message: "PLEASE_FILL_ALL_THE_FIELDS".tr,
          position: ToastPosition.top,
          type: ToastType.DANGER,
        );
        return;
      }
      var data = {
        "address": titleController.text,
        "street": locationController.value.text,
        "latitude": latitude.value,
        "longitude": longitude.value,
        // "userId": StorageService.getUserId(),
      };
      showOrHideLoading(false, "ADDING".tr);

      var response = await AddressService.addAddress(data);
      showOrHideLoading(true, "ADDING".tr);
      if (response.success == true) {
        // if (response. != null) {
        // addressListController.addressList.add(response.);
        addressListController.refresh();
        // }
        Get.back();
        showToast("ADDRESS_ADDED".tr, "ADDRESS_ADDED_SUCCESSFULLY".tr,
            ToastType.SUCCESS);
      }
    }
  }
}
