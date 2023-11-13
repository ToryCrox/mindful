

import 'package:flutter/cupertino.dart';

class TextUtil {

  TextUtil._();

  /// Regex of url.
  static const String regexUrl = '[a-zA-Z]+://[^\\s]*';

  ///Regex of exact mobile.
  /// china mobile: 134(0-8), 135, 136, 137, 138, 139, 147, 150, 151, 152, 157, 158, 159, 178, 182, 183, 184, 187, 188, 198
  /// <p>china unicom: 130, 131, 132, 145, 155, 156, 166, 171, 175, 176, 185, 186
  /// china telecom: 133, 153, 173, 177, 180, 181, 189, 199, 191
  /// global star: 1349
  /// virtual operator: 170
  static const String regexMobileChina  = '^((13[0-9])|(14[5,7])|(15[0-3,5-9])|(16[6])|(17[0,1,3,5-8])|(18[0-9])|(19[1,8,9]))\\d{8}\$';


  /// isEmpty
  static bool isEmpty(String? text) {
    return text == null || text.isEmpty;
  }


  /// 判断是否是http url
  /// [s] url
  /// [return] true: 是http url
  static bool isHttpUrl(String? s) {
    if (isEmpty(s)) {
      return false;
    }

    return s!.startsWith(RegExp(r'http(s?)://'));
  }

  /// Return whether input matches regex.
  /// [regex] regex
  /// [input] input
  /// [return] true: matches
  static bool matches(String regex, String input) {
    if (input.isEmpty) return false;
    return RegExp(regex).hasMatch(input);
  }

  /// Return whether input matches regex of url.
  static bool isURL(String input) {
    return matches(regexUrl, input);
  }

  static bool isMobile(String phone, {String areaCode = '86'}) {
    if (areaCode == '86') {
      return matches(regexMobileChina, phone);
    }
    return phone.isNotEmpty && phone.length >= 6 && phone.length <= 13;
  }


  static bool isEmail(String email) {
    return email.isNotEmpty && RegExp('^[-a-zA-Z0-9_.]+@([0-9A-Za-z_][0-9A-Za-z-]+.)+[A-Za-z]{2,8}\$').hasMatch(email);
  }

  static bool isVerifyCode(String code) {
    return code.length == 4 && RegExp(r'^[0-9]+$').hasMatch(code);
  }

  static bool isVerifyPwd(String pwd) {
    if(pwd.isEmpty) return false;
    if(pwd.length < 6) return false;
    // RegExp regex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[._]).{6,}$'); //强要求必须包含大小写字母和特殊符号
    RegExp regex = RegExp(r'^[a-zA-Z0-9._]+$');
    return regex.hasMatch(pwd);
  }

  static int strLen(String origin) {
    Runes runes = origin.runes;
    return runes.length;
  }

  static bool validStr(String value){
    return (value.isNotEmpty);
  }

  ///searchContent    输入的搜索内容
  ///textContent      需要显示的文字内容
  ///frontContent     需要另外添加在最前面的文字
  ///replaceContent   需要替换searchContent的文字
  ///fontSize         需要显示的字体大小
  ///fontColor        需要显示的正常字体颜色
  ///selectFontColor  需要显示的搜索字体颜色
  ///fontWeight       需要显示的正常字体粗细
  ///selectFontWeight 需要显示的搜索字体粗细
  static List<TextSpan> getTextSpanList(String textContent,
      {String searchContent = '',
        String frontContent = '',
        String replaceContent = '',
        double fontSize = 14,
        double selectFontSize = 14,
        Color fontColor = const Color(0xff670740),
        Color selectFontColor = const Color(0xffE73491),
        FontWeight fontWeight = FontWeight.normal,
        FontWeight selectFontWeight = FontWeight.normal}) {
    List<TextSpan> textSpanList = <TextSpan>[];

    if (frontContent.isNotEmpty) {
      textSpanList.add(TextSpan(text: frontContent, style: TextStyle(fontSize: fontSize, color: fontColor)));
    }

    ///搜索内容不为空并且 显示内容中存在与搜索内容相同的文字
    if (searchContent.isEmpty == false && textContent.contains(searchContent)) {
      List<Map> strMapList = <Map>[];
      bool isContains = true;
      while (isContains) {
        int startIndex = textContent.indexOf(searchContent);
        String showStr = textContent.substring(startIndex, startIndex + searchContent.length);
        Map strMap;
        if (startIndex > 0) {
          String normalStr = textContent.substring(0, startIndex);
          strMap = {};
          strMap['content'] = normalStr;
          strMap['isHighlight'] = false;
          strMapList.add(strMap);
        }
        strMap = {};
        strMap['content'] = replaceContent.isNotEmpty ? replaceContent : showStr;
        strMap['isHighlight'] = true;
        strMapList.add(strMap);
        textContent = textContent.substring(startIndex + searchContent.length, textContent.length);

        isContains = textContent.contains(searchContent);
        if (!isContains && textContent != '') {
          strMap = {};
          strMap['content'] = textContent;
          strMap['isHighlight'] = false;
          strMapList.add(strMap);
        }
      }
      for (var map in strMapList) {
        textSpanList.add(TextSpan(
            text: map['content'],
            style: TextStyle(
                fontSize: map['isHighlight'] ? selectFontSize : fontSize,
                color: map['isHighlight'] ? selectFontColor : fontColor,
                fontWeight: map['isHighlight'] ? selectFontWeight : fontWeight
            )
        ));
      }
    } else {
      ///正常显示所有文字
      textSpanList.add(TextSpan(text: textContent, style: TextStyle(fontSize: fontSize, color: fontColor),
      ));
    }
    return textSpanList;
  }

}