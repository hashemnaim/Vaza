import 'dart:async';
import 'dart:developer';
import 'package:faza_app/services/address_service.dart';
import 'package:faza_app/utils/values.dart';
import 'package:faza_app/services/location_service.dart';
import 'package:faza_app/widgets/custom_button.dart';
import 'package:faza_app/widgets/custom_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ndialog/ndialog.dart';
import 'package:get/get.dart';
import '../../../../helper/storage_helper.dart';
import '../../../../models/city_model.dart';
import '../../../../services/APIs/order_service.dart';
import '../../../../helper/loading.dart';
import '../../../../utils/toast.dart';
import '../../../product/cart/controller/cart_controller.dart';
import '../../../setting/address/address_list/model/address_list_model.dart';
import '../map/map_screen.dart';

class OrderDetailController extends GetxController {
  late GoogleMapController mapController;
  Rx<Completer<GoogleMapController>> completedController =
      Completer<GoogleMapController>().obs;
  Rx<LatLng> currentLatLng = const LatLng(0, 0).obs;
  Rx<LatLng> latLngAfterMapMove = const LatLng(0, 0).obs;
  RxDouble zoom = 14.4746.obs;
  CartController cartController = Get.put(CartController());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxList<AddressData> addressList = <AddressData>[].obs;
  RxList<SelectCity> availableCityList = <SelectCity>[].obs;
  RxList<Item> itemCityList = <Item>[].obs;
  RxBool deliveryLocationRequired = false.obs;
  Rx<Item> city = Item(id: 0, name: "Select City".tr).obs;
  RxBool isLoading = false.obs;
  RxString selectTime = "".obs;
  Rx<TextEditingController> locationController = TextEditingController().obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  RxString countryDialCode = '966'.obs;
  RxString phoneNumber = ''.obs;
  Rx<DateTime> deliveryDate = DateTime.now().obs;
  RxInt addressId = 0.obs;
  RxInt orderId = 0.obs;

  @override
  void onInit() {
    if (Get.arguments != null) {
      orderId.value = Get.arguments["order_id"] ?? 0;
    }
    getCity();
    getCurrentLocation();
    super.onInit();
  }

  getCurrentLocation() async {
    currentLatLng.value = const LatLng(0, 0);
    try {
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
        latLngAfterMapMove.value.latitude, latLngAfterMapMove.value.longitude,
        localeIdentifier: StorageService.getcurrentLanguage());
    locationController.value.text =
        "${placemarks.first.street} ${placemarks.first.subLocality} ${placemarks.first.locality}";

    isLoading.value = false;
    locationController.refresh();
  }

  void moveCameraToCurrentLocation() async {
    CameraPosition cuurentCameraPosition = CameraPosition(
      bearing: 0,
      target: currentLatLng.value,
      zoom: 16.0,
    );
    mapController
        .animateCamera(CameraUpdate.newCameraPosition(cuurentCameraPosition));
    latLngAfterMapMove.value = currentLatLng.value;
  }

  getCity() async {
    var response = await AddressService.getAvailbleCities();
    availableCityList.value = response.availableCities ?? [];
    for (var element in availableCityList) {
      itemCityList.add(Item.fromJson(element.toJson()));
    }
  }

  onContinueClick() async {
    if (formKey.currentState!.validate()) {
      if (Get.arguments == null) return;
      if (selectTime.value == "") {
        showToast("Complete the data".tr, "Delivery time must be specified".tr,
            ToastType.DANGER);
      } else {
        Get.to(() => const MapScreen(), transition: Transition.downToUp);
      }
    }
  }

  onCompliteOrder() async {
    if (formKey.currentState!.validate()) {
      if (city.value.id == 0) {
        showToast(
            "Complete the data".tr, "City must be added".tr, ToastType.DANGER);
      } else {
        if (locationController.value.text.isEmpty) {
          deliveryLocationRequired.value = true;
          return;
        } else {
          deliveryLocationRequired.value = false;
        }
        var data = {
          "order_id": orderId.value,
          "address": locationController.value.text,
          "longitude": latLngAfterMapMove.value.latitude.toString(),
          "latitude": latLngAfterMapMove.value.longitude.toString(),
          "city_id": city.value.id,
          "delivery_date": deliveryDate.value.toString(),
          "delivery_time": selectTime.value,
          "recipient_name": nameController.text,
          "recipient_mobile": phoneNumber.value,
          "message": messageController.text,
        };
        log(data.toString());
        showOrHideLoading(false, "VERIFYING".tr);

        var response = await OrderService.createOrder(data);
        await cartController.getCartDataFromDatabase();
        showOrHideLoading(true, "VERIFYING".tr);
        if (response["success"] == true) {
          await Get.offAndToNamed(
            "/order-checkout",
            arguments: data,
          );
        } else {
          showToast(
              "Complete the data".tr, response["message"], ToastType.DANGER);
        }

        if (locationController.value.text.isEmpty) {
          deliveryLocationRequired.value = true;
          return;
        } else {
          deliveryLocationRequired.value = false;
        }
      }
    }
  }

  invalidTime(context) async {
    await NAlertDialog(
      blur: 2,
      title: Text(
        "CANNOT_ORDER".tr,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      content: Text(
        "YOU_CAN_SELECT_A_DELIVERY_TIME_BETWEEN_12_PM_TO_12_AM".tr,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      actions: [
        CustomTextButton(
          text: "DISMISS".tr,
          color: AppColors.black50,
          onPress: () {
            Navigator.pop(context);
          },
        ),
      ],
    ).show(context);
  }
}
