

import 'package:flutter/cupertino.dart';
import 'package:flutter_app/i18n_demo/localizations.dart';

class HYLocalizationsDelegate extends LocalizationsDelegate<HYLocalizations> {

  static HYLocalizationsDelegate delegate = HYLocalizationsDelegate();

  //支持的语种
  @override
  bool isSupported(Locale locale) {
    // TODO: implement isSupported
    return ['zh','en'].contains(locale.languageCode);
  }

  //是否需要重载
  @override
  bool shouldReload(covariant LocalizationsDelegate<HYLocalizations> old) {
    // TODO: implement shouldReload
    return false;
  }

  @override
  Future<HYLocalizations> load(Locale locale) async {
    final localizations = HYLocalizations(locale);
    await localizations.loadJson();
    return localizations;
  }
}