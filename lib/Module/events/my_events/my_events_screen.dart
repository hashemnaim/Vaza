import 'package:faza_app/utils/values.dart';
import 'package:faza_app/Module/components/appbar.dart';
import 'package:faza_app/Module/events/my_events/controller/my_events_controller.dart';
import 'package:faza_app/Module/setting/profile/components/icon_btn.dart';
import 'package:faza_app/helper/storage_helper.dart';
import 'package:faza_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:skeletons/skeletons.dart';
import 'package:faza_app/widgets/custom_emply_widget.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:intl/intl.dart';
import 'package:ndialog/ndialog.dart';

class MyEventScreen extends StatelessWidget {
  const MyEventScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var myEventController = Get.put(MyEventController());

    return Scaffold(
      appBar: customAppBar("MY_EVENTS".tr),
      body: SafeArea(
          child: Obx(() => myEventController.isLoading.value
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
              : StorageService.isGuestUser() == true
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(kPadding),
                        child: CustomPrimaryButton(
                            text: "LOGIN".tr,
                            onPress: () {
                              Get.offAndToNamed('/login');
                            },
                            color: AppColors.primaryColor,
                            textColor: AppColors.white),
                      ),
                    )
                  : myEventController.eventList.isEmpty
                      ? CustomEmptyWidget(
                          title: "NO_EVENT_CREATED_YET".tr,
                          subtitle:
                              "LOOKS_LIKE_YOU_HAVEN_T_ADDED_ANYTHING_YET".tr,
                          packageImage: PackageImage.Image_1,
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.all(kPadding),
                          itemCount: myEventController.eventList.length,
                          separatorBuilder: (context, index) =>
                              const SpaceH16(),
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
                                    child: Row(children: [
                                      const Icon(
                                        EvaIcons.calendarOutline,
                                        color: AppColors.primaryColor,
                                        size: 35,
                                      ),
                                      const SpaceW12(),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Text(
                                              myEventController.eventList[index]
                                                      .personName ??
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
                                              DateFormat('dd MMMM yyyy').format(
                                                  DateTime.parse(
                                                      myEventController
                                                              .eventList[index]
                                                              .date ??
                                                          DateTime.now()
                                                              .toString())),
                                              maxLines: 1,
                                            ),
                                            Text(
                                                myEventController
                                                        .eventList[index]
                                                        .type
                                                        ?.tr ??
                                                    "",
                                                maxLines: 1),
                                          ],
                                        ),
                                      ),
                                      const SpaceW12(),
                                      Row(children: [
                                        IconBtnWithCounter(
                                          icon:
                                              const Icon(EvaIcons.editOutline),
                                          press: () {
                                            Get.toNamed(
                                              '/create-event',
                                              arguments: {
                                                "eventId": myEventController
                                                    .eventList[index],
                                              },
                                            );
                                          },
                                          iconColor: AppColors.primaryColor,
                                          backgroundColor: AppColors.whiteSmoke,
                                        ),
                                        const SpaceW8(),
                                        IconBtnWithCounter(
                                          icon: const Icon(
                                              EvaIcons.trash2Outline),
                                          press: () async {
                                            await NDialog(
                                              title: Text(
                                                "DELETE_EVENT".tr,
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                              content: Text(
                                                // ignore: prefer_interpolation_to_compose_strings
                                                "ARE_YOU_SURE_YOU_WANT_TO_REMOVE_THE"
                                                        .tr +
                                                    " ${myEventController.eventList[index].personName}",
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500,
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
                                                        text: "DELETE_EVENT".tr,
                                                        color: AppColors.red,
                                                        onPress: () {
                                                          Get.back();
                                                          myEventController
                                                              .onRemoveEvent(
                                                            index,
                                                            myEventController
                                                                .eventList[
                                                                    index]
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
                                        )
                                      ])
                                    ])));
                          }))),
      floatingActionButton: StorageService.isGuestUser() == true
          ? null
          : FloatingActionButton(
              backgroundColor: AppColors.primaryColor,
              onPressed: () {
                Get.toNamed(
                  '/create-event',
                  arguments: {
                    "eventId": null,
                  },
                );
              },
              child: const Icon(
                Icons.add,
                color: AppColors.white,
              ),
            ),
    );
  }
}
