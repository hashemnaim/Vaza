import 'package:faza_app/utils/values.dart';
import 'package:faza_app/Module/components/appbar.dart';
import 'package:faza_app/Module/setting/address/add_address/controller/add_address_controller.dart';
import 'package:faza_app/widgets/custom_button.dart';
import 'package:faza_app/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

class AddAddressScreen extends StatelessWidget {
  const AddAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var addAddressController = Get.put(AddAddressController());
    return Scaffold(
      appBar: customAppBar("ADD_ADDRESS".tr),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kPadding),
          child: Form(
            key: addAddressController.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "TITLE".tr,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                CustomInput(
                  hint: "ENTER_TITLE_OF_ADDRESS".tr,
                  textInputType: TextInputType.text,
                  controller: addAddressController.titleController,
                  // formValidator: MultiValidator([
                  //   RequiredValidator(errorText: "title is required"),
                  // ]),
                ),
                const SpaceH12(),
                Text(
                  "LOCATION".tr,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                GooglePlaceAutoCompleteTextField(
                  textEditingController:
                      addAddressController.locationController.value,
                  googleAPIKey: API_KEY,
                  inputDecoration: customInputDecoration(
                    hint: "ENTER_THE_LOCATION".tr,
                    trailingIcon: Icons.location_on_outlined,
                  ),
                  debounceTime: 800,
                  countries: const ["pk", "sa"],
                  isLatLngRequired: true,
                  getPlaceDetailWithLatLng: (Prediction prediction) {
                    addAddressController.latitude.value =
                        double.parse(prediction.lat ?? "");
                    addAddressController.longitude.value =
                        double.parse(prediction.lng ?? "");
                  },
                  itemClick: (Prediction prediction) {
                    addAddressController.locationController.value.text =
                        prediction.description ?? "";
                    addAddressController.locationController.value.selection =
                        TextSelection.fromPosition(
                      TextPosition(
                        offset: prediction.description?.length ?? 0,
                      ),
                    );
                  },
                ),
                const SpaceH12(),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(kBorderRadius),
                    child: Obx(
                      () => addAddressController.currentLatLng.value.latitude ==
                                  0 ||
                              addAddressController
                                      .currentLatLng.value.longitude ==
                                  0
                          ? Center(
                              child: Text("LOADING_MAP".tr),
                            )
                          : Stack(
                              children: [
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
                                      target: addAddressController
                                          .currentLatLng.value,
                                      zoom: addAddressController.zoom.value,
                                    ),
                                    onCameraMove: (position) {
                                      var lat = position.target.latitude;
                                      var lng = position.target.longitude;
                                      addAddressController.latLngAfterMapMove
                                          .value = LatLng(lat, lng);

                                      addAddressController.latitude.value = lat;
                                      addAddressController.longitude.value =
                                          lng;
                                    },
                                    onCameraIdle: () async {
                                      addAddressController
                                          .setLocationByLatLng();
                                    },
                                    onMapCreated:
                                        (GoogleMapController controller) async {
                                      if (!addAddressController
                                          .completedController
                                          .value
                                          .isCompleted) {
                                        addAddressController
                                            .completedController.value
                                            .complete(controller);
                                        addAddressController.mapController =
                                            await addAddressController
                                                .completedController
                                                .value
                                                .future;
                                      } else {
                                        addAddressController.mapController =
                                            controller;
                                      }
                                    },
                                  ),
                                ),
                                addAddressController.isLoading.value
                                    ? Positioned.fill(
                                        child: Container(
                                          width: 50,
                                          height: 50,
                                          alignment: Alignment.center,
                                          child:
                                              const CircularProgressIndicator(
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                      )
                                    : const Positioned.fill(
                                        child: Icon(
                                          Icons.location_on,
                                          size: 35,
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                              ],
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          bottom: kPadding / 2,
          right: kPadding,
          left: kPadding,
        ),
        child: CustomPrimaryButton(
          text: 'ADD_ADDRESS'.tr,
          onPress: () {
            addAddressController.onAddAddressClick();
          },
          color: AppColors.primaryColor,
          textColor: AppColors.primaryTextColor,
        ),
      ),
    );
  }
}
