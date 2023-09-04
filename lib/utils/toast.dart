import 'package:faza_app/utils/values.dart';
import 'package:faza_app/widgets/custom_button.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';

enum ToastType {
  SUCCESS,
  DANGER,
  WARNING,
}

enum ToastPosition { top, bottom }

showToast(String title, String message, ToastType type) {
  Get.snackbar(title, message,
      backgroundColor: const Color(0xFFFFFFFF),
      backgroundGradient: type == ToastType.SUCCESS
          ? const LinearGradient(colors: [
              Color(0xFF76b852),
              Color(0xFF8DC26F),
            ])
          : type == ToastType.DANGER
              ? const LinearGradient(colors: [
                  Color(0xFFf85032),
                  Color(0xFFe73827),
                ])
              : type == ToastType.WARNING
                  ? const LinearGradient(colors: [
                      Color(0xFFff9966),
                      Color(0xFFffcc00),
                    ])
                  : const LinearGradient(colors: [
                      Color(0xFF47A9FF),
                      Color(0xFF70C4CD),
                    ]),
      snackPosition: SnackPosition.TOP,
      colorText: Colors.white,
      icon: Icon(
          type == ToastType.SUCCESS
              ? EvaIcons.checkmarkCircle2Outline
              : type == ToastType.DANGER
                  ? EvaIcons.alertTriangleOutline
                  : type == ToastType.WARNING
                      ? EvaIcons.alertTriangleOutline
                      : EvaIcons.infoOutline,
          color: Colors.white));
}

showSnackBar(
    {required String message,
    ToastType? type = ToastType.SUCCESS,
    ToastPosition? position = ToastPosition.bottom}) {
  showSimpleNotification(
    Text(message),
    background: type == ToastType.SUCCESS
        ? const Color(0xFF42ba96)
        : type == ToastType.DANGER
            ? const Color(0xFFdf4759)
            : type == ToastType.WARNING
                ? const Color(0xFFff9966)
                : const Color(0xFF47A9FF),
    leading: Icon(
      type == ToastType.SUCCESS
          ? EvaIcons.checkmarkCircle2Outline
          : type == ToastType.DANGER
              ? EvaIcons.alertTriangleOutline
              : EvaIcons.infoOutline,
    ),
    duration: const Duration(seconds: 3),
    position: position == ToastPosition.top
        ? NotificationPosition.top
        : NotificationPosition.bottom,
    autoDismiss: true,
  );
}

showError(String title, String text) {
  Get.defaultDialog(title: title, content: Text(text), actions: [
    CustomTextButton(
        text: "CLOSE".tr,
        color: AppColors.grey,
        onPress: () {
          if (Get.isDialogOpen!) {
            Get.back();
          }
        })
  ]);
}
