import '../../helper/dio_helper.dart';

class PersonShoppingService {
  static Future<String> getPersonalShopping() async {
    var response = await DioHelper.getData("personal-shopping");
    final responseData = response.data["data"]["description"];
    return responseData;
  }
}
