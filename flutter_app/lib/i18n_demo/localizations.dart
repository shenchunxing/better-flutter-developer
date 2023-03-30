import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';

class HYLocalizations {
  final Locale locale;
  HYLocalizations(this.locale);

  //获取HYLocalizations
  static HYLocalizations of(BuildContext context) {
    return Localizations.of(context, HYLocalizations);
  }

  //map里面包含map
  static Map<String,Map<String,String>> _localizeValues = {};

  //拿到所有的翻译，这里是加载本地json，也可能是直接从服务器获取
  Future loadJson() async {
    // 1.加载json文件
    final jsonString = await rootBundle.loadString('assets/json/i18n.json');
    // 2.转成map类型
    Map<String, dynamic> map = json.decode(jsonString);
    // 3.注意：这里是将Map<String, dynamic>转成Map<String, Map<String, String>>类型
    _localizeValues = map.map((key, value) {
      return MapEntry(key, value.cast<String, String>());
    });
  }

  //翻译
  String? get title {
    return _localizeValues[locale.languageCode]!['title'];
  }

  String? get hello {
    return _localizeValues[locale.languageCode]!['hello'];
  }

  String? get pickTime {
    return _localizeValues[locale.languageCode]!['pickTime'];
  }
}