import 'package:dio/dio.dart';
import 'package:faza_app/models/send_otp_model.dart';
import 'package:faza_app/Module/auth/register/model/register_model.dart';
import 'package:faza_app/Module/setting/edit_profile/model/edit_profile_model.dart';
import '../../helper/dio_helper.dart';
import '../../Module/auth/login/model/login_model.dart';

class AuthService {
  static Future<LoginModel> loginUser(data) async {
    var response = await DioHelper.postData("auth/login", data: data);
    final responseData = LoginModel.fromJson(response.data);
    return responseData;
  }

  static Future<RegisterModel> registerUser(data) async {
    var response = await DioHelper.postData("auth/signup", data: data);
    final responseData = registerModelFromJson(response.data);
    return responseData;
  }

  static Future<VerificatoinModel> verifyOtp(Map<String, dynamic> data) async {
    var response = await DioHelper.postData("auth/verificatoin", data: data);
    final responseData = VerificatoinModel.fromJson(response.data);
    return responseData;
  }

  static Future<UpdateUserModel> updateUser(FormData data) async {
    var response =
        await DioHelper.postFormData("profile/update", formData: data);
    final responseData = updateUserModelFromJson(response.data);
    return responseData;
  }

  static Future<dynamic> deleteAccont() async {
    var response = await DioHelper.postData("account/delete");
    return response;
  }
}
