import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'localization_state.dart';

@singleton
class LanguageCubit extends Cubit<ChangeLocaleState> {
  LanguageCubit() : super(ChangeLocaleState(locale: const Locale('en')));
  String local = 'en';

  Future<void> getSavedLanguage() async {
    final String cachedLanguageCode = await getCurrentLanguage();
    emit(ChangeLocaleState(locale: Locale(cachedLanguageCode)));
  }

  Future<void> changeLanguage(String languageCode) async {
    await saveLanguage(languageCode);
    local = languageCode;
    emit(ChangeLocaleState(locale: Locale(languageCode)));
  }

  Future<String> getCurrentLanguage() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final cachedLanguageCode = sharedPreferences.getString("LOCALE");
    if (cachedLanguageCode != null) {
      local = cachedLanguageCode;
      return cachedLanguageCode;
    } else {
      local = "en";
      return "en";
    }
  }

  Future<void> saveLanguage(String languageCode) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("LOCALE", languageCode);
  }
}
