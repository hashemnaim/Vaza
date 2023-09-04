import 'package:faza_app/utils/values.dart';
import 'package:faza_app/Module/components/appbar.dart';
import 'package:faza_app/Module/setting/address/address_list/controller/address_list_controller.dart';
import 'package:faza_app/Module/setting/profile/components/icon_btn.dart';
import 'package:faza_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:faza_app/widgets/custom_emply_widget.dart';
import 'package:skeletons/skeletons.dart';
import 'package:ndialog/ndialog.dart';

class AddressListScreen extends StatelessWidget {
  const AddressListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var addressListController = Get.put(AddressListController());

    return Scaffold(
      appBar: customAppBar("MY_ADDRESSES".tr),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          Get.toNamed('/add-address');
        },
        child: const Icon(
          Icons.add,
          color: AppColors.white,
        ),
      ),
      body: SafeArea(
        child: Obx(
          () => addressListController.isLoading.value
              ? ListView.separated(
                  padding: const EdgeInsets.all(kPadding),
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => const SpaceH16(),
                  itemBuilder: (context, index) {
                    return Container(
                      width: widthOfScreen(context),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: AppColors.backgroundColor,
                            spreadRadius: 3,
                          ),
                        ],
                      ),
                      child: SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                          height: 90,
                          width: widthOfScreen(context),
                        ),
                      ),
                    );
                  },
                  // separatorBuilder: (context, index) => const SpaceH12(),
                  itemCount: 10,
                )
              : addressListController.addressList.isEmpty
                  ? CustomEmptyWidget(
                      title: "NO_ADDRESS_CREATED_YET".tr,
                      subtitle: "LOOKS_LIKE_YOU_HAVEN_T_ADDED_ANYTHING_YET".tr,
                      // packageImage: PackageImage.Image_1,
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.all(kPadding),
                      itemCount: addressListController.addressList.length,
                      separatorBuilder: (context, index) => const SpaceH16(),
                      itemBuilder: (context, index) {
                        return Container(
                          width: widthOfScreen(context),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: AppColors.backgroundColor,
                                spreadRadius: 3,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(kPadding / 2),
                            child: Row(
                              children: [
                                const Icon(
                                  EvaIcons.pinOutline,
                                  color: AppColors.primaryColor,
                                ),
                                const SpaceW12(),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        addressListController
                                                .addressList[index].address ??
                                            "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              color: AppColors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      Text(
                                        addressListController
                                                .addressList[index].street ??
                                            "",
                                        maxLines: 2,
                                      ),
                                    ],
                                  ),
                                ),
                                const SpaceW12(),
                                Row(
                                  children: [
                                    // IconBtnWithCounter(
                                    //   icon: EvaIcons.editOutline,
                                    //   press: () {},
                                    //   iconColor: AppColors.primaryColor,
                                    //   backgroundColor: AppColors.whiteSmoke,
                                    // ),
                                    // const SpaceW8(),
                                    IconBtnWithCounter(
                                      icon: const Icon(EvaIcons.trash2Outline),
                                      press: () async {
                                        await NDialog(
                                          title: Text(
                                            "DELETE_ADDRESS".tr,
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge!
                                                .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          content: Text(
                                            "${"ARE_YOU_SURE_YOU_WANT_TO_REMOVE_THE".tr} ${addressListController.addressList[index].address}",
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.black50,
                                                ),
                                          ),
                                          actions: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: CustomTextButton(
                                                    text: "CANCEL".tr,
                                                    color: AppColors.grey,
                                                    onPress: () {
                                                      Get.back();
                                                    },
                                                  ),
                                                ),
                                                Expanded(
                                                  child: CustomTextButton(
                                                    text: "DELETE_ADDRESS".tr,
                                                    color: AppColors.red,
                                                    onPress: () {
                                                      Get.back();
                                                      addressListController
                                                          .onDeleteAddress(
                                                        index,
                                                        addressListController
                                                            .addressList[index]
                                                            .id,
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ).show(context);
                                      },
                                      iconColor: Colors.red,
                                      backgroundColor: AppColors.whiteSmoke,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
        ),
      ),
    );
  }
}
