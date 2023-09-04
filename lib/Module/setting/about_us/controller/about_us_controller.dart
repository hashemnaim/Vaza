import 'dart:convert';

import 'package:faza_app/services/admin_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class AboutUsController extends GetxController {
  RxString? aboutUsData = ''.obs;
  RxBool aboutUsDataLoading = true.obs;
  quill.QuillController quillController = quill.QuillController(
    document: quill.Document(),
    keepStyleOnNewLine: true,
    selection: const TextSelection.collapsed(offset: 0),
  );
  @override
  void onInit() async {
    super.onInit();
    getAboutUsData();
  }

  getAboutUsData() async {
    aboutUsDataLoading.value = true;
    var response = await AdminService.getAbout();
    aboutUsData!.value = response;
    quillController = quill.QuillController(
      document: quill.Document.fromJson(jsonDecode(aboutUsData!.value)["ops"]),
      selection: const TextSelection.collapsed(offset: 0),
    );
    aboutUsDataLoading.value = false;
  }
}
