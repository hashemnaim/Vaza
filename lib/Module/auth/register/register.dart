import 'package:faza_app/utils/values.dart';
import 'package:faza_app/Module/auth/components/appbar.dart';
import 'package:faza_app/Module/auth/register/controller/register_controller.dart';
import 'package:faza_app/widgets/custom_input.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../../../widgets/custom_button.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var registerController = Get.put(RegisterController());
    return Stack(
      children: [
        Scaffold(
          // resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.backgroundColor,
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(130),
            child: AuthcustomAppBar(),
          ),
          body: SafeArea(
            child: Container(
              width: widthOfScreen(context),
              decoration: BoxDecoration(
                  // color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(color: AppColors.backgroundColor, spreadRadius: 3)
                  ]),
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.all(kPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SpaceH30(),
                    Text(
                      'COMPLETION_OF_DATA'.tr,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'PLEASE_ENTER_THE_FOLLOWING_INFORMATION'.tr,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: const Color(0XFF989898)),
                    ),
                    const SpaceH24(),
                    Form(
                      key: registerController.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
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
                            title: '',
                            hint: "ENTER_YOUR_NAME".tr,
                            textInputType: TextInputType.text,
                            controller: registerController.usernameController,
                            formValidator: MultiValidator([
                              RequiredValidator(
                                errorText: "USERNAME_IS_REQUIRED".tr,
                              ),
                            ]),
                          ),
                          const SpaceH20(),
                          Text(
                            'PHONE_NUMBER'.tr,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          CustomPhoneInput(
                            onCountryChange: (value) {
                              registerController.countryDialCode.value =
                                  value.dialCode;
                            },
                            onValueChange: (value) {
                              registerController.phoneController.text = value;
                            },
                            controller: registerController.phoneController,
                          ),
                          const SpaceH20(),
                          Text(
                            'EMAIL'.tr,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          CustomInput(
                            title: '',
                            hint: "ENTER_YOUR_EMAIL".tr,
                            textInputType: TextInputType.emailAddress,
                            controller: registerController.emailController,
                            formValidator: MultiValidator([
                              RequiredValidator(
                                  errorText: "EMAIL_IS_REQUIRED".tr),
                              EmailValidator(errorText: "ENTER_VALID_EMAIL".tr),
                            ]),
                          ),
                          const SpaceH16(),
                          Obx(
                            () => CheckboxListTile(
                              contentPadding: const EdgeInsets.all(0),
                              controlAffinity: ListTileControlAffinity.leading,
                              dense: true,
                              value:
                                  registerController.isAgreementChecked.value,
                              onChanged: (value) {
                                registerController.isAgreementChecked.value =
                                    value!;
                              },
                              activeColor: AppColors.primaryBlue,
                              title: Text(
                                "AGREE_TO_THE_TERMS_AND_CONDITIONS".tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                          ),
                          const SpaceH20(),
                        ],
                      ),
                    ),
                    CustomPrimaryButton(
                      text: "REGISTER".tr,
                      onPress: () {
                        registerController.onRegisterClick();
                      },
                      color: AppColors.primaryColor,
                      textColor: AppColors.primaryTextColor,
                    ),
                    const SpaceH20()
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: -25,
          bottom: 0,
          child: Image.asset(
            'assets/img/Plant.png',
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
