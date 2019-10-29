import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tf_toast/Toast.dart';
import 'package:tf_toast/ToastConfig.dart';

class TestToastPage extends StatefulWidget {
  @override
  _TestToastPageState createState() => _TestToastPageState();
}

class _TestToastPageState extends State<TestToastPage> {
  var list = [
    ToastShowType.normal,
    ToastShowType.loading,
    ToastShowType.fail,
    ToastShowType.success,
  ];
  var index = 0;

  setIndex(int value) {
    setState(() {
      index = value;
    });
  }

  @override
  void initState() {
    super.initState();
    setIndex(0);
    resetDefaultToast();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TestProviderPage"),
        actions: <Widget>[
          FlatButton(
            child: Text(
              '切换"Type"',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
            onPressed: () {
              setIndex((index == list.length - 1) ? 0 : index + 1);
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Text(
              list[index].toString().replaceAll('ToastShowType.', ''),
              style: TextStyle(
                color: Colors.green,
                fontSize: 20,
              ),
            ),
          ),
          FlatButton(
            child: Text('img'),
            onPressed: () {
              show(
                imgResource: 'images/test.png',
              );
            },
          ),
          FlatButton(
            child: Text('title'),
            onPressed: () {
              show(
                title: 'title',
              );
            },
          ),
          FlatButton(
            child: Text('subTitle'),
            onPressed: () {
              show(
                subTitle: 'subTitle',
              );
            },
          ),
          FlatButton(
            child: Text('img-title'),
            onPressed: () {
              show(
                imgResource: 'images/test.png',
                title: 'title',
              );
            },
          ),
          FlatButton(
            child: Text('img-subtitle'),
            onPressed: () {
              show(
                imgResource: 'images/test.png',
                subTitle: 'subtitle',
              );
            },
          ),
          FlatButton(
            child: Text('title-subtitle'),
            onPressed: () {
              show(
                title: 'title',
                subTitle: 'subTitle',
              );
            },
          ),
          FlatButton(
            child: Text('img-title-subtitle'),
            onPressed: () {
              show(
                imgResource: 'images/test.png',
                title: 'title',
                subTitle: 'subTitle',
              );
            },
          ),
        ],
      ),
    );
  }

  show({
    Color backgroundColor,
    String title,
    TextStyle titleStyle,
    String subTitle,
    TextStyle subTitleStyle,
    String imgResource,
    double imgWidth,
    double imgHeight,
    double duration,
  }) {
    switch (list[index]) {
      case ToastShowType.normal:
        Toast.show(
          context,
          backgroundColor: backgroundColor,
          title: title,
          titleStyle: titleStyle,
          subTitle: subTitle,
          subTitleStyle: subTitleStyle,
          imgResource: imgResource,
          duration: duration,
        );
        break;
      case ToastShowType.loading:
        Toast.loading(
          context,
          backgroundColor: backgroundColor,
          title: title,
          titleStyle: titleStyle,
          subTitle: subTitle,
          subTitleStyle: subTitleStyle,
//          imgResource: imgResource,
          duration: duration,
        );
        break;
      case ToastShowType.fail:
        Toast.fail(
          context,
          backgroundColor: backgroundColor,
          title: title,
          titleStyle: titleStyle,
          subTitle: subTitle,
          subTitleStyle: subTitleStyle,
//          imgResource: imgResource,
          duration: duration,
        );
        break;
      case ToastShowType.success:
        Toast.success(
          context,
          backgroundColor: backgroundColor,
          title: title,
          titleStyle: titleStyle,
          subTitle: subTitle,
          subTitleStyle: subTitleStyle,
//          imgResource: imgResource,
          duration: duration,
        );
        break;
      default:
        break;
    }

    //  如果是loading，则定时返回
    if (list[index] == ToastShowType.loading)
      Future.delayed(Duration(milliseconds: 2500)).then((value) {
        Toast.dismiss();
//        show(title: '${DateTime.now().toString()}', subTitle: 'aaa');
      });
  }

  resetDefaultToast() {
//    sToastConfig.setDefaultList(
//      ToastShowType.normal,
//      ToastData.shared.clone(
//        imgResource: 'images/tabbar_test.png',
//        title: 'normal-title',
//        subTitle: 'normal-subtitle',
//      ),
//    );
//    sToastConfig.setDefaultList(
//      ToastShowType.loading,
//      ToastData.shared.clone(
//        title: '加载中',
//        subTitle: '加载中简介',
//        loadingUseIndicator: true,
//      ),
//    );
//    sToastConfig.setDefaultList(
//      ToastShowType.fail,
//      ToastData.shared.clone(
//        imgResource: 'images/tabbar_test.png',
//        title: '失败',
//        subTitle: '失败简介',
//      ),
//    );
//    sToastConfig.setDefaultList(
//      ToastShowType.success,
//      ToastData.shared.clone(
//        imgResource: 'images/tabbar_test.png',
//        title: '成功',
//        subTitle: '成功简介',
//      ),
//    );
  }
}
