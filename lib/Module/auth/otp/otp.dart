import 'package:faza_app/utils/values.dart';
import 'package:faza_app/Module/auth/components/appbar.dart';
import 'package:faza_app/Module/auth/otp/controller/otp_controller.dart';
import 'package:faza_app/widgets/custom_input.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../widgets/custom_button.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var otpController = Get.put(OtpController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(130),
        child: AuthcustomAppBar(),
      ),
      body: SafeArea(
        child: Stack(
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SpaceH30(),
                              Text(
                                'ACCOUNT_ACTIVATION'.tr,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                        color: AppColors.primaryColor,
                                        fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'PLEASE_ENTER_THE_ACTIVATION_CODE'.tr,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: const Color(0XFF989898)),
                              ),
                              const SpaceH24(),
                              CustomVerificationInput(
                                onChange: (value) {
                                  otpController
                                      .verificationCodeController.value = value;
                                },
                                onSubmitted: (value) {
                                  otpController.onConfirmClick();
                                },
                              ),
                              const SpaceH24(),
                              CustomPrimaryButton(
                                text: "VERIFY".tr,
                                onPress: () async {
                                  otpController.onConfirmClick();
                                },
                                color: AppColors.primaryColor,
                                textColor: AppColors.primaryTextColor,
                              )
                            ])))),
            Positioned(
              left: -25,
              bottom: 0,
              child: Image.asset(
                'assets/img/Plant.png',
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
