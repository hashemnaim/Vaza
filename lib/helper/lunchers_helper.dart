
import 'package:url_launcher/url_launcher.dart';

class LuncherHelper {
  LuncherHelper._internal();
  static final LuncherHelper validationHelper = LuncherHelper._internal();

  void launchURL(String url) async {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    throw 'Could not launch $url';
  }

  void launchEmailURL(String email) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: email,
    );
    await launchUrl(params);

    throw 'Could not launch $params';
  }

  void launchWhatsApp({
    required String phone,
    required String message,
  }) async {
    String url() {
      // if (Platform.isIOS) {
      //   return "https://wa.me/$phone/?text=${Uri.parse(message)}";
      // } else {
      return "whatsapp://send?phone=$phone&text= ";
      // }
    }

    await launchUrl(Uri.parse(url()));
    throw 'Could not launch $url';
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> launch(String type, String url) async {
    if (type.contains("mobile")) {
      makePhoneCall(url);
    } else if (type == "whatsapp") {
      launchWhatsApp(message: 'مرحبا', phone: url);
    } else if (type == "email") {
      launchEmailURL(url);
    } else {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }

    // throw 'Could not launch $url';
  }

  Future<void> launchInBrowser(String url) async {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);

    throw 'Could not launch $url';
  }
}
