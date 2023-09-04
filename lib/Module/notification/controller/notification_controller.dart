import 'package:faza_app/Module/notification/model/notification_model.dart';
import 'package:faza_app/services/APIs/notification_service.dart';
import 'package:faza_app/helper/storage_helper.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<NotificatioData> notificationList = <NotificatioData>[].obs;
  @override
  void onInit() async {
    if (StorageService.isGuestUser() == false) {
      getNotificationData();
    }
    super.onInit();
  }

  getNotificationData() async {
    isLoading.value = true;
    var response = await NotificationService.getNotificationData();
    notificationList.value = response.data!.notificatioData ?? [];
    isLoading.value = false;
  }

  // onDeleteNotification(index, id) async {
  //   showOrHideLoading(false, "REMOVING".tr);
  //   var response = await NotificationService.deleteNotification(id);
  //   showOrHideLoading(true, "REMOVING".tr);
  //   if (response["status"] == 'success') {
  //     notificationList.removeAt(index);
  //     notificationList.refresh();
  //   }
  // }

  String notificationTitle(NotificatioData notificationItem) {
    String title = notificationItem.title == 'order-active'
        ? "ORDER_ACTIVATED".tr
        : notificationItem.title == 'order-inProgress'
            ? "ORDER_IN_PROGRESS".tr
            : notificationItem.title == 'order-shipped'
                ? "ORDER_SHIPPED".tr
                : notificationItem.title == 'order-delivered'
                    ? "ORDER_DELIVERED".tr
                    : notificationItem.title == 'order-completed'
                        ? "ORDER_COMPLETED".tr
                        : notificationItem.title == 'order-cancelled'
                            ? "ORDER_CANCELLED".tr
                            : "".tr;
    return title;
  }

  String notificationContent(NotificatioData notificationItem) {
    String content = notificationItem.body == 'order-active'
        ? "YOUR_ORDER_HAS_BEEN_ACTIVATED".tr
        : notificationItem.body == 'order-inProgress'
            ? "YOUR_ORDER_HAS_BEEN_MARKED_AS_IN_PROGRESS".tr
            : notificationItem.body == 'order-shipped'
                ? "YOUR_ORDER_HAS_BEEN_SHIPPED".tr
                : notificationItem.body == 'order-delivered'
                    ? "YOUR_ORDER_HAS_BEEN_DELIVERED".tr
                    : notificationItem.body == 'order-completed'
                        ? "YOUR_ORDER_HAS_BEEN_COMPLETED".tr
                        : notificationItem.body == 'order-cancelled'
                            ? "YOUR_ORDER_HAS_BEEN_CANCELLED".tr
                            : "".tr;
    return content;
  }
}
