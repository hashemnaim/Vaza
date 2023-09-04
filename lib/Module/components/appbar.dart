import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/values.dart';

AppBar customAppBar(String text, {List<Widget>? actions}) {
  return AppBar(
    backgroundColor: AppColors.white,
    centerTitle: true,
    elevation: 0,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.black),
      onPressed: () {
        Get.back();
      },
    ),
    title: Text(
      text,
      style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(
          color: AppColors.primaryColor,
          fontWeight: FontWeight.w600,
          fontSize: 18),
    ),
    actions: actions,
  );
}
