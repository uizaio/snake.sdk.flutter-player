import 'package:in_app_review/in_app_review.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherUtils {
  static Future<void> launchInWebViewWithJavaScript(String _url) async {
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  }

  static Future<void> rateApp(
    String? appStoreId,
    String? microsoftStoreId,
  ) =>
      InAppReview.instance.openStoreListing(
        appStoreId: appStoreId,
        microsoftStoreId: microsoftStoreId,
      );
}
