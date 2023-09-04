import 'package:get/get.dart';

String timeConverter(String time) {
  int hourInInt = int.parse(time.substring(0, 2));
  if (hourInInt > 12) {
    return "${hourInInt - 12}:${time.substring(3, time.length)}${"PM".tr}";
  } else if (hourInInt == 0) {
    return "12:${time.substring(3, time.length)}${"AM".tr}";
  } else {
    return "$hourInInt:${time.substring(3, time.length)}${"AM".tr}";
    // return (hourInInt).toString() + "AM";
  }
}
