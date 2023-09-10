import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:faza_app/Module/order/order_detail/select_time_delivary.dart';
import 'package:faza_app/utils/values.dart';
import 'package:faza_app/Module/components/appbar.dart';
import 'package:faza_app/Module/order/order_detail/controller/order_detail_controller.dart';
import 'package:faza_app/widgets/custom_button.dart';
import 'package:faza_app/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
// import 'package:date_time_picker/date_time_picker.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var orderDetailController = Get.put(OrderDetailController());
    final format = DateFormat("yyyy-MM-dd");

    return Scaffold(
      appBar: customAppBar('COMPLETE_THE_APPLICATION'.tr),
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
              padding: const EdgeInsets.all(kPadding),
              child: Form(
                  key: orderDetailController.formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text("DELIVERY_DATE_TIME".tr,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryColor)),
                        const SpaceH8(),
                        DateTimeField(
                          format: format,
                          decoration: InputDecoration(
                              suffixIcon: const Icon(
                                Icons.calendar_month_outlined,
                                color: AppColors.black,
                              ),
                              labelStyle: const TextStyle(
                                color: AppColors.black50,
                              ),
                              hintText: "DELIVERY_DATE_TIME".tr,
                              hintStyle: const TextStyle(
                                color: AppColors.black50,
                              ),
                              filled: true,
                              fillColor: AppColors.backgroundColor,
                              contentPadding:
                                  const EdgeInsets.all(kPadding / 2),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(kBorderRadius),
                                borderSide: const BorderSide(
                                  color: AppColors.black50,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(kBorderRadius),
                                borderSide: const BorderSide(
                                  color: AppColors.greyShade3,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(kBorderRadius),
                                borderSide: const BorderSide(
                                  color: AppColors.grey50,
                                ),
                              )),
                          onShowPicker: (context, currentValue) async {
                            orderDetailController.deliveryDate.value =
                                await showDatePicker(
                                        context: context,
                                        firstDate: DateTime.now(),
                                        initialDate: orderDetailController
                                            .deliveryDate.value,
                                        lastDate: DateTime(2100),
                                        cancelText: "CANCEL".tr,
                                        confirmText: "Ok".tr) ??
                                    orderDetailController.deliveryDate.value;
                            return orderDetailController.deliveryDate.value;
                          },
                        ),
                        // InkWell(
                        //   onTap: () async {
                        //     //                           orderDetailController.deliveryDate.value =
                        //     //                               await showDatePicker(
                        //     //                                     context: context,
                        //     //                                     firstDate: DateTime.now(),
                        //     //                                     initialDate: orderDetailController
                        //     //                                         .deliveryDate.value,
                        //     //                                     lastDate: DateTime(2100),
                        //     //                                   ) ??
                        //     //                                   DateTime.now();
                        //   },
                        //   child: Obx(() => CustomInput(
                        //         title: orderDetailController
                        //             .deliveryDate.value
                        //             .toString(),
                        //         hint: "DELIVERY_DATE_TIME".tr,
                        //         textInputType: TextInputType.datetime,
                        //         onTap: () {},
                        //         isEnabled: false,
                        //         icon: Icons.calendar_month_outlined,
                        //         formValidator: MultiValidator([
                        //           RequiredValidator(
                        //               errorText:
                        //                   "DELIVERY_DATE_IS_REQUIRED".tr),
                        //         ]),
                        //       )),
                        // ),
                        const SpaceH12(),

                        Obx(() => AnimatedSwitcher(
                              duration: const Duration(seconds: 1),
                              child: orderDetailController.isDelivary.value ==
                                      true
                                  ? Container()
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("PICK_DELIVERY_TIME".tr,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors
                                                        .primaryColor)),
                                        const SpaceH8(),
                                        SizedBox(
                                            height: 50,
                                            width: Get.width,
                                            child: const TimeFilterScreen()),
                                      ],
                                    ),
                            )),
                        const SpaceH16(),

                        Row(
                          children: [
                            const Expanded(
                              child: Divider(
                                color: Colors.grey,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Text("Or".tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primaryColor)),
                            ),
                            const Expanded(
                              child: Divider(
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                        Obx(() => ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Row(
                                children: [
                                  Checkbox(
                                      activeColor: AppColors.primaryColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      value: orderDetailController
                                          .isDelivary.value,
                                      onChanged: (value) {
                                        orderDetailController.isDelivary.value =
                                            value!;
                                      }),
                                  const SpaceW4(),
                                  Text("instantDelivery".tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.primaryColor)),
                                ],
                              ),
                            )),
                        const SpaceH12(),
                        Text("RECIPIENT_S_NAME".tr,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryColor)),
                        const SpaceH8(),

                        CustomInput(
                          title: "",
                          hint: "PLEASE_ENTER_THE_NAME".tr,
                          textInputType: TextInputType.text,
                          controller: orderDetailController.nameController,
                          formValidator: MultiValidator([
                            RequiredValidator(
                                errorText: "RECIPIENT_NAME_IS_REQUIRED".tr),
                          ]),
                        ),
                        const SpaceH12(),
                        Text(
                          "RECIPIENT_S_MOBILE_NUMBER".tr,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryColor,
                                  ),
                        ),
                        const SpaceH8(),
                        Container(
                          color: Colors.transparent,
                          child: CustomPhoneInput(
                            onCountryChange: (value) {
                              orderDetailController.countryDialCode.value =
                                  value.dialCode;
                            },
                            controller: orderDetailController.phoneController,
                            onValueChange: (value) {
                              orderDetailController.phoneNumber.value = value;
                            },
                          ),
                        ),
                        const SpaceH12(),
                        Text(
                          "MESSAGE_TO_THE_RECIPIENT_S_OPTIONAL".tr,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor),
                        ),
                        const SpaceH8(),

                        CustomInput(
                            title: "",
                            hint: "PLEASE_ENTER_THE_MESSAGE".tr,
                            textInputType: TextInputType.text,
                            minLines: 3,
                            controller:
                                orderDetailController.messageController),
                        const SpaceH12()
                      ])))),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: CustomPrimaryButton(
          text: "CONTINUE".tr,
          onPress: () async {
            orderDetailController.onContinueClick();
          },
          color: AppColors.primaryColor,
          textColor: AppColors.primaryTextColor,
        ),
      ),
    );
  }
}
//#Dad Code
  // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Text(
                            //       "DELIVERY_LOCATION_OPTIONAL".tr,
                            //       style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            //             fontWeight: FontWeight.bold,
                            //             color: AppColors.primaryColor,
                            //           ),
                            //     ),
                            //     Obx(
                            //       () => CustomTextButton(
                            //         text: "PICK_ADDRESS".tr,
                            //         enable: orderDetailController.addressList.isNotEmpty,
                            //         color: AppColors.primaryColor,
                            //         onPress: () {
                            //           showCustomBottomSheet(
                            //             context: context,
                            //             title: "MY_ADDRESS".tr,
                            //             listOfItem: [
                            //               for (int index = 0;
                            //                   index <
                            //                       orderDetailController
                            //                           .addressList.length;
                            //                   index++)
                            //                 Obx(
                            //                   () => RadioListTile(
                            //                     value: orderDetailController
                            //                         .addressList[index].id,
                            //                     groupValue:
                            //                         orderDetailController.addressId.value,
                            //                     onChanged: (ind) {
                            //                       orderDetailController.addressId.value =
                            //                           int.parse(ind.toString());

                            //                       orderDetailController.locationController
                            //                           .value.text = orderDetailController
                            //                               .addressList[index].latitude ??
                            //                           "";
                            //                       var lat = double.parse(
                            //                           orderDetailController
                            //                               .addressList[index].latitude
                            //                               .toString());
                            //                       var lng = double.parse(
                            //                           orderDetailController
                            //                               .addressList[index].longitude
                            //                               .toString());
                            //                       orderDetailController.latLngAfterMapMove
                            //                           .value = LatLng(lat, lng);

                            //                       // orderDetailController.latitude.value =
                            //                       //     orderDetailController
                            //                       //         .addressList[index].lat
                            //                       //         .toString();

                            //                       // orderDetailController.longitude.value =
                            //                       //     orderDetailController
                            //                       //         .addressList[index].lng
                            //                       //         .toString();
                            //                       if (Get.isBottomSheetOpen!) Get.back();
                            //                     },
                            //                     controlAffinity:
                            //                         ListTileControlAffinity.trailing,
                            //                     title: Text(
                            //                       orderDetailController
                            //                               .addressList[index].address ??
                            //                           "",
                            //                       style: Theme.of(context)
                            //                           .textTheme
                            //                           .bodyLarge!
                            //                           .copyWith(
                            //                             color: AppColors.black,
                            //                             fontWeight: FontWeight.bold,
                            //                           ),
                            //                     ),
                            //                     subtitle: Text(
                            //                       orderDetailController
                            //                               .addressList[index].street ??
                            //                           "",
                            //                       style: Theme.of(context)
                            //                           .textTheme
                            //                           .bodyMedium!
                            //                           .copyWith(
                            //                             color: AppColors.black,
                            //                           ),
                            //                     ),
                            //                     contentPadding:
                            //                         const EdgeInsets.symmetric(
                            //                       horizontal: kPadding / 2,
                            //                     ),
                            //                     dense: true,
                            //                     activeColor: AppColors.primaryColor,
                            //                     selectedTileColor: AppColors.primaryColor
                            //                         .withOpacity(.5),
                            //                     shape: RoundedRectangleBorder(
                            //                       borderRadius: BorderRadius.circular(
                            //                           kBorderRadius),
                            //                       side: const BorderSide(
                            //                         color: AppColors.primaryColor,
                            //                       ),
                            //                     ),
                            //                   ),
                            //                 ),
                            //             ],
                            //           );
                            //         },
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // Obx(
                            //   () => GooglePlaceAutoCompleteTextField(
                            //     textEditingController:
                            //         orderDetailController.locationController.value,
                            //     googleAPIKey: API_KEY,
                            //     inputDecoration: customInputDecoration(
                            //       hint: "ENTER_THE_LOCATION".tr,
                            //       trailingIcon: Icons.location_on_outlined,
                            //       onTrailingIconClick: () {
                            //         Get.to(() => const MapScreen(),
                            //             transition: Transition.downToUp);
                            //       },
                            //       borderColor:
                            //           orderDetailController.deliveryLocationRequired.value
                            //               ? AppColors.dangerRed
                            //               : null,
                            //     ),
                            //     debounceTime: 800,
                            //     countries: const ["pk", "sa"],
                            //     isLatLngRequired: true,
                            //     getPlaceDetailWithLatLng: (Prediction prediction) {
                            //       var lat = double.parse(prediction.lat ?? "");
                            //       var lng = double.parse(prediction.lng ?? "");
                            //       orderDetailController.latLngAfterMapMove.value =
                            //           LatLng(lat, lng);
                            //       orderDetailController.addressId.value = 0;
                            //     },
                            //     itmClick: (Prediction prediction) {
                            //       orderDetailController.locationController.value.text =
                            //           prediction.description ?? "";
                            //       orderDetailController.locationController.value
                            //           .selection = TextSelection.fromPosition(
                            //         TextPosition(
                            //           offset: prediction.description?.length ?? 0,
                            //         ),
                            //       );
                            //     },
                            //   ),
                            // ),

                            // Obx(
                            //   () => (orderDetailController.deliveryLocationRequired.value)
                            //       ? Padding(
                            //           padding: const EdgeInsets.only(
                            //             top: kPadding / 3,
                            //             right: kPadding / 2,
                            //             left: kPadding / 2,
                            //           ),
                            //           child: Text(
                            //             "LOCATION_IS_REQUIRED".tr,
                            //             style: Theme.of(context)
                            //                 .textTheme
                            //                 .bodySmall!
                            //                 .copyWith(
                            //                   color: AppColors.dangerRed,
                            //                 ),
                            //           ),
                            //         )
                            //       : const SizedBox(),
                            // ),
                            // const SpaceH12(),
                            // BasicDateField()
                            // Text("DELIVERY_DATE_TIME".tr,
                            //     style: Theme.of(context)
                            //         .textTheme
                            //         .bodyLarge!
                            //         .copyWith(
                            //             fontWeight: FontWeight.bold,
                            //             color: AppColors.primaryColor)),
                            // DateTimePicker(
                            //   expands: false,
                            //   enableSuggestions: false,

                            //   type: DateTimePickerType.date,
                            //   dateMask: 'dd, MMM, yyyy',
                            //   firstDate: DateTime.now(),
                            //   lastDate: DateTime(2100),
                            //   timePickerEntryModeInput: false,

                            //   cancelText: "CANCEL".tr,
                            //   confirmText: "CONFIRM".tr,
                            //   dateHintText: "PICK_DELIVERY_DATE".tr,
                            //   timeHintText: "PICK_DELIVERY_TIME".tr,
                            //   dateLabelText: "DELIVERY_DATE".tr,
                            //   fieldHintText: "DELIVERY_DATE".tr,
                            //   fieldLabelText: "DELIVERY_DATE".tr,
                            //   timeLabelText: "DELIVERY_TIME".tr,
                            //   cursorColor: AppColors.primaryColor,

                            //   calendarTitle: "",
                            //   initialDatePickerMode: DatePickerMode.day,
                            //   style: const TextStyle(
                            //       color: AppColors.primaryColor),
                            //   decoration: customInputDecoration(
                            //     hint: "PICK_DELIVERY_DATE".tr,
                            //     trailingIcon: Icons.calendar_month_outlined,
                            //   ),
                            //   onChanged: (val) {
                            //     orderDetailController.deliveryDate.value = val;
                            //   },
                            //   validator: (value) => value == ''
                            //       ? 'DELIVERY_DATE_IS_REQUIRED'.tr
                            //       : null,
                            //   // ignore: avoid_print
                            //   onSaved: (val) => print(val),
                            // ),