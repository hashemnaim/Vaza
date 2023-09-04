import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:get/get.dart';

class GalleryController extends GetxController {
  String image = '';
  // final imageList = [
  //   'https://resocoder.com/wp-content/uploads/2019/04/thumbnail-2.png',
  //   'https://resocoder.com/wp-content/uploads/2019/04/thumbnail-1.png',
  //   'https://resocoder.com/wp-content/uploads/2019/01/thumbnail.png',
  // ];
  @override
  void onInit() {
    if (Get.arguments != null) {
      image = Get.arguments["image"];
      // print(phoneNumber.value);
      // getVerificationCode();
    }
    super.onInit();
  }
}

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    var galleryController = Get.put(GalleryController());

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        automaticallyImplyLeading: true,
      ),
      body: PhotoView(
        imageProvider: NetworkImage(
          galleryController.image,
        ),
        enableRotation: true,
        backgroundDecoration: const BoxDecoration(color: Colors.black),
        loadingBuilder: ((context, event) =>
            const Center(child: CircularProgressIndicator())),
      ),
    );
  }
}
