import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uhf2new/method/uhf2new_method_channel.dart';

void main() {
  MethodChannelUhf2new platform = MethodChannelUhf2new();
  const MethodChannel channel = MethodChannel('uhf2new');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
