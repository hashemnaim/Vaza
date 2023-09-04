import 'package:faza_app/Module/notification/model/notification_model.dart';

import '../../helper/dio_helper.dart';

class NotificationService {
  static Future<NotificationModel> getNotificationData() async {
    var response = await DioHelper.getData("user/notifications");
    final responseData = NotificationModel.fromJson(response.data);
    return responseData;
  }


}
