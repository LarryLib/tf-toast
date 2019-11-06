import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ToastConfig.dart';

class Toast {
  static OverlayEntry _overlayEntry;

  static Timer _countdownTimer;

  static _setShowState(bool value, {double duration}) {
    if (_countdownTimer != null) {
      _countdownTimer.cancel();
      _countdownTimer = null;
    }
    if (duration != null && duration > 0) {
      _countdownTimer = Timer.periodic(
          Duration(milliseconds: (duration * 1000).toInt()), (timer) {
        if (_overlayEntry != null) dismiss();
      });
    }
  }

  static show(
    BuildContext context, {
    Color backgroundColor,
    String title,
    TextStyle titleStyle,
    String subTitle,
    TextStyle subTitleStyle,
    String imgResource,
    double duration,
    ToastShowType type, //    ToastShowType.loading
  }) async {
    _setShowState(true, duration: duration ?? 2.5);

    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }

    var toast = sToastConfig.getDefaultToastData(type);

    _overlayEntry = _createOverlayEntry(
      backgroundColor: backgroundColor ?? toast.backgroundColor,
      title: title ?? toast.title,
      titleStyle: titleStyle ?? toast.titleStyle,
      subTitle: subTitle ?? toast.subTitle,
      subTitleStyle: subTitleStyle ?? toast.subTitleStyle,
      img: _hudImg(imgResource, type),
    );
    Overlay.of(context).insert(_overlayEntry);
  }

  static loading(
    BuildContext context, {
    Color backgroundColor,
    String title,
    TextStyle titleStyle,
    String subTitle,
    TextStyle subTitleStyle,
    String imgResource,
    double duration,
  }) async {
    var toast = sToastConfig.getDefaultToastData(ToastShowType.loading);
    await show(
      context,
      backgroundColor: backgroundColor ?? toast.backgroundColor,
      title: title ?? toast.title,
      titleStyle: titleStyle ?? toast.titleStyle,
      subTitle: subTitle ?? toast.subTitle,
      subTitleStyle: subTitleStyle ?? toast.subTitleStyle,
      imgResource: imgResource ?? toast.imgResource,
      duration: duration ?? toast.duration,
      type: ToastShowType.loading,
    );
  }

  static fail(
    BuildContext context, {
    Color backgroundColor,
    String title,
    TextStyle titleStyle,
    String subTitle,
    TextStyle subTitleStyle,
    String imgResource,
    double duration,
  }) async {
    var toast = sToastConfig.getDefaultToastData(ToastShowType.fail);
    await show(
      context,
      backgroundColor: backgroundColor ?? toast.backgroundColor,
      title: title ?? toast.title,
      titleStyle: titleStyle ?? toast.titleStyle,
      subTitle: subTitle ?? toast.subTitle,
      subTitleStyle: subTitleStyle ?? toast.subTitleStyle,
      imgResource: imgResource ?? toast.imgResource,
      duration: duration ?? toast.duration,
      type: ToastShowType.fail,
    );
  }

  static success(
    BuildContext context, {
    Color backgroundColor,
    String title,
    TextStyle titleStyle,
    String subTitle,
    TextStyle subTitleStyle,
    String imgResource,
    double duration,
  }) async {
    var toast = sToastConfig.getDefaultToastData(ToastShowType.success);
    await show(
      context,
      backgroundColor: backgroundColor ?? toast.backgroundColor,
      title: title ?? toast.title,
      titleStyle: titleStyle ?? toast.titleStyle,
      subTitle: subTitle ?? toast.subTitle,
      subTitleStyle: subTitleStyle ?? toast.subTitleStyle,
      imgResource: imgResource ?? toast.imgResource,
      duration: duration ?? toast.duration,
      type: ToastShowType.success,
    );
  }

  static OverlayEntry _createOverlayEntry({
    Color backgroundColor,
    String title,
    TextStyle titleStyle,
    String subTitle,
    TextStyle subTitleStyle,
    Widget img,
  }) {
    return OverlayEntry(
      builder: (context) {
        var width = MediaQuery.of(context).size.width;
        var height = MediaQuery.of(context).size.height;

        var img_b = img != null;
        var title_b = title != null && title.length > 0;
        var subTitle_b = subTitle != null && subTitle.length > 0;

        //  内容
        final titleTextPainter = TextPainter(
          textDirection: TextDirection.ltr,
          text: TextSpan(
            text: title ?? '',
            style: titleStyle ?? null,
          ),
        );
        titleTextPainter.layout();

        final subTitleTextPainter = TextPainter(
          textDirection: TextDirection.ltr,
          text: TextSpan(
            text: subTitle ?? '',
            style: subTitleStyle ?? null,
          ),
        );
        subTitleTextPainter.layout();

        var textHorizontal = 10.0;
        var textVertical = 10.0;
        var contentWidth = titleTextPainter.width > subTitleTextPainter.width
            ? titleTextPainter.width + 2 * textHorizontal
            : subTitleTextPainter.width + 2 * textHorizontal;
        var contentHeight = titleTextPainter.height *
                (titleTextPainter.width / contentWidth + 1) +
            subTitleTextPainter.height *
                (subTitleTextPainter.width / contentWidth + 1) +
            ((img_b && (title_b || subTitle_b)) ? 60 : 0) +
            (title_b ? textVertical : 0) +
            (subTitle_b ? textVertical : 0);

        //  极限尺寸("最小"暂不提到ToastConfig)
        var minWidth = 80.0;
        var minHeight = 80.0;
        var maxWidth = width * sToastConfig.widthRatio;
        var maxHeight = width * sToastConfig.heightRatio;

        //  调整最小宽度
        if (img_b && (title_b || subTitle_b)) minWidth *= 2.0;

        if (contentWidth < minWidth) contentWidth = minWidth;
        if (contentWidth > maxWidth) contentWidth = maxWidth;

        if (contentHeight < minHeight) contentHeight = minHeight;
        if (contentHeight > maxHeight) contentHeight = maxHeight;

        var margin = EdgeInsets.symmetric(
          horizontal: (width - contentWidth) * 0.5,
          vertical: (height - contentHeight) * 0.5,
        );

        return AnimatedOpacity(
          opacity: 1.0,
          duration: Duration(milliseconds: 200),
          child: Container(
            alignment: Alignment.center,
            width: width,
            height: height,
            color: sToastConfig.backgroundColor,
            child: Card(
              color: backgroundColor ?? Colors.transparent,
              margin: margin,
              clipBehavior: Clip.hardEdge,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                alignment: Alignment.center,
                constraints: BoxConstraints(
                  minWidth: minWidth,
                  minHeight: minWidth,
                ),
                child: Wrap(
                  children: <Widget>[
                    if (img_b)
                      Container(
                        alignment: Alignment.center,
                        height: sToastConfig.imgWidth,
                        child: img,
                      ),
                    if (title_b)
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(
                          top: textVertical * 0.5,
                          left: textHorizontal,
                          right: textHorizontal,
                          bottom: textVertical * 0.5,
                        ),
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style: titleStyle ?? null,
                        ),
                      ),
                    if (subTitle_b)
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(
                          top: textVertical * 0.5,
                          left: textHorizontal,
                          right: textHorizontal,
                          bottom: textVertical * 0.5,
                        ),
                        child: Text(
                          subTitle,
                          maxLines: 3,
                          textAlign: TextAlign.center,
                          style: subTitleStyle ?? null,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static Widget _hudImg(String imgResource, ToastShowType type) {
    if (imgResource != null && imgResource.length > 0) {
      return Image.asset(
        imgResource,
        width: sToastConfig.imgWidth * 0.5,
        height: sToastConfig.imgWidth * 0.5,
      );
    } else if (type != null) {
      switch (type) {
        case ToastShowType.loading:
          return CupertinoActivityIndicator(radius: 18.0);
          break;
        case ToastShowType.fail:
          return Icon(
            Icons.close,
            color: Colors.white,
            size: 45.0,
          );
          break;
        case ToastShowType.success:
          return Icon(
            Icons.check,
            color: Colors.white,
            size: 45.0,
          );
          break;
        default:
          break;
      }
    }
    return null;
  }

  static void dismiss() async {
    _setShowState(false);
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
