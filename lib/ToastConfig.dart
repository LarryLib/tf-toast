import 'package:flutter/material.dart';

class ToastData {
  Color backgroundColor;
  String title;
  TextStyle titleStyle;
  String subTitle;
  TextStyle subTitleStyle;
  String imgResource;
  double duration; //  s

  ToastData(
    Color backgroundColor,
    String title,
    TextStyle titleStyle,
    String subTitle,
    TextStyle subTitleStyle,
    String imgResource,
    double duration,
  ) {
    this.backgroundColor = backgroundColor;
    this.title = title;
    this.titleStyle = titleStyle;
    this.subTitle = subTitle;
    this.subTitleStyle = subTitleStyle;
    this.imgResource = imgResource;
    this.duration = duration;
  }

  static final shared = ToastData(
    Colors.black12,
    null,
    TextStyle(fontSize: 18),
    null,
    TextStyle(fontSize: 12),
    '',
    2.5,
  );

  ToastData clone({
    Color backgroundColor,
    String title,
    TextStyle titleStyle,
    String subTitle,
    TextStyle subTitleStyle,
    String imgResource,
    double imgWidth,
    double imgHeight,
    double duration,
  }) =>
      ToastData(
        backgroundColor ?? this.backgroundColor,
        title ?? this.title,
        titleStyle ?? this.titleStyle,
        subTitle ?? this.subTitle,
        subTitleStyle ?? this.subTitleStyle,
        imgResource ?? this.imgResource,
        duration ?? this.duration,
      );
}

enum ToastShowType {
  normal,
  loading,
  fail,
  success,
}

final sToastConfig = ToastConfig._();

class ToastConfig {
  //  屏幕背景色
  Color _backgroundColor = Colors.black.withAlpha(20);

  Color get backgroundColor => _backgroundColor;

  setBackgroundColor(Color value) => _backgroundColor = value;

  //  提示框：最大宽度宽度-占比
  double _widthRatio = 0.5;

  double get widthRatio => _widthRatio;

  setWidthRatio(double value) => _widthRatio = value;

  //  提示框：最大高度宽度-占比
  double _heightRatio = 0.5;

  double get heightRatio => _heightRatio;

  setHeightRatio(double value) => _heightRatio = value;

  //  提示框：最大高度宽度-占比
  double _imgWidth = 60.0;

  double get imgWidth => _imgWidth;

  setImgWidth(double value) => _imgWidth = value;

  //  提示框：默认支持 list
  Map<ToastShowType, ToastData> _defaultList = {
    ToastShowType.normal: ToastData.shared,
    ToastShowType.loading: ToastData.shared.clone(
      duration: 0,
    ),
    ToastShowType.fail: ToastData.shared.clone(
      imgResource: 'images/fail.png',
    ),
    ToastShowType.success: ToastData.shared.clone(
      imgResource: 'images/success.png',
    ),
  };

  setDefaultList(ToastShowType type, ToastData value) =>
      _defaultList[type] = value;

  ToastData getDefaultToastData(ToastShowType type) =>
      _defaultList[type ?? ToastShowType.normal];

  //  init
  ToastConfig._() {}
}
