import 'package:faza_app/Module/events/add_event/model/occasions_single_model.dart';
import 'package:faza_app/models/event_model.dart';
import 'package:faza_app/Module/events/my_events/controller/my_events_controller.dart';
import 'package:faza_app/helper/loading.dart';
import 'package:faza_app/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../helper/storage_helper.dart';
import '../../../../services/APIs/occasions_service.dart';

class CreateEventController extends GetxController {
  var myEventController = Get.put(MyEventController());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Rx<OccasionsData> event = OccasionsData().obs;
  Rx<int> notificationStatus = 0.obs;
  RxList<String> eventTypes = [
    "birthday",
    "wedding",
    "graduation",
  ].obs;

  RxString selectedEventType = ''.obs;
  Rx<DateTime> eventDate = DateTime.now().obs;
  TextEditingController eventNameController = TextEditingController();

  @override
  void onInit() {
    if (Get.arguments != null) {
      if (Get.arguments["eventId"] != null) {
        event.value = Get.arguments["eventId"];
        eventNameController.text = event.value.personName ?? "";
        selectedEventType.value = event.value.type ?? "";
        eventDate.value =
            DateTime.parse(event.value.date ?? DateTime.now().toString());
      }
    }
    super.onInit();
  }

  addEventClick() async {
    if (formKey.currentState!.validate()) {
      Map<String, String> data = {
        "person_name": eventNameController.text,
        "type": selectedEventType.value,
        "date": eventDate.value.toIso8601String(),
        "notification_status": notificationStatus.value.toString(),
        "user_id": StorageService.getUserId().toString(),
      };
      showOrHideLoading(
        false,
        event.value.id == null ? "ADDING_EVENT".tr : "UPDATING_EVENT".tr,
      );
      OccasionsSingleModel response;
      event.value.id == null
          ? response = await OccasionsService.createOccasions(data)
          : response = await OccasionsService.updateOccasions(
              event.value.id.toString(), data);

      showOrHideLoading(
        true,
        event.value.id == null ? "ADDING_EVENT".tr : "UPDATING_EVENT".tr,
      );

      if (response.success == true) {
        if (event.value.id != null) {
          int index = myEventController.eventList
              .indexWhere((element) => element.id == event.value.id);
          myEventController.eventList[index] = response.data!;
          myEventController.eventList.refresh();
        } else {
          myEventController.getData();
          myEventController.eventList.refresh();
        }
        Get.back();
        showToast(
            "EVENT_ADDED".tr,
            event.value.id == null
                ? "YOUR_EVENT_IS_ADDED_SUCCESSFULLY".tr
                : "YOUR_EVENT_UPDATED_SUCCESSFULLY".tr,
            ToastType.SUCCESS);
      } else {
        showToast("ERROR".tr, "SOMETHING_WENTS_WRONG".tr, ToastType.DANGER);
      }
    }
  }
}
