---
title: Text 文本
description: 
spline: base
isComponent: true
---

<span class="coverages-badge" style="margin-right: 10px"><img src="https://img.shields.io/badge/coverages%3A%20lines-100%25-blue" /></span><span class="coverages-badge" style="margin-right: 10px"><img src="https://img.shields.io/badge/coverages%3A%20functions-100%25-blue" /></span><span class="coverages-badge" style="margin-right: 10px"><img src="https://img.shields.io/badge/coverages%3A%20statements-100%25-blue" /></span><span class="coverages-badge" style="margin-right: 10px"><img src="https://img.shields.io/badge/coverages%3A%20branches-83%25-blue" /></span>
## 引入

在tdesign_flutter/tdesign_flutter.dart中有所有组件的路径。

```dart
import 'package:tdesign_flutter/tdesign_flutter.dart';
```

## 代码演示

[t_text_page.dart](https://github.com/Tencent/tdesign-flutter/blob/main/tdesign-component/example/lib/page/t_text_page.dart)

### 1 使用示例

系统Text:
            
<td-code-block panel="Dart">

  <pre slot="Dart" lang="javascript">
  Widget _buildSystemText(BuildContext context) {
    return Text(
      exampleTxt,
    );
  }</pre>

</td-code-block>
                                  

普通TDText:
            
<td-code-block panel="Dart">

  <pre slot="Dart" lang="javascript">
  Widget _buildNormalTDText(BuildContext context) {
    return TText(
      exampleTxt,
    );
  }</pre>

</td-code-block>
                                  

指定常用属性:
            
<td-code-block panel="Dart">

  <pre slot="Dart" lang="javascript">
  Widget _buildGeneralProp(BuildContext context) {
    return TText(
      exampleTxt,
      font: TTheme.of(context).fontHeadlineLarge,
      textColor: TTheme.of(context).brandNormalColor,
      backgroundColor: TTheme.of(context).brandFocusColor,
    );
  }</pre>

</td-code-block>
                                  

style覆盖textColor,不覆盖font:
            
<td-code-block panel="Dart">

  <pre slot="Dart" lang="javascript">
  Widget _buildStyleCoverColor(BuildContext context) {
    return TText(
      exampleTxt,
      font: TTheme.of(context).fontBodyLarge,
      textColor: TTheme.of(context).brandNormalColor,
      style: TextStyle(color: TTheme.of(context).errorNormalColor),
    );
  }</pre>

</td-code-block>
                                  

style覆盖textColor和font:
            
<td-code-block panel="Dart">

  <pre slot="Dart" lang="javascript">
  Widget _buildStyleCoverColorAndFont(BuildContext context) {
    return TText(
      exampleTxt,
      font: TTheme.of(context).fontBodyLarge,
      textColor: TTheme.of(context).brandNormalColor,
    );
  }</pre>

</td-code-block>
                                  

TText.rich测试:
            
<td-code-block panel="Dart">

  <pre slot="Dart" lang="javascript">
  Widget _buildRichText(BuildContext context) {
    return TText.rich(
      TextSpan(children: [
        TTextSpan(
            text: 'TTextSpan1',
            font: TTheme.of(context).fontTitleExtraLarge,
            textColor: TTheme.of(context).warningNormalColor,
            isTextThrough: true,
            lineThroughColor: TTheme.of(context).brandNormalColor,
            style: TextStyle(color: TTheme.of(context).errorNormalColor)),
        TextSpan(
            text: 'TextSpan2',
            style: TextStyle(
                fontSize: 14, color: TTheme.of(context).brandNormalColor)),
        const WidgetSpan(
            child: Icon(
          TIcons.setting,
          size: 24,
        )),
      ]),
      font: TTheme.of(context).fontBodyLarge,
      textColor: TTheme.of(context).brandNormalColor,
      style:
          TextStyle(color: TTheme.of(context).errorNormalColor, fontSize: 32),
    );
  }</pre>

</td-code-block>
                                  

获取系统Text:
            
<td-code-block panel="Dart">

  <pre slot="Dart" lang="javascript">
  Widget _getSystemText(BuildContext context) {
    return TText(
      exampleTxt,
      backgroundColor: TTheme.of(context).brandFocusColor,
    ).getRawText(context: context);
  }</pre>

</td-code-block>
                                  

中文居中:（带有英文可能不居中）
            
<td-code-block panel="Dart">

  <pre slot="Dart" lang="javascript">
  Widget _buildVerticalCenterText(BuildContext context) {
    return TText(
      '中华人民共和国腾讯科技',
      // font: Font(size: 100, lineHeight: 100),
      forceVerticalCenter: true,
      backgroundColor: TTheme.of(context).brandFocusColor,
    );
  }</pre>

</td-code-block>
                                  

自定义内部padding:
            
<td-code-block panel="Dart">

  <pre slot="Dart" lang="javascript">
  Widget _buildCustomPaddingText(BuildContext context) {
    return TTextConfiguration(
      paddingConfig: CustomTextPaddingConfig(),
      child: const CustomPaddingText(),
    );
  }</pre>

</td-code-block>
                                  


## API
### TText
#### 默认构造方法

| 参数 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| data | null | data | 以下系统text属性，释义请参考系统[Text]中注释 |
| font | Font? | - | 字体尺寸，包含大小size和行高height |
| fontWeight | FontWeight? | - | 字体粗细 |
| fontFamily | FontFamily? | - | 字体ttf |
| textColor | Color | Colors.black | 文本颜色 |
| backgroundColor | Color? | - | 背景颜色 |
| isTextThrough | bool? | false | 是否是横线穿过样式(删除线) |
| lineThroughColor | Color? | Colors.white | 删除线颜色，对应TestStyle的decorationColor |
| package | String? | - | 字体包名 |
| style | TextStyle? | - | 自定义的TextStyle，其中指定的属性，将覆盖扩展的外层属性 |
| strutStyle |  | - |  |
| textAlign |  | - |  |
| textDirection |  | - |  |
| locale |  | - |  |
| softWrap |  | - |  |
| overflow |  | - |  |
| textScaleFactor |  | - |  |
| maxLines |  | - |  |
| semanticsLabel |  | - |  |
| textWidthBasis |  | - |  |
| textHeightBehavior |  | - |  |
| forceVerticalCenter | bool | false | 是否强制居中 |
| isInFontLoader | bool | false | 是否在FontLoader中使用 |
| fontFamilyUrl | String? | - | 是否禁用懒加载FontFamily的能力 |
| key |  | - |  |


#### 工厂构造方法

| 名称  | 说明 |
| --- |  --- |
| TText.rich  | 富文本构造方法 |

```
```
 ### TTextSpan
#### 默认构造方法

| 参数 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| context |  | - |  |
| font |  | - |  |
| fontWeight |  | - |  |
| fontFamily |  | - |  |
| textColor |  | Colors.black |  |
| isTextThrough |  | false |  |
| lineThroughColor |  | Colors.white |  |
| package |  | - |  |
| text |  | - |  |
| children |  | - |  |
| style |  | - |  |
| recognizer |  | - |  |
| mouseCursor |  | - |  |
| onEnter |  | - |  |
| onExit |  | - |  |
| semanticsLabel |  | - |  |

```
```
 ### TTextConfiguration
#### 默认构造方法

| 参数 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| key |  | - |  |
| child |  | - |  |
| paddingConfig | TTextPaddingConfig? | - | forceVerticalCenter=true时，内置padding配置 |
| globalFontFamily | FontFamily? | - | 全局字体,kTextNeedGlobalFontFamily=true时生效 |


  
