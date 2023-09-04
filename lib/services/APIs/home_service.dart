import '../../helper/dio_helper.dart';
import '../../Module/home/model/slider_offer_model.dart';

class HomeService {
  static Future<SliderModel> getSliderOffer() async {
    var response = await DioHelper.getData("sliders");
    final responseData = SliderModel.fromJson(response.data);
    return responseData;
  }
}
