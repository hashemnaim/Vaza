import 'package:faza_app/utils/values.dart';
import 'package:faza_app/Module/home/personal_shopping/personal_shopping_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:get/get.dart';

class PersonalShoppingScreen extends StatelessWidget {
  const PersonalShoppingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PersonalShoppingController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        elevation: 0,
        title: Text('PERSONALSHOPPER'.tr),
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.all(kPadding),
        child: Column(
          children: [
            Obx(() => controller.personalshoppingData!.value == ''
                ? SizedBox(
                    height: Get.height - 10,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ), // Circular loading indicator
                    ),
                  )
                : quill.QuillEditor(
                    controller: controller.quillController,
                    scrollController: ScrollController(),
                    scrollable: true,
                    focusNode: FocusNode(canRequestFocus: false),
                    autoFocus: false,
                    readOnly: false,
                    expands: false,
                    padding: EdgeInsets.zero,
                  )),
          ],
        ),
      ),
      // ),
    );
  }
}
