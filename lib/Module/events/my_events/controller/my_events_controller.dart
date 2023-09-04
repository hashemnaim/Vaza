import 'package:faza_app/models/event_model.dart';
import 'package:faza_app/services/APIs/occasions_service.dart';
import 'package:faza_app/helper/loading.dart';
import 'package:faza_app/utils/toast.dart';
import 'package:get/get.dart';

class MyEventController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<OccasionsData> eventList = <OccasionsData>[].obs;

  @override
  void onInit() async {
    getData();
    super.onInit();
  }

  getData() async {
    isLoading.value = true;
    var response = await OccasionsService.myOccasions();
    eventList.value = response.data ?? [];
    isLoading.value = false;
  }

  onRemoveEvent(index, id) async {
    showOrHideLoading(false, "");
    var response = await OccasionsService.removeOccasions(id);
    showOrHideLoading(true, "REMOVING".tr);
    if (response.success == true) {
      eventList.removeAt(index);
      eventList.refresh();
      showToast("EVENT_REMOVED".tr, "YOUR_EVENT_REMOVED_SUCCESSFULLY".tr,
          ToastType.SUCCESS);
    }
  }
}
