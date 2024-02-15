import 'package:faza_app/utils/values.dart';
import 'package:faza_app/Module/home/personal_shopping/personal_shopping_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';

class PersonalShoppingScreen extends StatelessWidget {
  PersonalShoppingScreen({super.key});
  var controller = Get.put(PersonalShoppingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          centerTitle: true,
          elevation: 0,
          title: Text('PERSONALSHOPPER'.tr)),
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
                            color: AppColors.primaryColor)))
                : QuillEditor(
                    scrollController: ScrollController(),
                    focusNode: FocusNode(canRequestFocus: false),
                    configurations: QuillEditorConfigurations(
                        autoFocus: false,
                        readOnly: false,
                        expands: false,
                        scrollable: true,
                        controller: controller.quillController,
                        padding: EdgeInsets.zero)))
          ],
        ),
      ),
      // ),
    );
  }
}
