import 'dart:io';

abstract class Configuration {
  static const APP_NAME = "AppName";

  static const DIO_BASE_URL = "https://your-api.com/";
  static const DIO_CONNECTION_TIMEOUT = 5000;

  static const JOBS_LIST_LIMIT = 10;

  static const CURSOR_SHARED_PREF = "const_name";

  static const ADMOB_APP_ID_ANDROID = "your-app-id";
  static const ADMOB_APP_ID_IOS = "your-app-id";

  static const ADMOB_MAIN_AD_ID_ANDROID = "your-ad-id";
  static const ADMOB_MAIN_AD_ID_IOS = "your-ad-id";

  static const APP_FONT_FAMILY = "Pacifico";

  static const DESIGN_BASED_WIDTH = 400.0;
  static const DESIGN_BASED_HEIGHT = 640.0;

  static const APP_PACKAGE_NAME = "br.com.app-package-name";
  static const APP_IOS_ID = 123456;

  static const DONATION_PAYPAL_LINK = "";

  static const EVENT_RATING_APP = "const_name";
  static const EVENT_SHOW_ABOUT_DIALOG = "const_name";
  static const EVENT_OPEN_DONATION_LINK = "const_name";
  static const EVENT_OPEN_JOB_LINK = "const_name";

  static String getAdmobAppId() {
    if (Platform.isAndroid) {
      return ADMOB_APP_ID_ANDROID;
    } else if (Platform.isIOS) {
      return ADMOB_APP_ID_IOS;
    }
    return null;
  }

  static String getAdmobBannerId() {
    if (Platform.isAndroid) {
      return ADMOB_MAIN_AD_ID_ANDROID;
    } else if (Platform.isIOS) {
      return ADMOB_MAIN_AD_ID_IOS;
    }
    return null;
  }
}