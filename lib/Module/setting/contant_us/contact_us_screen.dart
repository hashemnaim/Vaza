import 'package:faza_app/utils/values.dart';
import 'package:faza_app/Module/setting/contant_us/controller/contact_us_controller.dart';
import 'package:faza_app/widgets/custom_button.dart';
import 'package:faza_app/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../components/appbar.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var contactusController = Get.put(ContactusController());
    return Scaffold(
      appBar: customAppBar('CONNECT_WITH_US'.tr),
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
                    child: Form(
                      key: contactusController.formKey,
                      child: Column(
                        children: [
                          const SpaceH12(),
                          Image.asset(
                            'assets/img/Logo_without_background.png',
                            fit: BoxFit.cover,
                          ),
                          const SpaceH20(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const SpaceH20(),
                              Text(
                                'USERNAME'.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              CustomInput(
                                formValidator: MultiValidator([
                                  RequiredValidator(
                                      errorText: "USERNAME_IS_REQUIRED".tr),
                                ]),
                                title: '',
                                hint: "PLEASE_ENTER_THE_USERNAME".tr,
                                controller: contactusController
                                    .contactUserNameController,
                                textInputType: TextInputType.text,
                              ),
                              const SpaceH20(),
                              Text(
                                'MOBILE_NUMBER_CONACT'.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              CustomInput(
                                title: '',
                                hint: "PLEASE_ENTER_THE_NUMBER".tr,
                                textInputType: TextInputType.phone,
                                controller: contactusController
                                    .contactMobileNumberController,
                                formValidator: MultiValidator([
                                  RequiredValidator(
                                      errorText:
                                          "MOBILE_NUMBER_IS_REQUIRED".tr),
                                ]),
                              ),
                              const SpaceH20(),
                              // Text(
                              //   'SUBJECT'.tr,
                              //   style: Theme.of(context)
                              //       .textTheme
                              //       .titleMedium!
                              //       .copyWith(
                              //         fontWeight: FontWeight.bold,
                              //       ),
                              // ),
                              // CustomInput(
                              //   title: '',
                              //   hint: "PLEASE_ENTER_YOUR_SUBJECT".tr,
                              //   textInputType: TextInputType.text,
                              //   controller: contactusController
                              //       .contactSubjectController,
                              //   formValidator: MultiValidator([
                              //     RequiredValidator(
                              //         errorText: "SUBJECT_IS_REQUIREd".tr),
                              //   ]),
                              // ),
                              // const SpaceH20(),
                              Text(
                                'YOUR_LETTER'.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              CustomInput(
                                title: '',
                                minLines: 3,
                                hint: "PLEASE_ENTER_YOUR_MESSAGE".tr,
                                textInputType: TextInputType.text,
                                controller:
                                    contactusController.contactMsgController,
                                formValidator: MultiValidator([
                                  RequiredValidator(
                                      errorText: "TRY_TO_SAY_SOMETHING".tr),
                                ]),
                              ),
                              const SpaceH12(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(kPadding),
        child: CustomPrimaryButton(
          text: "SEND".tr,
          onPress: contactusController.contactUsBtn,
          color: AppColors.primaryColor,
          textColor: AppColors.primaryTextColor,
        ),
      ),
    );
  }
}
