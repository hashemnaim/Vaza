import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import '../../../widgets/custom_network_image.dart';
import 'controller/product_detail_controller.dart';

class SliderImageWithPagerPoints extends StatefulWidget {
  const SliderImageWithPagerPoints({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _SliderImageWithPagerPointsState createState() =>
      _SliderImageWithPagerPointsState();
}

class _SliderImageWithPagerPointsState
    extends State<SliderImageWithPagerPoints> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  int index = 0;
  late Timer _timer;
  ProductDetailController productDetailController = Get.find();

  @override
  void initState() {
    super.initState();
    index = Get.arguments["index"];
    _startTimer();
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      if (_currentPage <
          productDetailController.productDetail.value.productPhotos!.length) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  void _stopTimer() {
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: PageView.builder(
          controller: _pageController,
          onPageChanged: (int page) {
            setState(() {
              _currentPage = page;
            });
          },
          itemCount:
              productDetailController.productDetail.value.productPhotos!.length,
          itemBuilder: (BuildContext context, int index2) => InkWell(
            onTap: () {
              Get.dialog(Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Material(
                    borderOnForeground: false,
                    color: Colors.transparent,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        CustomNetworkImage(
                            boxFit: BoxFit.contain,
                            height: 250,
                            imagePath: productDetailController.productDetail
                                .value.productPhotos![index2].photo!,
                            width: Get.width),
                        Positioned(
                          top: 0,
                          left: 0,
                          child: IconButton(
                              onPressed: () => Get.back(),
                              icon: const Icon(
                                Icons.close_sharp,
                                color: Colors.white,
                                size: 40,
                              )),
                        )
                      ],
                    ),
                  )));
            },
            child: InteractiveViewer(
              child: CustomNetworkImageWithoutHeight(
                imageUrl: productDetailController
                    .productDetail.value.productPhotos![index2].photo!,
                boxFit: BoxFit.cover,
              ),
            ),
          ),
        )),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List<Widget>.generate(
              productDetailController.productDetail.value.productPhotos!.length,
              (int index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              width: _currentPage == index ? 20.0 : 8.0,
              height: 8.0,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: _currentPage == index
                    ? BorderRadius.circular(12)
                    : BorderRadius.circular(50),
                color: _currentPage == index ? Colors.black : Colors.grey,
              ),
            );
          }),
        ),
      ],
    );
  }
}
