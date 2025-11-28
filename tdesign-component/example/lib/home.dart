import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import 'base/example_base.dart';
import 'base/example_route.dart';
import 'base/web_md_tool.dart';
import 'config.dart';
import 'l10n/app_localizations.dart';

var _kShowTodoComponent = false;

/// 切换主题的回调
typedef OnThemeChange = Function(TThemeData themeData, bool isDark);

/// 切换语言的回调
typedef OnLocaleChange = Function(Locale locale);

/// 示例首页
class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
    this.onThemeChange,
    this.locale,
    this.onLocaleChange,
  }) : super(key: key);

  final String title;

  final OnThemeChange? onThemeChange;

  final OnLocaleChange? onLocaleChange;

  final Locale? locale;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool useConch = false;
  String searchText = '';
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    TExampleRoute.init();
    sideBarExamplePage.forEach(TExampleRoute.add);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        backgroundColor: TTheme.of(context).brandNormalColor,
        titleTextStyle: TextStyle(
            color: TTheme.of(context).whiteColor1,
            fontSize: TTheme.of(context).fontTitleLarge?.size),
        title: Text(widget.title),
        actions: ScreenUtil.isWebLargeScreen(context)
            ? null
            : [
                GestureDetector(
                  child: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(
                      right: 16,
                    ),
                    child: TText(
                      widget.locale?.languageCode == 'en' ? '中文' : 'English',
                      textColor: TTheme.of(context).whiteColor1,
                    ),
                  ),
                  onTap: () {
                    if (widget.locale?.languageCode == 'en') {
                      widget.onLocaleChange?.call(const Locale('zh'));
                    } else {
                      widget.onLocaleChange?.call(const Locale('en'));
                    }
                  },
                ),
                GestureDetector(
                  child: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(
                      right: 16,
                    ),
                    child: TText(
                      AppLocalizations.of(context)?.about,
                      textColor: TTheme.of(context).whiteColor1,
                    ),
                  ),
                  onTap: () {
                    focusNode.unfocus();
                    Navigator.pushNamed(context, TExampleRoute.aboutPath);
                  },
                )
              ],
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
        child: Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildChildren(context),
        ),
      ),
    ));
  }

  List<Widget> _buildChildren(BuildContext context) {
    var children = <Widget>[];

    // 添加切换主题的按钮
    children.add(Padding(
      padding: const EdgeInsets.only(top: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          constraints:
              BoxConstraints(minWidth: MediaQuery.of(context).size.width),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 4),
                child: TTheme(
                    data: TThemeData.defaultData(),
                    child: TButton(
                      text: AppLocalizations.of(context)?.defaultTheme,
                      theme: TButtonTheme.primary,
                      onTap: () {
                        widget.onThemeChange
                            ?.call(TTheme.defaultData(), false);
                      },
                    )),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: TTheme(
                      data: TThemeData.fromJson('green', greenThemeConfig) ??
                          TThemeData.defaultData(),
                      child: TButton(
                          text: AppLocalizations.of(context)?.greenTheme,
                          theme: TButtonTheme.primary,
                          onTap: () async {
                            var jsonString = await rootBundle
                                .loadString('assets/theme.json');
                            var newData =
                                TThemeData.fromJson('green', jsonString);
                            widget.onThemeChange
                                ?.call(newData ?? TTheme.defaultData(), false);
                          }))),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: TTheme(
                      data: TThemeData.fromJson('red', greenThemeConfig) ??
                          TThemeData.defaultData(),
                      child: TButton(
                          text: AppLocalizations.of(context)?.redTheme,
                          theme: TButtonTheme.danger,
                          onTap: () async {
                            var jsonString = await rootBundle
                                .loadString('assets/theme.json');
                            var newData =
                                TThemeData.fromJson('red', jsonString);
                            widget.onThemeChange
                                ?.call(newData ?? TTheme.defaultData(), false);
                          }))),
              Padding(
                  padding: const EdgeInsets.only(left: 4, right: 8),
                  child: TButton(
                      text: AppLocalizations.of(context)?.darkTheme,
                      style: TButtonStyle(
                          backgroundColor: Colors.black,
                          textColor: Colors.white),
                      onTap: () async {
                        var jsonString =
                            await rootBundle.loadString('assets/theme.json');
                        var newData = TThemeData.fromJson('dark', jsonString);
                        widget.onThemeChange
                            ?.call(newData ?? TTheme.defaultData(), true);
                      })),
            ],
          ),
        ),
      ),
    ));

    children.add(TSearchBar(
      placeHolder: '请输入组件名称',
      focusNode: focusNode,
      onTextChanged: (value) {
        setState(() {
          searchText = value;
        });
      },
    ));

    exampleMap.forEach((key, value) {
      var subList = <Widget>[];
      value.forEach((model) {
        if (searchText.isNotEmpty &&
            !model.text.toLowerCase().contains(searchText.toLowerCase())) {
          // 如果有搜索文案,不再搜索中的组件不展示
          return;
        }
        model.spline = WebMdTool.getSpline(key);
        if (model.isTodo) {
          if (_kShowTodoComponent) {
            children.add(Padding(
              padding:
                  const EdgeInsets.only(left: 40, right: 40, top: 8, bottom: 8),
              child: TButton(
                  size: TButtonSize.medium,
                  type: TButtonType.outline,
                  shape: TButtonShape.filled,
                  theme: TButtonTheme.defaultTheme,
                  textStyle: TextStyle(color: TTheme.of(context).fontGyColor4),
                  onTap: () {
                    Navigator.pushNamed(context, '${model.name}?showAction=1');
                  },
                  text: model.text),
            ));
          }
        } else {
          subList.add(Padding(
            padding:
                const EdgeInsets.only(left: 40, right: 40, top: 8, bottom: 8),
            child: TButton(
                size: TButtonSize.medium,
                type: TButtonType.outline,
                shape: TButtonShape.filled,
                theme: TButtonTheme.primary,
                onTap: () {
                  focusNode.unfocus();
                  Navigator.pushNamed(context, '${model.name}?showAction=1');
                },
                text: model.text),
          ));
        }
      });
      children.add(Container(
        alignment: Alignment.topLeft,
        margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
        padding: const EdgeInsets.only(left: 12),
        decoration: BoxDecoration(
            color: TTheme.of(context).brandHoverColor,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(TTheme.of(context).radiusLarge))),
        child: TText(
          '$key(${subList.length})',
          textColor: TTheme.of(context).whiteColor1,
        ),
      ));
      children.addAll(subList);
    });
    return children;
  }
}

String greenThemeConfig = '''
  {
    "green": {
        "color": {
            "brandNormalColor": "#45c58b"
        }
    },
    "red": {
        "color": {
            "brandNormalColor": "#ff0000"
        }
    }
}
  ''';
