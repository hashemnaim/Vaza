import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

import '../models/cart_model.dart';

class StorageService {
  static GetStorage getStorage = GetStorage();

  static bool isGuestUser() {
    if (getStorage.read('is_guest') != null) {
      return getStorage.read("is_guest");
    } else {
      return false;
    }
  }

  static writeIsGuest(bool value) {
    getStorage.write("is_guest", value);
  }

  static bool isIntroSeen() {
    if (getStorage.read('is_intro_seen') != null) {
      return getStorage.read("is_intro_seen");
    } else {
      return false;
    }
  }

  static writeIntroSeen(bool value) {
    getStorage.write("is_intro_seen", value);
  }

  static writeUserData(value) {
    getStorage.write("vasa_user", value);
  }

  static writeFcmToken(String value) {
    getStorage.write("fcm_token", value);
  }

  static getFcmToken() {
    if (getStorage.read('fcm_token') != null) {
      var userData = getStorage.read('fcm_token');
      return userData;
    }
  }

  static writeToken(String value) {
    getStorage.write("token", value);
  }

  static getToken() {
    if (getStorage.read('token') != null) {
      var userData = getStorage.read('token');
      return userData;
    }
  }

  static getUserData() {
    if (getStorage.read('vasa_user') != null) {
      var userData = getStorage.read('vasa_user');
      return userData;
    }
  }

  static writeLanguage(value) {
    getStorage.write("lang", value);
  }

  static getcurrentLanguage() {
    if (getStorage.read('lang') != null) {
      var userData = getStorage.read('lang');
      return userData;
    }
  }

  static clearStorage() {
    String lang = getcurrentLanguage();
    // getStorage.erase();
    Get.deleteAll();
    writeLanguage(lang);
    writeIntroSeen(true);
    writeIsGuest(true);
    // Get.offAndToNamed('/login');
  }

  static int getUserId() {
    if (getStorage.read('vasa_user') != null) {
      var userData = getStorage.read('vasa_user');
      return userData["id"];
    } else {
      return 0;
    }
  }

  static bool isCurrentLanguageIsEnglish() {
    return StorageService.getcurrentLanguage() == "en";
  }

  // ============ City ==============

  static writeCity(value) {
    getStorage.write("city", value);
  }

  static String getCity() {
    if (getStorage.read("city") != null) {
      String city = getStorage.read("city");
      return city;
    } else {
      return '';
    }
  }

  // =========== CART ===============
  static writeCartData(List<Units> data) {
    getStorage.write('cart', data);
  }

  static List<Units> getCartData() {
    if (getStorage.read('cart') != null) {
      List<Units> cartData = getStorage.read('cart');

      return cartData;
    } else {
      return <Units>[];
    }
  }

  static clearCartData() async {
    getStorage.write('cart', <Units>[]);
    getStorage.remove('cart');
    // var data = {
    //   "unit_id": StorageService.getCityId(),
    // };
    // await CartService.removeCart(data);
  }
}
