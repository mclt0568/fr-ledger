import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:frledger/globals/local_storage.dart';

class Internationalization {
  static var languages = <String>["en", "zhcn", "zhtw", "ve"];
  static var languageNames = <String, String>{
    "en": "English",
    "zhcn": "简体中文",
    "zhtw": "繁體中文",
    "ve": "Vëlhëlkohas",
  };
  static var fallback = "en";

  static Future<void> setLanguage(String lang) async {
    if (!languages.contains(lang)) lang = "en";
    await LocalStorage.setItem("lang", lang);
  }

  static Future<String> getLanguage() async {
    String? lang = await LocalStorage.getItem("lang");
    if (languages.contains(lang)) return lang.toString();

    // If language not found
    await Internationalization.setLanguage(fallback);
    return fallback;
  }

  static Future<Map> getTranslationObject(
      BuildContext context, String filename) async {
    String lang = await getLanguage();
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/langs/$filename.json");
    return jsonDecode(data)[lang];
  }
}
