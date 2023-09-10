import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:faza_app/utils/values.dart';
import 'package:faza_app/Module/setting/profile/components/icon_btn.dart';
import 'package:faza_app/Module/setting/profile/controller/profile_controller.dart';
import 'package:faza_app/helper/storage_helper.dart';
import 'package:faza_app/widgets/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../widgets/custom_svg.dart';
import 'components/card_setting.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var profileController = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.cardColor,
        // centerTitle: true,
        elevation: 0,
        title: Text("PROFILE".tr,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: AppColors.black, fontSize: 18)),
        actions: <Widget>[
          IconBtnWithCounter(
            icon: const Padding(
              padding: EdgeInsets.all(6.0),
              child: CustomSvgImage("bag"),
            ),
            press: () async {
              Get.toNamed('/cart');
            },
            iconColor: AppColors.primaryColor,
            backgroundColor: Colors.transparent,
          ),
          IconBtnWithCounter(
            icon: const Padding(
                padding: EdgeInsets.all(6.0),
                child: CustomSvgImage("notification")),
            press: () {
              Get.toNamed('/notification');
            },
            iconColor: Colors.black,
            backgroundColor: Colors.transparent,
          ),
        ],
      ),
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.all(kPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "MY_ACCOUNT_INFO".tr,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold, color: AppColors.grey),
              ),
              const SizedBox(
                height: 8,
              ),
              StorageService.isGuestUser() == false
                  ? accountInfo(context)
                  : ListCard(
                      context: context,
                      icon: const Icon(
                        Icons.person_outline_outlined,
                      ),
                      text: 'GUEST_USER'.tr,
                      onTap: () {
                        Get.toNamed('/login');
                        // StorageService.clearStorage();
                      },
                      trailingText: "LOGIN".tr,
                    ),
              const SpaceH16(),
              Text(
                "GENERAL_SETTING".tr,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold, color: AppColors.grey),
              ),
              const SpaceH8(),
              Container(
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
                child: Column(
                  children: [
                    ListCard(
                      context: context,
                      icon: const Icon(
                        Icons.language_outlined,
                      ),
                      text: 'LANGUAGE'.tr,
                      onTap: () {
                        changeLanguage();
                      },
                      trailingText: StorageService.getcurrentLanguage() == "en"
                          ? "English"
                          : "العربية",
                    ),
                    if (StorageService.isGuestUser() == false)
                      ListCard(
                          context: context,
                          icon: const Icon(
                            EvaIcons.close,
                          ),
                          text: 'DELETE_ACCOUNT'.tr,
                          onTap: () {
                            profileController.deleteAccount();
                          },
                          trailingText: '')
                  ],
                ),
              ),
              const SpaceH16(),
              Text(
                "GENERAL_INFORMATION".tr,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold, color: AppColors.grey),
              ),
              const SpaceH8(),
              Container(
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
                child: Column(
                  children: [
                    if (StorageService.isGuestUser() == false)
                      ListCard(
                        context: context,
                        icon: const Icon(
                          EvaIcons.phoneCallOutline,
                        ),
                        onTap: () async {
                          await Get.toNamed("/contact-us");
                        },
                        text: "CONTACT_WITH_US".tr,
                        trailingText: "",
                      ),
                    ListCard(
                      context: context,
                      icon: const Icon(
                        EvaIcons.shieldOutline,
                      ),
                      onTap: () async {
                        await Get.toNamed('/T&C');
                      },
                      text: "TERMS_AND_CONDITION".tr,
                      trailingText: "",
                    ),
                    ListCard(
                      context: context,
                      icon: const Icon(
                        EvaIcons.questionMarkCircle,
                      ),
                      onTap: () async {
                        // await Get.toNamed('/intro');
                        await Get.toNamed('/about-us');
                      },
                      text: "ABOUT_THIS_APP".tr,
                      trailingText: "",
                    ),
                    ListCard(
                      context: context,
                      icon: const Icon(
                        EvaIcons.logOutOutline,
                      ),
                      onTap: () {
                        StorageService.clearStorage();

                        Get.toNamed('/login');
                      },
                      text: StorageService.isGuestUser()
                          ? "LOGIN".tr
                          : "LOG_OUT".tr,
                      trailingText: "",
                    ),
                  ],
                ),
              ),
              const SpaceH16(),
              const SpaceH8(),
              Container(
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
                child: Column(
                  children: [
                    ListCard(
                      context: context,
                      icon: const Icon(
                        FontAwesomeIcons.whatsapp,
                        color: Colors.green,
                      ),
                      onTap: () async {
                        String whatsappurlAndroid =
                            "https://api.whatsapp.com/send?phone=966500389343";
                        await canLaunch(whatsappurlAndroid)
                            ? launch(whatsappurlAndroid)
                            : ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      "WhatsApp is not installed on the device"),
                                ),
                              );
                      },
                      text: "WHATS_APP".tr,
                      trailingText: "",
                    ),
                    ListCard(
                      context: context,
                      icon: const Icon(
                        FontAwesomeIcons.instagram,
                        color: Color(0xFFC13584),
                      ),
                      onTap: () async {
                        String instagramurlAndroid =
                            "https://instagram.com/vaza_fllower?igshid=YmMyMTA2M2Y=";
                        await canLaunch(instagramurlAndroid)
                            ? launch(instagramurlAndroid)
                            : ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      "instagram is not installed on the device"),
                                ),
                              );
                      },
                      text: "INSTAGRAM".tr,
                      trailingText: "",
                    ),
                    ListCard(
                      context: context,
                      icon: const Icon(
                        FontAwesomeIcons.twitter,
                        color: Color(0xFF1DA1F2),
                      ),
                      onTap: () async {
                        String twitterurlAndroid =
                            "https://twitter.com/vazaflower?s=21&t=4JDSYmVozQ9IIboSlnatCw";
                        await canLaunch(twitterurlAndroid)
                            ? launch(twitterurlAndroid)
                            : ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      "twitter is not installed on the device"),
                                ),
                              );
                      },
                      text: "TWITTER".tr,
                      trailingText: "",
                    ),
                    ListCard(
                      context: context,
                      icon: const Icon(
                        FontAwesomeIcons.tiktok,
                        color: Colors.black,
                      ),
                      onTap: () async {
                        String tiktokurlAndroid =
                            "https://www.tiktok.com/@vaza_fllower?_t=8XLuenmniWz&_r=1";
                        await canLaunch(tiktokurlAndroid)
                            ? launch(tiktokurlAndroid)
                            : ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      "tiktok is not installed on the device"),
                                ),
                              );
                      },
                      text: "TIKTOK".tr,
                      trailingText: "",
                    ),
                    ListCard(
                      context: context,
                      icon: const Icon(
                        FontAwesomeIcons.snapchat,
                        color: Colors.black,
                      ),
                      onTap: () async {
                        String snapchaturlAndroid =
                            "https://www.snapchat.com/add/vazaflowers22?share_id=IX_wymNvggc&locale=en-US";
                        await canLaunch(snapchaturlAndroid)
                            ? launch(snapchaturlAndroid)
                            : ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      "snapchat is not installed on the device"),
                                ),
                              );
                      },
                      text: "SNAPCHAT".tr,
                      trailingText: "",
                    ),
                  ],
                ),
              ),
              const SpaceH48(),
              const SpaceH8(),
            ],
          ),
        ),
      ),
    );
  }

  Widget accountInfo(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
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
          child: Column(
            children: [
              ListCard(
                  context: context,
                  icon: const Icon(
                    EvaIcons.edit2Outline,
                  ),
                  onTap: () async {
                    await Get.toNamed("/edit-profile");
                  },
                  text: "PROFILE".tr,
                  trailingText: ''),
              ListCard(
                  context: context,
                  icon: const Icon(
                    EvaIcons.fileTextOutline,
                  ),
                  onTap: () async {
                    await Get.toNamed("/order-list");
                  },
                  text: "MY_REQUESTS".tr,
                  trailingText: ''),
              ListCard(
                  context: context,
                  icon: const Icon(
                    EvaIcons.pinOutline,
                  ),
                  onTap: () async {
                    await Get.toNamed('/address-list');
                  },
                  text: "MY_ADDRESS".tr,
                  trailingText: '')
            ],
          ),
        ),
      ],
    );
  }
}
