import 'package:faza_app/utils/values.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helper/storage_helper.dart';

changeLanguage() {
  openCustomBottomSheet([
    {
      "text": "English",
      "textColor": StorageService.getcurrentLanguage() == "en"
          ? AppColors.primaryColor
          : AppColors.black50,
      "onTap": () async {
        if (Get.isBottomSheetOpen!) Get.back();
        StorageService.writeLanguage("en");
        Get.updateLocale(const Locale("en", "US"));
        await Get.offAllNamed("/");
      },
    },
    {
      "text": "العربية",
      "textColor": StorageService.getcurrentLanguage() == "ar"
          ? AppColors.primaryColor
          : AppColors.black50,
      "onTap": () async {
        if (Get.isBottomSheetOpen!) Get.back();
        StorageService.writeLanguage("ar");
        Get.updateLocale(const Locale("ar", "SAR"));
        await Get.offAllNamed("/");
      },
    },
  ]);
}

openCustomBottomSheet(List list) {
  Get.bottomSheet(
    CustomBottomSheetForChangeLang(
      list: list,
    ),
    backgroundColor: AppColors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(kBorderRadius),
        topRight: Radius.circular(kBorderRadius),
      ),
    ),
  );
}

showCustomBottomSheet({
  required context,
  bool? isDismissible,
  String? title,
  double? height,
  required List<Widget> listOfItem,
}) {
  Get.bottomSheet(
    CustomBottomSheet(
      title: title,
      list: listOfItem,
      height: height ?? Get.height * 0.9,
    ),
    enableDrag: isDismissible ?? true,
    isDismissible: isDismissible ?? true,
    ignoreSafeArea: true,
    isScrollControlled: true,
    backgroundColor: AppColors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(kBorderRadius * 3),
        topRight: Radius.circular(kBorderRadius * 3),
      ),
    ),
  );
}

// ignore: must_be_immutable
class CustomBottomSheet extends StatelessWidget {
  CustomBottomSheet({
    Key? key,
    this.title,
    required this.height,
    required this.list,
  }) : super(key: key);

  String? title;
  double height;
  List<Widget> list;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        0,
        kPadding / 2,
        0,
        kBottomPadding(context),
      ),
      constraints: BoxConstraints(
        maxHeight: height,
      ),
      // height: height,
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: widthOfScreen(context) / 3,
                color: AppColors.greyBackground,
                height: 5,
              ),
            ),
            if (title != '') const SpaceH20(),
            Text(
              title ?? "",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            if (title != '') const SpaceH8(),
            for (int index = 0; index < list.length; index++)
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    kPadding, 0, kPadding, kPadding / 1.5),
                child: list[index],
              ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomBottomSheetForChangeLang extends StatelessWidget {
  CustomBottomSheetForChangeLang({
    Key? key,
    required this.list,
  }) : super(key: key);

  List list;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        kPadding,
        kPadding,
        kPadding,
        kBottomPadding(context),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var item in list)
            InkWell(
              onTap: item["onTap"],
              borderRadius: BorderRadius.circular(kBorderRadius),
              overlayColor: MaterialStateProperty.all(
                AppColors.primaryColor.withOpacity(.1),
              ),
              splashColor: AppColors.primaryColor.withOpacity(.1),
              focusColor: AppColors.primaryColor.withOpacity(.1),
              highlightColor: AppColors.primaryColor.withOpacity(.1),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: kPadding,
                  horizontal: kPadding / 2,
                ),
                child: Text(
                  item["text"],
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: item["textColor"],
                      ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
