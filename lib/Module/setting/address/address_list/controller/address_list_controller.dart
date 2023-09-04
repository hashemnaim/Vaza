import 'package:faza_app/helper/loading.dart';
import 'package:faza_app/helper/storage_helper.dart';
import 'package:faza_app/services/address_service.dart';
import 'package:faza_app/utils/toast.dart';
import 'package:get/get.dart';

import '../model/address_list_model.dart';

class AddressListController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<AddressData> addressList = <AddressData>[].obs;

  @override
  void onInit() async {
    getData();
    super.onInit();
  }

  getData() async {
    isLoading.value = true;
    var response =
        await AddressService.getAddressList(StorageService.getUserId());
    addressList.value = response.addresses ?? [];

    isLoading.value = false;
  }

  onDeleteAddress(index, addressId) async {
    showOrHideLoading(false, "REMOVING".tr);
    var response = await AddressService.deleteAddress(addressId);
    showOrHideLoading(true, "REMOVING".tr);
    if (response["success"] == true) {
      addressList.removeAt(index);
      addressList.refresh();
      showToast("ADDRESS_REMOVED".tr, "YOUR_ADDRESS_REMOVED_SUCCESSFULLY".tr,
          ToastType.SUCCESS);
    }
  }
}
