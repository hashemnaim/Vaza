import 'package:flutter_easyloading/flutter_easyloading.dart';

showOrHideLoading(bool wantToHide,value) async {
  if (wantToHide) {
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
  } else {
    EasyLoading.show(
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
      status: value,
    );

    await Future.delayed(const Duration(seconds: 21));
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
  }
}
