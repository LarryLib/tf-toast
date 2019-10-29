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
    bool loadingUseIndicator = false,
  }) async {
    print('duration === ${duration}');
    _setShowState(true, duration: duration ?? 2.5);

    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }

    _overlayEntry = _createOverlayEntry(
      loadingUseIndicator,
      ToastData(
        backgroundColor,
        title,
        titleStyle,
        subTitle,
        subTitleStyle,
        imgResource,
        duration ?? 2.5,
      ),
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
      loadingUseIndicator: true,
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
      loadingUseIndicator: false,
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
      loadingUseIndicator: false,
    );
  }

  static OverlayEntry _createOverlayEntry(bool loadingUseIndicator, ToastData toastData) {
    return OverlayEntry(
      builder: (context) {
        var width = MediaQuery.of(context).size.width;
        var height = MediaQuery.of(context).size.height;

        var b1 = loadingUseIndicator ||
            (toastData.imgResource != null && toastData.imgResource.length > 0);
        var b2 = toastData.title != null && toastData.title.length > 0;
        var b3 = toastData.subTitle != null && toastData.subTitle.length > 0;

        //  内容
        final titleTextPainter = TextPainter(
          textDirection: TextDirection.ltr,
          text: TextSpan(
            text: toastData.title ?? '',
            style: toastData.titleStyle ?? null,
          ),
        );
        titleTextPainter.layout();

        final subTitleTextPainter = TextPainter(
          textDirection: TextDirection.ltr,
          text: TextSpan(
            text: toastData.subTitle ?? '',
            style: toastData.subTitleStyle ?? null,
          ),
        );
        subTitleTextPainter.layout();

        var textHorizontal = 10.0;
        var textVertical = 10.0;
        var contentWidth = titleTextPainter.width > subTitleTextPainter.width
            ? titleTextPainter.width + 2 * textHorizontal
            : subTitleTextPainter.width + 2 * textHorizontal;
        var contentHeight = titleTextPainter.height +
            subTitleTextPainter.height +
            ((b1 && (b2 || b3)) ? 60 : 0) +
            (b2 ? textVertical : 0) +
            (b3 ? textVertical : 0);

        //  极限尺寸(暂不提到ToastConfig)
        var minWidth = 80.0;
        var minHeight = 80.0;
        var maxWidth = width * sToastConfig.widthRatio;
        var maxHeight = width * sToastConfig.heightRatio;

        //  调整最小宽度
        if (b1 && (b2 || b3)) minWidth *= 2.0;

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
              color: toastData.backgroundColor ?? Colors.transparent,
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
                    if (b1)
                      Container(
                        alignment: Alignment.center,
                        height: sToastConfig.imgWidth,
                        child: (loadingUseIndicator)
                            ? CupertinoActivityIndicator(radius: 18.0)
                            : Image.asset(
                                toastData.imgResource,
                                width: sToastConfig.imgWidth * 0.5,
                                height: sToastConfig.imgWidth * 0.5,
                              ),
                      ),
                    if (b2)
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(
                          top: textVertical * 0.5,
                          left: textHorizontal,
                          right: textHorizontal,
                          bottom: textVertical * 0.5,
                        ),
                        child: Text(
                          toastData.title,
                          textAlign: TextAlign.center,
                          style: toastData.titleStyle ?? null,
                        ),
                      ),
                    if (b3)
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(
                          top: textVertical * 0.5,
                          left: textHorizontal,
                          right: textHorizontal,
                          bottom: textVertical * 0.5,
                        ),
                        child: Text(
                          toastData.subTitle,
                          maxLines: 3,
                          textAlign: TextAlign.center,
                          style: toastData.subTitleStyle ?? null,
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

  static void dismiss() async {
    _setShowState(false);
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
