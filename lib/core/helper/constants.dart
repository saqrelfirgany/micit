import 'helper.dart';

class AppConstants {
  static const String apiKey = '';

  /// Domain
  static const String domain = 'https://sys-access.com/system';

  /// Base Url
  static String baseUrl = '$domain/${Helper.lang}/api/$apiVersion';

  /// Currencies
  static const String egyPound = 'EGP';
  static const String sr = 'SR';

  /// android App Url
  static const String androidAppUrl =
      'https://play.google.com/store/apps/details?id=com.';

  /// ios App Url
  static const String iosAppUrl = 'https://apps.apple.com/us/app/';

  /// App Store ID
  static const String appStoreID = 'id16';

  /// google play ID
  static const String googlePlayID = 'com.';

  /// Language
  static String language = Helper.lang;

  /// Version
  static const String apiVersion = 'v001';

  /// About version shows inside the app
  static const String aboutAppVersion = '1.0.0';

  /// Force user to update after uploading new version on the stores. Get valued from DataBase
  static const double iOSUploadVersion = 1.0;

  static const double androidUploadVersion = 1.0;
}
