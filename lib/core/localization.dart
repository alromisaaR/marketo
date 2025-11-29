import 'package:flutter/material.dart';

class LocaleManager {
  static const supportedLocales = [
    Locale('en'),
    Locale('ar'),
  ];

  static Locale toggleLocale(Locale current) {
    return current.languageCode == 'en' ? const Locale('ar') : const Locale('en');
  }
}
