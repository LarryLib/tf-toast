import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tf_toast/tf_toast.dart';

void main() {
  const MethodChannel channel = MethodChannel('tf_toast');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await TfToast.platformVersion, '42');
  });
}
