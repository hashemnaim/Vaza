import 'package:faza_app/utils/values.dart';
import 'package:faza_app/Module/setting/subscription/controller/sub_controller/sub_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var subController = Get.put(SubController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: Get.height / 3,
        flexibleSpace: Stack(
          children: [
            Container(
                height: Get.height / 2.5,
                width: Get.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/img/Sub_img.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(children: [
                  Positioned(
                      top: kTopPadding(context) + 35,
                      left: 10,
                      child: IconButton(
                          color: AppColors.white,
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(Icons.arrow_back_ios_new))),
                  Positioned(
                      bottom: 65,
                      right: 0,
                      left: 0,
                      child: Text('Subscription system from vasa',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.white)))
                ]))
          ],
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              const SpaceH16(),
              Text(
                'Enjoy with us vasa  subscription wherever you are',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w600, color: AppColors.black),
              ),
              const SpaceH16(),
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
                        isScrollable: true,
                        controller: subController.tabController,
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
                        height: 260,
                        child: TabBarView(
                          controller: subController.tabController,
                          children: const [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [],
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
      ),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.all(kPadding / 2),
      //   child: CustomPrimaryButton(
      //     // text: "Recharge the balance",
      //     text: "Subscription",
      //     onPress: () async {
      //       await Get.toNamed("/profile");
      //     },
      //     color: AppColors.primaryColor,
      //     textColor: AppColors.primaryTextColor,
      //   ),
      // ),
    );
  }
}
