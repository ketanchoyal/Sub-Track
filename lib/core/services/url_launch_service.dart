import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

final urlLaunchServiceP =
    Provider<UrlLaunchService>((ref) => UrlLaunchService());

class UrlLaunchService {
  Future makePhoneCall(String phoneNumber) async =>
      await _makePhoneCall(phoneNumber);
  Future sendSms(String phoneNumber) async => await _sms(phoneNumber);
  Future launchUrl(String url) async => await _launchUrl(url);

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch('tel: $url')) {
      await launch('tel:+ $url');
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _sms(String url) async {
    if (await canLaunch('sms:$url')) {
      await launch('sms:$url');
    } else {
      throw 'Could not launch $url';
    }
  }

  Future _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
