# Flutter适配深色模式

### 全局调整
Flutter 在 `MaterialApp`中提供了`theme` 与 `darkTheme`两个入口让我们设置两种模式下的颜色及文字样式。接收的`ThemeData`中近乎涵盖了所有Material Widget中所使用的颜色及主题

通过配置`theme` 与 `darkTheme`可以让我们省去很多的判断代码，比如我的分割线在不同模式下是两种不同颜色，我不可能每使用一次，就在使用的地方去判断一次。通过配置全局`dividerTheme`，我们就可以直接使用`Divider()`或者`BorderSide`

```
ThemeData(
      dividerTheme: DividerThemeData(
        color: isDarkMode ? Colours.dark_line : Colours.line,
        space: 0.6,
        thickness: 0.6
      )
    );
```
页面背景色、文字样式都可以这样配置

```
ThemeData(
      errorColor: isDarkMode ? Colours.dark_red : Colours.red,
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      primaryColor: isDarkMode ? Colours.dark_app_main : Colours.app_main,
      accentColor: isDarkMode ? Colours.dark_app_main : Colours.app_main,
      // Tab指示器颜色
      indicatorColor: isDarkMode ? Colours.dark_app_main : Colours.app_main,
      // 页面背景色
      scaffoldBackgroundColor: isDarkMode ? Colours.dark_bg_color : Colors.white,
      // 主要用于Material背景色
      canvasColor: isDarkMode ? Colours.dark_material_bg : Colors.white,
      // 文字选择色（输入框复制粘贴菜单）
      textSelectionColor: Colours.app_main.withAlpha(70),
      textSelectionHandleColor: Colours.app_main,
      textTheme: TextTheme(
        // TextField输入文字颜色
        subhead: isDarkMode ? TextStyles.textDark : TextStyles.text,
        // Text默认文字样式
        body1: isDarkMode ? TextStyles.textDark : TextStyles.text,
        // 这里用于小文字样式
        subtitle: isDarkMode ? TextStyles.textDarkGray12 : TextStyles.textGray12,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: isDarkMode ? TextStyles.textHint14 : TextStyles.textDarkGray14,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        color: isDarkMode ? Colours.dark_bg_color : Colors.white,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),
      dividerTheme: DividerThemeData(
        color: isDarkMode ? Colours.dark_line : Colours.line,
        space: 0.6,
        thickness: 0.6
      )
    );
```
使用

```
MaterialApp (
      title: 'Flutter Deer',
      theme: getTheme(),
      darkTheme: getTheme(isDarkMode: true),
      home: TestPage()
    );            
```

可以利用某些“坑位”，比如应用内的另外一种功能文字在字号、颜色上都与主文字不一样，使用的地方还很多，每次使用再判断也很麻烦，这样就可以设置到未使用的属性上，比如上面代码中的subtitle。这样使用时就可以通过调用Theme.of(context).textTheme.subtitle来实现

```
Text(
  "文字", 
  style: Theme.of(context).textTheme.subtitle
)
```
**毕竟是全局配置，尽量保持通用，不要影响其他widget也是要考虑的地方。**

这部分配置完成后，你需要的是"去同存异"。
1.  比如你指定的文字样式与全局配置相同时，就需要删除它。
1.  如果文字颜色相同，但是字号不同。那就删除颜色配置信息，保留字号设置

```
Text(
  "仅保留不同信息",
  style: const TextStyle(
    fontSize: 12.0,
  )
)
```
因为Text的源码中就是通过`merge`方法来合并全局配置与局部配置。`merge`中其实就是调用`copyWith`来实现的。所以也可以这样写

```
Text(
  "仅保留不同信息",
  style: Theme.of(context).textTheme.body1.copyWith(fontSize: 12.0)
)
```

### 局部调整
在经过全局的配置后，大多数适配问题得到了解决。但可能还有一些细节要调整，比如图标、个别的文字颜色、背景色。这时需要的就是如何判断深色模式：

```
  bool isDarkMode(BuildContext context){
    return Theme.of(context).brightness == Brightness.dark;
  }
```
这里的`brightness`就是上面在全局配置`ThemeData`中指定的`brightness`
