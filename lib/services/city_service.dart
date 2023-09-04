
import 'package:faza_app/Module/home/model/available_cities_model.dart';
import '../../helper/dio_helper.dart';

class CityService {
  static Future<AvailbleCitiesModel> getAvailbleCities() async {
    var response = await DioHelper.getData("cities");
    final responseData = availbleCitiesModelFromJson(response.data);
    return responseData;
  }


}
