import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/values.dart';
import '../../../widgets/custom_svg.dart';

class AuthcustomAppBar extends StatelessWidget {
  const AuthcustomAppBar({Key? key}) : super(key: key);

  @override
  AppBar build(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 130,
        title: const CustomSvgImage('logo',
            isColor: true, color: Colors.white, height: 100, width: 100),
        leading: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          const SizedBox(height: 16),
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios))
        ]));
  }
}
