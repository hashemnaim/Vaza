import 'package:faza_app/Module/events/add_event/model/add_event_model.dart';
import '../../helper/dio_helper.dart';
import '../../Module/events/add_event/model/occasions_single_model.dart';

class OccasionsService {
  static Future<OccasionsSingleModel> createOccasions(
      Map<String, dynamic> data) async {
    var response = await DioHelper.postData("occasions", data: data);
    final responseData = OccasionsSingleModel.fromJson(response.data);
    return responseData;
  }

  static Future<OccasionsSingleModel> updateOccasions(
      String id, Map<String, dynamic> data) async {
    var response = await DioHelper.putData("occasions/$id", data: data);
    final responseData = OccasionsSingleModel.fromJson(response.data);
    return responseData;
  }

  static Future<OccasionsModel> removeOccasions(eventId) async {
    var response = await DioHelper.deleteData("occasions/$eventId");
    final responseData = OccasionsModel.fromJson(response.data);
    return responseData;
  }

  static Future<OccasionsModel> myOccasions() async {
    var response = await DioHelper.getData("occasions");
    final responseData = OccasionsModel.fromJson(response.data);
    return responseData;
  }
}
