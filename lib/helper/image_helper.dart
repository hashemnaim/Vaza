import 'dart:io';
import 'dart:math';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter_image_compress/flutter_image_compress.dart' as image;

class ImageHelper {
  ImageHelper._internal();
  static final ImageHelper helper = ImageHelper._internal();

  // final ImagePicker _imagePicker;
  // final ImageCropper _imageCropper;

  Future<List<XFile?>> pickkMultiImage(
      {ImageSource source = ImageSource.gallery,
      int imageQuality = 100,
      bool multiple = false}) async {
    if (multiple) {
      return await ImagePicker().pickMultiImage(imageQuality: imageQuality);
    }
    final file = await ImagePicker()
        .pickImage(source: source, imageQuality: imageQuality);

    if (file != null) return [file];
    return [];
  }

  Future<XFile?> pickImage({
    ImageSource source = ImageSource.gallery,
    int imageQuality = 100,
  }) async {
    final file = await ImagePicker().pickImage(
      source: source,
      imageQuality: imageQuality,
      preferredCameraDevice: CameraDevice.front,
    );

    return file;
  }

  Future<CroppedFile?> imageCropper({
    required XFile file,
    CropStyle cropStyle = CropStyle.rectangle,
  }) async {
    try {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
          cropStyle: cropStyle,
          sourcePath: file.path,
          compressQuality: 100,
          uiSettings: [
            AndroidUiSettings(
                toolbarTitle: 'إضافة  صورة',
                toolbarColor: Colors.black,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.square,
                lockAspectRatio: false),
            IOSUiSettings(
                title: 'إضافة  صورة',
                minimumAspectRatio: 0.5,
                aspectRatioLockEnabled: false,
                rectHeight: 200,
                rectWidth: 200),
          ]);

      if (croppedFile != null) {
        return CroppedFile(croppedFile.path);
      } else {
        return CroppedFile("error");
      }
    } catch (e) {
      return CroppedFile("error");
    }
  }

  Future<dio.MultipartFile?> compressFile(File file) async {
    if (file.path == "") {
      BotToast.showText(
          text: "يجب إضافة الصور المطلوبة ", contentColor: Colors.red);
      return null;
    } else {
      var result = await image.FlutterImageCompress.compressWithFile(
        file.absolute.path,
        minHeight: 350,
        minWidth: 350,
        quality: 100,
        format: image.CompressFormat.png,
      );
      dio.MultipartFile multipartFile = dio.MultipartFile.fromBytes(
        result!,
        filename: 'load_image${Random().nextInt(20)}.png',
        contentType: MediaType("image", "png"),
      );
      return multipartFile;
    }
  }
}
