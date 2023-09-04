import 'dart:io';
import 'package:url_launcher/url_launcher_string.dart';

class MapUtils {
  MapUtils._();

  static Future<void> openMapByLatLng(double latitude, double longitude) async {
    String url = '';
    String urlAppleMaps = '';
    if (Platform.isAndroid) {
      url =
          'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    } else {
      urlAppleMaps = 'https://maps.apple.com/?q=$latitude,$longitude';
      url = 'comgooglemaps:/'
          '/?saddr=&daddr=$latitude,$longitude&directionsmode=driving';
      if (await canLaunchUrlString(url)) {
        await launchUrlString(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else if (await canLaunchUrlString(urlAppleMaps)) {
      await launchUrlString(urlAppleMaps);
    } else {
      throw 'Could not launch $url';
    }
  }
}
