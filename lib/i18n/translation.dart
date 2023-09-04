import 'package:faza_app/i18n/ar.dart';
import 'package:faza_app/i18n/en.dart';

abstract class AppTranslation {
  static Map<String, Map<String, String>> translations = {
    'en_US': EnglishLocale.en_US,
    'ar_SA': ArabicLocale.ar_SA,
  };
}
