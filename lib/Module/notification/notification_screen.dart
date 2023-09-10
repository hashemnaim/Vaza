import 'package:faza_app/utils/values.dart';
import 'package:faza_app/Module/components/appbar.dart';
import 'package:faza_app/Module/notification/controller/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ndialog/ndialog.dart';
import 'package:skeletons/skeletons.dart';
import 'package:faza_app/widgets/custom_emply_widget.dart';
import 'package:empty_widget/empty_widget.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var notificationController = Get.put(NotificationController());
    return Scaffold(
        appBar: customAppBar('NOTIFICATION'.tr),
        body: SafeArea(
            child: Obx(() => notificationController.isLoading.value
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
                          ));
                    },
                    // separatorBuilder: (context, index) => const SpaceH12(),
                    itemCount: 10,
                  )
                : notificationController.notificationList.isEmpty
                    ? CustomEmptyWidget(
                        title: "NO_NOTIFICATION_CREATED_YET".tr,
                        subtitle:
                            "LOOKS_LIKE_YOU_HAVEN_T_ADDED_ANYTHING_YET".tr,
                        packageImage: PackageImage.Image_1,
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.all(kPadding),
                        itemCount:
                            notificationController.notificationList.length,
                        physics: const ClampingScrollPhysics(),
                        separatorBuilder: (context, index) => const SpaceH12(),
                        itemBuilder: (context, index) {
                          return Container(
                              width: widthOfScreen(context),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: AppColors.backgroundColor,
                                        spreadRadius: 3)
                                  ]),
                              child: Padding(
                                  padding: const EdgeInsets.all(kPadding / 2),
                                  child: Row(children: [
                                    Image.asset(
                                      'assets/img/Logo_without_background.png',
                                      height: 60,
                                      fit: BoxFit.cover,
                                    ),
                                    Expanded(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                          Text(
                                              "${notificationController.notificationList[index].title}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                      color: AppColors.black,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                          Text(
                                              notificationController
                                                  .notificationList[index]
                                                  .body!,
                                              maxLines: 2)
                                        ])),
                                    Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          notificationController
                                                      .notificationList[index]
                                                      .isRead ==
                                                  true
                                              ? const SizedBox()
                                              : GestureDetector(
                                                  onTap: () async {
                                                    await NDialog(
                                                      title: Text(
                                                          "DELETE_NOTIFICATION"
                                                              .tr,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .titleLarge!
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                      content: Text(
                                                          "ARE_YOU_SURE_YOU_WANT_TO_REMOVE_THE_NOTIFICATION"
                                                              .tr,
                                                          textAlign: TextAlign
                                                              .center,
                                                          style: Theme
                                                                  .of(context)
                                                              .textTheme
                                                              .titleMedium!
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: AppColors
                                                                      .black50)),
                                                    ).show(context);
                                                  },
                                                  child: const CircleAvatar(
                                                      radius: 6,
                                                      backgroundColor:
                                                          AppColors.red),
                                                ),
                                          const SpaceH12(),
                                          // Text(
                                          //     timeago.format(
                                          //         DateTime.parse(
                                          //             notificationController
                                          //                     .notificationList[
                                          //                         index]
                                          //                     .createdAt ??
                                          //                 DateTime.now()
                                          //                     .toString()),
                                          //         locale: StorageService.getcurrentLanguage()),
                                          //     style: Theme.of(context)
                                          //         .textTheme
                                          //         .bodySmall!
                                          //         .copyWith(
                                          //             color: AppColors.black))
                                        ])
                                  ])));
                        }))));
  }
}
