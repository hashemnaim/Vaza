import 'dart:developer';

import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:faza_app/utils/values.dart';
import 'package:faza_app/Module/events/add_event/controller/add_event_controller.dart';
import 'package:faza_app/widgets/custom_button.dart';
import 'package:faza_app/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../../components/appbar.dart';

class CreateEventScreen extends StatelessWidget {
  const CreateEventScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var createEventController = Get.put(CreateEventController());
    return Scaffold(
      appBar: customAppBar(
        createEventController.event.value.id == null
            ? "ADD_EVENTS".tr
            : "UPDATE_EVENT".tr,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.all(kPadding),
          child: Form(
            key: createEventController.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "NAME_OF_EVENT".tr,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                CustomInput(
                  title: "",
                  hint: "ENTER_THE_NAME_OF_EVENT".tr,
                  textInputType: TextInputType.text,
                  controller: createEventController.eventNameController,
                  formValidator: MultiValidator([
                    RequiredValidator(errorText: "EVENT_NAME_IS_REQUIRED".tr),
                  ]),
                ),
                const SpaceH12(),
                Text(
                  "EVENT_TYPE".tr,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                DropdownButtonFormField<String>(
                  validator: (value) =>
                      value == null ? 'EVENT_TYPE_IS_REQUIRED'.tr : null,
                  isExpanded: true,
                  decoration: customInputDecoration(
                    hint: "BIRTHDAY".tr,
                  ),
                  hint: Text(
                    'SELECT_EVENT_TYPE'.tr,
                  ),
                  value: createEventController.selectedEventType.value == ""
                      ? null
                      : createEventController.selectedEventType.value,
                  elevation: 16,
                  onChanged: (value) {
                    createEventController.selectedEventType.value =
                        value.toString();
                  },
                  items: createEventController.eventTypes.map((map) {
                    return DropdownMenuItem(
                      value: map,
                      child: Text(
                        map.tr,
                        style: const TextStyle(color: Colors.black),
                      ),
                    );
                  }).toList(),
                ),
                const SpaceH12(),
                Text(
                  "EVENT_DATE".tr,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                DateTimeField(
                  initialValue: createEventController.eventDate.value,
                  validator: (value) =>
                      value == null ? 'EVENT_DATE_IS_REQUIRED'.tr : null,
                  decoration: customInputDecoration(
                    hint: "DD-MMM-YYYY",
                    trailingIcon: EvaIcons.calendarOutline,
                  ),
                  format: DateFormat("dd-MMM-yyyy"),
                  onChanged: (dateTime) {
                    createEventController.eventDate.value = dateTime!;
                  },
                  onShowPicker: (context, currentValue) async {
                    final date = await showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100),
                      // locale: const Locale("ar", "SAR"),
                      confirmText: "Ok".tr,
                      cancelText: "Cancel".tr,
                      fieldLabelText: "Select Date".tr,
                      helpText: "Select Date".tr,
                    );

                    if (date != null) {
                      return DateTimeField.combine(date, null);
                    } else {
                      return currentValue;
                    }
                  },
                ),
                const SpaceH12(),
                Obx(() => SwitchListTile(
                      value: createEventController.notificationStatus.value == 1
                          ? true
                          : false,
                      title: Text("Alert for the Occasion".tr),
                      onChanged: (value) {
                        log(value.toString());
                        createEventController.notificationStatus.value =
                            value == true ? 1 : 0;
                      },
                    )),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(kPadding),
        child: Obx(
          () => CustomPrimaryButton(
            text: createEventController.event.value.id == null
                ? "ADD_EVENTS".tr
                : "UPDATE_EVENT".tr,
            onPress: () {
              createEventController.addEventClick();
            },
            color: AppColors.primaryColor,
            textColor: AppColors.white,
          ),
        ),
      ),
    );
  }
}
