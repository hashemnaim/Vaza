import 'package:faza_app/Module/setting/address/add_address/model/add_address_model.dart';
import 'package:faza_app/Module/setting/address/address_list/model/address_list_model.dart';
import '../../Module/home/model/available_cities_model.dart';
import '../../helper/dio_helper.dart';

class AddressService {
  static Future<AddressListModel> getAddressList(userId) async {
    var response = await DioHelper.getData("user-address");
    final responseData = addressListModelFromJson(response.data);
    return responseData;
  }

  static Future<AddAddressModel> addAddress(data) async {
    var response = await DioHelper.postData("user-address", data: data);
    final responseData = addAddressModelFromJson(response.data);
    return responseData;
  }

  static Future<dynamic> deleteAddress(addressId) async {
    var response = await DioHelper.deleteData("user-address/$addressId");
    var json = response.data;
    return json;
  }

    static Future<AvailbleCitiesModel> getAvailbleCities() async {
    var response = await DioHelper.getData("cities");
    final responseData = availbleCitiesModelFromJson(response.data);
    return responseData;
  }
}
