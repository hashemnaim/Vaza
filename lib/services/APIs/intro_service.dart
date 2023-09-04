import 'package:dio/dio.dart';
import 'package:faza_app/Module/auth/intro/model/intro_model.dart';
import '../../helper/dio_helper.dart';

class IntroService {
  static var dio = Dio();

  static Future<IntroSliderModel> getIntroSlides() async {
    var response = await DioHelper.getData("intro-sliders");
    final responseData = IntroSliderModel.fromJson(response.data);
    return responseData;
  }
}
