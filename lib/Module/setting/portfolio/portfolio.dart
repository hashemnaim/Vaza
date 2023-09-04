import 'package:faza_app/utils/values.dart';
import 'package:faza_app/Module/components/appbar.dart';
import 'package:faza_app/Module/setting/portfolio/controller/protfolio_controller.dart';
import 'package:faza_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var protfolioController = Get.put(ProfolioController());
    return Scaffold(
      appBar: customAppBar('Portfolio'),
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Obx(
            () => Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(kPadding),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(kPadding),
                        child: SizedBox(
                          width: widthOfScreen(context),
                          child: Image.asset(
                            'assets/img/wallet.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TabBar(
                                onTap: (index) {},
                                indicatorColor: AppColors.primaryColor,
                                controller: protfolioController.tabController,
                                tabs: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: kPadding / 2,
                                    ),
                                    child: Text(
                                      "My points",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: kPadding / 2),
                                    child: Text(
                                      "Wallet balance",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              const SpaceH20(),
                              SizedBox(
                                height: 200,
                                child: TabBarView(
                                  controller: protfolioController.tabController,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Number of points',
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.grey),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text.rich(
                                              TextSpan(
                                                text: protfolioController
                                                    .userBalance.value,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineMedium!
                                                    .copyWith(
                                                      color: AppColors.black,
                                                    ),
                                                children: <InlineSpan>[
                                                  TextSpan(
                                                    text: ' SR',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleLarge!
                                                        .copyWith(
                                                          color:
                                                              AppColors.black,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text(
                                              '=',
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineMedium!
                                                  .copyWith(
                                                    color: AppColors.black,
                                                  ),
                                            ),
                                            Text.rich(
                                              TextSpan(
                                                text: protfolioController
                                                    .userPoint.value,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineMedium!
                                                    .copyWith(
                                                      color: AppColors.black,
                                                    ),
                                                children: <InlineSpan>[
                                                  TextSpan(
                                                    text: ' Point',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleLarge!
                                                        .copyWith(
                                                          color:
                                                              AppColors.black,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Your current balance',
                                          textAlign: TextAlign.left,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.grey),
                                        ),
                                        Text.rich(
                                          TextSpan(
                                            text: protfolioController
                                                .userBalance.value,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineMedium!
                                                .copyWith(
                                                  color: AppColors.black,
                                                ),
                                            children: <InlineSpan>[
                                              TextSpan(
                                                text: ' SR',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge!
                                                    .copyWith(
                                                      color: AppColors.black,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SpaceH36(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => Padding(
          padding: const EdgeInsets.all(kPadding),
          child: CustomPrimaryButton(
            // text: "Recharge the balance",
            text: protfolioController.selectedIndex.value == 0
                ? "Balance transfer"
                : 'Recharge the balance',
            onPress: () async {
              await Get.toNamed("/profile");
            },
            color: AppColors.primaryColor,
            textColor: AppColors.primaryTextColor,
          ),
        ),
      ),
    );
  }
}
