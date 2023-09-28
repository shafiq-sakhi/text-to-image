import 'package:shared_preferences/shared_preferences.dart';
import 'package:text_to_image/utils/app_language.dart';

class DataCache {
  static late SharedPreferences data;
  static String LANGUAGE = "LANGUAGE";

  static Future init() async {
    // SharedPreferences.setMockInitialValues({});
    data = await SharedPreferences.getInstance();
    print("sqf init");
    print(data);
  }

  static bool isEnglish() {
    return DataCache.data.getBool(DataCache.LANGUAGE) ?? false;
  }

  static void setLaguage(bool value) {
    AppLanguage.isEnglish=value;
    data.setBool(DataCache.LANGUAGE, value);
  }
}
