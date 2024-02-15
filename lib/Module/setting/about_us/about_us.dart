import 'package:faza_app/utils/values.dart';
import 'package:faza_app/Module/components/appbar.dart';
import 'package:faza_app/Module/setting/about_us/controller/about_us_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
// import 'package:flutter_quill/flutter_quill.dart' as quill;

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AboutUsController());
    return Scaffold(
      appBar: customAppBar('WHO_ARE_WE'.tr),
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(kPadding),
                child: Container(
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
                    padding: const EdgeInsets.all(kPadding),
                    child: Column(
                      children: [
                        Obx(() => controller.aboutUsData!.value == ''
                            ? SizedBox(
                                height: Get.height - 10,
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.primaryColor,
                                  ), // Circular loading indicator
                                ),
                              )
                            : QuillEditor(
                                scrollController: ScrollController(),
                                configurations: QuillEditorConfigurations(
                                  scrollable: true,
                                  controller: controller.quillController,
                                  autoFocus: false,
                                  readOnly: false,
                                  expands: false,
                                  padding: EdgeInsets.zero,
                                ),
                                focusNode: FocusNode(canRequestFocus: false))),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
