import 'package:faza_app/utils/values.dart';
import 'package:faza_app/Module/auth/components/appbar.dart';
import 'package:faza_app/Module/auth/login/controller/login_controller.dart';
import 'package:faza_app/widgets/custom_input.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../widgets/custom_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var loginController = Get.put(LoginController());
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.backgroundColor,
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(130), child: AuthcustomAppBar()),
        body: SafeArea(
            child: Stack(children: [
          Container(
              padding: const EdgeInsets.all(kPadding),
              width: widthOfScreen(context),
              height: heightOfScreen(context),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(color: AppColors.backgroundColor, spreadRadius: 3)
                  ]),
              child: Padding(
                  padding: const EdgeInsets.all(kPadding),
                  child: Form(
                      key: loginController.formKey,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SpaceH30(),
                            Text('LOGIN'.tr,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                        color: AppColors.primaryColor,
                                        fontWeight: FontWeight.bold)),
                            // Text('PLEASE_LOGIN'.tr,
                            //     textAlign: TextAlign.center,
                            //     style: Theme.of(context)
                            //         .textTheme
                            //         .titleMedium!
                            //         .copyWith(color: const Color(0XFF989898))),
                            const SpaceH36(),
                            Text('PHONE_NUMBER'.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontWeight: FontWeight.bold)),
                            CustomPhoneInput(
                                onCountryChange: (value) {
                                  loginController.countryDialCode.value =
                                      value.dialCode;
                                },
                                controller: loginController.phoneController,
                                onValueChange: (val) {
                                  loginController.phoneController.text = val;
                                }),
                            const SpaceH30(),
                            CustomPrimaryButton(
                                text: "LOGIN".tr,
                                onPress: () async {
                                  loginController.onLoginClick(context);
                                },
                                color: AppColors.primaryColor,
                                textColor: AppColors.primaryTextColor),
                            const SpaceH20(),
                            // CustomPrimaryButton(
                            //   text: "GUEST_ACCOUNT".tr,
                            //   isOutlined: true,
                            //   onPress: () async {
                            //     loginController.loginAsGuest();
                            //   },
                            //   color: AppColors.primaryColor,
                            //   textColor: AppColors.primaryColor,
                            // ),
                            const SpaceH20(),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("DON_T_HAVE_AN_ACCOUNT".tr,
                                      style: const TextStyle(
                                          color: Color(0XFF989898))),
                                  GestureDetector(
                                      onTap: () async {
                                        await Get.toNamed("/register");
                                      },
                                      child: Text("SIGN_UP".tr,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  color: AppColors.primaryColor,
                                                  fontWeight: FontWeight.bold)))
                                ])
                          ])))),
          Positioned(
              left: -25,
              bottom: 0,
              child: Image.asset('assets/img/Plant.png', fit: BoxFit.cover))
        ])));
  }
}
