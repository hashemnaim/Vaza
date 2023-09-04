import 'package:faza_app/utils/values.dart';
import 'package:faza_app/Module/components/appbar.dart';
import 'package:faza_app/Module/order/order_detail/controller/order_detail_controller.dart';
import 'package:faza_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../widgets/custom_drop_down.dart';
import '../../../../widgets/custom_input.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    var orderDetailController = Get.put(OrderDetailController());
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: customAppBar("PICK_LOCATION".tr),
        body: SafeArea(
            child: Obx(() => orderDetailController
                            .currentLatLng.value.latitude ==
                        0 ||
                    orderDetailController.currentLatLng.value.longitude == 0
                ? Center(child: Text("LOADING_MAP".tr))
                : Stack(children: [
                    SizedBox(
                        height: Get.height,
                        width: Get.width,
                        child: GoogleMap(
                            zoomControlsEnabled: false,
                            compassEnabled: false,
                            myLocationEnabled: false,
                            myLocationButtonEnabled: false,
                            mapType: MapType.normal,
                            initialCameraPosition: CameraPosition(
                              target: orderDetailController
                                          .latLngAfterMapMove.value ==
                                      const LatLng(0, 0)
                                  ? orderDetailController.currentLatLng.value
                                  : orderDetailController
                                      .latLngAfterMapMove.value,
                              zoom: orderDetailController.zoom.value,
                            ),
                            onCameraMove: (position) {
                              var lat = position.target.latitude;
                              var lng = position.target.longitude;
                              orderDetailController.latLngAfterMapMove.value =
                                  LatLng(lat, lng);
                              // setState(() {});
                            },
                            onCameraIdle: () async {
                              orderDetailController.setLocationByLatLng();
                            },
                            onMapCreated:
                                (GoogleMapController controller) async {
                              if (!orderDetailController
                                  .completedController.value.isCompleted) {
                                orderDetailController.completedController.value
                                    .complete(controller);
                                orderDetailController.mapController =
                                    await orderDetailController
                                        .completedController.value.future;
                              } else {
                                orderDetailController.mapController =
                                    controller;
                              }
                            })),
                    orderDetailController.isLoading.value
                        ? Positioned.fill(
                            child: Container(
                                width: 50,
                                height: 50,
                                alignment: Alignment.center,
                                child: const CircularProgressIndicator(
                                    color: AppColors.primaryColor)))
                        : Positioned(
                            top: 10,
                            left: 10,
                            right: 10,
                            child: CustomLocationInput(
                              controller: orderDetailController
                                  .locationController.value,
                              itemClickFunction: (p0) {
                                orderDetailController.locationController.value
                                    .text = p0.description!;
                              },
                              latLngDetailFunction: (p0) {
                                orderDetailController.latLngAfterMapMove.value =
                                    LatLng(double.parse(p0.lat!),
                                        double.parse(p0.lng!));
                                orderDetailController.mapController
                                    .animateCamera(
                                        CameraUpdate.newCameraPosition(
                                            CameraPosition(
                                                bearing: 0,
                                                target: orderDetailController
                                                    .latLngAfterMapMove.value,
                                                zoom: 18.0)));
                              },
                            )),
                    orderDetailController.isLoading.value
                        ? Positioned.fill(
                            child: Container(
                                width: 50,
                                height: 50,
                                alignment: Alignment.center,
                                child: const CircularProgressIndicator(
                                    color: AppColors.primaryColor)))
                        : const Positioned.fill(
                            child: Icon(Icons.location_on,
                                size: 35, color: AppColors.primaryColor)),
                    Positioned(
                        bottom: 200,
                        left: 10,
                        child: FloatingActionButton(
                            onPressed: () async {
                              orderDetailController
                                  .moveCameraToCurrentLocation();
                            },
                            backgroundColor: Colors.white,
                            child: const Icon(Icons.my_location_outlined,
                                color: AppColors.black, size: 30))),
                    Positioned(
                        bottom: 10,
                        left: 10,
                        right: 10,
                        child: orderDetailController
                                .locationController.value.text.isEmpty
                            ? const SizedBox()
                            : Container(
                                width: Get.width,
                                padding: const EdgeInsets.all(kPadding),
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius:
                                      BorderRadius.circular(kBorderRadius),
                                ),
                                child: Column(children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("City".tr,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                  color: AppColors.textBlack,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 16)),
                                      const SizedBox(height: 4),
                                      Obx(() => CustomDropDown(
                                            itemsList: orderDetailController
                                                .itemCityList,
                                            hint: orderDetailController
                                                .city.value.name,
                                            hintColor: Colors.black,
                                            iconColor: Colors.black,
                                            backgroundColor: Colors.grey[200],
                                            onChanged: (value) async {
                                              orderDetailController.city.value =
                                                  value!;
                                              setState(() {});
                                            },
                                          )),
                                    ],
                                  ),
                                  const SpaceH12(),
                                  CustomPrimaryButton(
                                      text: "CONTINUE".tr,
                                      onPress: () {
                                        orderDetailController.onCompliteOrder();
                                      },
                                      isDisabled:
                                          orderDetailController.isLoading.value,
                                      color: AppColors.primaryColor,
                                      textColor: AppColors.primaryTextColor)
                                ])))
                  ]))));
  }
}
