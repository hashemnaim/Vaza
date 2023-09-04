import 'package:faza_app/models/admin_percentage_model.dart';
import '../../helper/dio_helper.dart';

class AdminService {
  static Future<AdminPercentageModel> getAdminSettings() async {
    var response = await DioHelper.getData("settings");
    AdminPercentageModel responseData =
        adminPercentageModelFromJson(response.data);
    return responseData;
  }

  static Future<dynamic> getTermsAndCondition() async {
    var response = await DioHelper.getData("terms-and-conditions");
    final responseData = response.data["data"]["description"];
    return responseData;
  }

  static Future<dynamic> getAbout() async {
    var response = await DioHelper.getData("about");
    final responseData = response.data["data"]["description"];
    return responseData;
  }
}
