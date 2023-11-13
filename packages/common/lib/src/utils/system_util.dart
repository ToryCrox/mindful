import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
///此类为一些和系统或者屏幕相关的通用函数
class SystemUtil {

  @Deprecated('不要使用该方法，想要宽度铺满，请使用double.infinity')
  static double get width {
    double ratio = window.physicalSize.width / window.physicalSize.height;
    if (ratio >= 0.8 && ratio < 1.2) {
      /// 简单适配下宽屏手机上的问题
      return height * 9 / 16;
    }
    return window.physicalSize.width / window.devicePixelRatio;
  }

  @Deprecated('不要使用该方法，想要高度铺满，请使用double.infinity')
  static double get height {
    return window.physicalSize.height / window.devicePixelRatio;
  }

  @Deprecated('不要使用该方法，想要状态栏高度，请使用MediaQuery.of(context).padding.top')
  static double get statusHeight {
    return MediaQueryData.fromView(window).padding.top;
  }

  @Deprecated('不要使用该方法，想要底部安全区高度，请使用MediaQuery.of(context).padding.bottom 或者 使用SafeArea组件')
  static double get iphoneXBottom {
    return isIphoneX ? 34.0 : 0.0;
  }

  static double get bottomMargin {
    return isIphoneX ? 34.0 : 20.0;
  }
  static double get devicePixelRatio {
    return window.devicePixelRatio;
  }


  static bool get isIphoneX {
    const X_WIDTH = 1125; //iPhone X跟iphone 12 mini的渲染分辨率一致
    const X_HEIGHT = 2436;

    const XSMax_WIDTH = 1242;
    const XSMax_HEIGHT = 2688;

    const XR_WIDTH = 828;
    const XR_HEIGHT = 1792;

    const _12_WIDTH = 1170; //iPhone 12跟iPhone 12 Pro的渲染分辨率一致
    const _12_HEIGHT = 2532;

    const _12_MAX_WIDTH = 1284;
    const _12_MAX_HEIGHT = 2778;

    const _14_WIDTH = 1179;
    const _14_HEIGHT = 2556;

    const _14_PRO_WIDTH = 1290;
    const _14_PRO_HEIGHT = 2796;

    if (!Platform.isIOS) return false;
    if ((window.physicalSize.width == X_WIDTH && window.physicalSize.height == X_HEIGHT) ||
        (window.physicalSize.width == X_HEIGHT && window.physicalSize.height == X_WIDTH)) {
      return true;
    }
    if ((window.physicalSize.width == XR_WIDTH && window.physicalSize.height == XR_HEIGHT) ||
        (window.physicalSize.width == XR_HEIGHT && window.physicalSize.height == XR_WIDTH)) {
      return true;
    }

    if ((window.physicalSize.width == XSMax_WIDTH && window.physicalSize.height == XSMax_HEIGHT) ||
        (window.physicalSize.width == XSMax_HEIGHT && window.physicalSize.height == XSMax_WIDTH)) {
      return true;
    }
    if ((window.physicalSize.width == _12_WIDTH && window.physicalSize.height == _12_HEIGHT) ||
        (window.physicalSize.width == _12_HEIGHT && window.physicalSize.height == _12_WIDTH)) {
      return true;
    }
    if ((window.physicalSize.width == _12_MAX_WIDTH && window.physicalSize.height == _12_MAX_HEIGHT) ||
        (window.physicalSize.width == _12_MAX_HEIGHT && window.physicalSize.height == _12_MAX_WIDTH)) {
      return true;
    }

    if ((window.physicalSize.width == _14_WIDTH && window.physicalSize.height == _14_HEIGHT) ||
        (window.physicalSize.width == _14_HEIGHT && window.physicalSize.height == _14_WIDTH)) {
      return true;
    }

    if ((window.physicalSize.width == _14_PRO_WIDTH && window.physicalSize.height == _14_PRO_HEIGHT) ||
        (window.physicalSize.width == _14_PRO_HEIGHT && window.physicalSize.height == _14_PRO_WIDTH)) {
      return true;
    }

    return false;
  }

  @Deprecated('无字体，不要使用')
  static String get numFontFamily {
    return 'NunitoSans';
  }

  @Deprecated('无字体，不要使用')
  static String get englishFamily {
    return 'BalooBhaijaanRegular';
  }

  @Deprecated('无字体，不要使用')
  // 用于金钱显示
  static String get dollarFontFamily {
    return 'AntonRegular';
  }

  @Deprecated('无字体，不要使用')
  static String get gilroyBoldFamily {
    return 'GilroyBold';
  }

  @Deprecated('无字体，不要使用')
  static String get dinCondFontFamily {
    return 'DINCond';
  }
}
