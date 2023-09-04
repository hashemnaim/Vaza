import 'package:faza_app/Module/setting/contant_us/model/contact_us_model.dart';
import '../../helper/dio_helper.dart';

class ContactUsService {
  static Future<ContactUsModel> createContactUs(data) async {
    var response = await DioHelper.postData("contact", data: data);
    final responseData = contactUsModelFromJson(response.data);
    return responseData;
  }
}
