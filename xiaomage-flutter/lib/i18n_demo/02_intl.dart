import 'package:flutter/material.dart';
import 'package:flutter_app/i18n_demo/localizations.dart';
import 'package:flutter_app/i18n_demo/localizations_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_app/generated/l10n.dart'; //导入了翻译插件intl
//intl会自动生成字符串的get方法，新增国家化只需要new add arc file。

void main() => runApp(MaterialApp(
  localizationsDelegates: [
    GlobalMaterialLocalizations.delegate,// 指定本地化的字符串和一些其他的值
    GlobalCupertinoLocalizations.delegate,// 对应的Cupertino风格
    GlobalWidgetsLocalizations.delegate,// 指定默认的文本排列方向, 由左到右或由右到左
    HYLocalizationsDelegate.delegate,
    S.delegate,
  ],
  supportedLocales: [
    Locale('en'),
    Locale('zh'),
    //指定语言代码、文字代码和国家代码
    const Locale.fromSubtags(languageCode: 'zh'), // generic Chinese 'zh'
    const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'), // generic simplified Chinese 'zh_Hans'
    const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'), // generic traditional Chinese 'zh_Hant'
    const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans', countryCode: 'CN'), // 'zh_Hans_CN'
    const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant', countryCode: 'TW'), // 'zh_Hant_TW'
    const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant', countryCode: 'HK'), // 'zh_Hant_HK'
  ],
  home: HYHomePage(),
));

class HYHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //可以传参数
            Text(S.of(context).sayHello('梅西'), style: TextStyle(fontSize: 20),),
            RaisedButton(
              child: Text(S.of(context).picktime, style: TextStyle(fontSize: 20),),
              onPressed: () {
                showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(3000)
                );
              },
            )
          ],
        ),
      ),
    );
  }
}