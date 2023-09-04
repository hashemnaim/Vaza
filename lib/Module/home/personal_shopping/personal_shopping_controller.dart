import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/APIs/personal_shoping_service.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class PersonalShoppingController extends GetxController {
  RxString? personalshoppingData = ''.obs;
  RxBool personalShoppingLoading = true.obs;
  quill.QuillController quillController = quill.QuillController(
    document: quill.Document(),
    keepStyleOnNewLine: true,
    selection: const TextSelection.collapsed(
      offset: 0,
    ),
  );
  @override
  void onInit() async {
    super.onInit();
    getPersonalShopping();
  }

  getPersonalShopping() async {
    personalShoppingLoading.value = true;
    var response = await PersonShoppingService.getPersonalShopping();
    personalshoppingData!.value = response;
    quillController = quill.QuillController(
      document: quill.Document.fromJson(
          jsonDecode(personalshoppingData!.value)["ops"]),
      selection: const TextSelection.collapsed(offset: 0),
    );
    personalShoppingLoading.value = false;
  }
}
