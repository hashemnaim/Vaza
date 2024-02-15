import 'package:faza_app/utils/values.dart';
import 'package:faza_app/Module/components/appbar.dart';
import 'package:faza_app/Module/setting/profile/controller/profile_controller.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TAndCScreen extends StatelessWidget {
  const TAndCScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return Scaffold(
      appBar: customAppBar('TERMS_AND_CONDITIONS'.tr),
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
                        Obx(() => controller.termsAndContitiongData!.value == ''
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
                                focusNode: FocusNode(canRequestFocus: false),
                                configurations: QuillEditorConfigurations(
                                  scrollable: true,
                                  autoFocus: false,
                                  padding: EdgeInsets.zero,
                                  readOnly: false,
                                  expands: false,
                                  controller: controller.quillController,
                                ),
                              )),
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
