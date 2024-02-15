import 'dart:ui';
import 'package:faza_app/utils/values.dart';
import 'package:faza_app/i18n/translation.dart';
import 'package:faza_app/routes/routes.dart';
import 'package:faza_app/helper/storage_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'helper/dio_helper.dart';
import 'helper/fcm_helper.dart';

RxBool isLoggedIn = false.obs;
RxBool isIntroSeen = false.obs;
RxBool city = false.obs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await DioHelper.init();
  await FcmHelper.fcmHelper.initFcm();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.white));
  final getStorage = GetStorage();
  if (getStorage.read('vasa_user') != null) {
    StorageService.writeIsGuest(false);
    isLoggedIn.value = true;
  } else {
    StorageService.writeIsGuest(true);
    isLoggedIn.value = false;
  }
  if (StorageService.isIntroSeen()) {
    isIntroSeen.value = true;
  } else {
    isIntroSeen.value = false;
  }
  if (StorageService.getCity() != "") {
    city.value = true;
  } else {
    city.value = false;
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String defaultLocaleCode = Get.deviceLocale!.languageCode;

  @override
  void initState() {
    super.initState();
    defaultLocaleCode =
        StorageService.getcurrentLanguage() ?? defaultLocaleCode;
    StorageService.writeLanguage(defaultLocaleCode);
  }

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: GetMaterialApp(
          translationsKeys: AppTranslation.translations,
          locale: Locale(defaultLocaleCode),
          fallbackLocale: const Locale('en'),
          builder: EasyLoading.init(),
          title: appName,
          initialRoute: isLoggedIn.value
              ? Routes.initial
              : isIntroSeen.value
                  ? city.value == true
                      ? Routes.initial
                      : '/select-city'
                  : '/intro',
          getPages: Routes.routes,
          theme: ThemeData(
              primaryColor: AppColors.primaryColor,
              fontFamily: "IBMPlexSansArabic",
              datePickerTheme: const DatePickerThemeData(),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF222b44)),
              ),
              colorScheme: const ColorScheme.light(
                primary: Color(0xFF222b44),
                onPrimary: Colors.white,
                onSurface: Color(0xFF222b44),
              ).copyWith(background: Colors.white)),
          scrollBehavior: CustomScrollBehavior(),
          debugShowCheckedModeBanner: false),
    );
  }
}

class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
      };
}
