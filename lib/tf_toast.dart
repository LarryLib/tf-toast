import 'dart:async';

import 'package:flutter/services.dart';

class TfToast {
  static const MethodChannel _channel =
      const MethodChannel('tf_toast');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
